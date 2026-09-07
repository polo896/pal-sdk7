# Fast Travel Unlocker — DIAG (тестовый скрипт)

Нужен, когда основной мод молча «не работает»: он сам ничего не разблокирует,
а вываливает в `UE4SS.log` состояние игры и UE4SS.

Диагностика **пошаговая**: сначала только безопасное чтение, опасные вызовы —
отдельными командами. Каждый опасный вызов печатается так:

```
[EagleDiag] >>> ПЕРЕД ВЫЗОВОМ: OnTriggerInteract(Character, 26)
[EagleDiag] <<< ВЫЖИЛИ ПОСЛЕ: OnTriggerInteract(Character, 26) -> nil
```

Если игра упала — **последняя строка `>>>` в UE4SS.log и есть виновник**.

Команды:

| Команда | Что делает |
|---|---|
| `!eaglediag` | безопасная часть: наличие функций + **контрольная проверка** (несуществующий метод — чтобы понять, можно ли верить строкам `OK`), счётчики, чтение свойств |
| `!eaglediag rpc` | старый RPC `RequestUnlockFastTravelPoint_ToServer` на одной точке |
| `!eaglediag keys` | **РЕШАЮЩИЙ ТЕСТ**: какие ключи лежат в `FastTravelPointUnlockFlag` и какому полю статуи они соответствуют (`FastTravelPointID` или GUID `LevelObjectInstanceId`) |
| `!eaglediag flagmap` | `OnUpdateFlagMapRecord(FName Key, true)` — написан без struct-параметров |
| `!eaglediag interact` | симуляция нажатия F через `UPalInteractComponent` игрока (`StartTriggerInteract`) |
| `!eaglediag record` | struct-параметры на **чтение**: `GetRecordData_BoolCount` / `GetRecordData_Bool` — поддерживает ли ваш UE4SS структуры вообще |
| `!eaglediag brute` | перебор индикаторов `OnTriggerInteract(Other, 0..80)` — ищет, какой `N` реально открывает точку в вашей сборке |
| `!eaglediag announce` | тест `SendSystemAnnounce` (подозревался в краше основного мода) |
| `!eaglediag statue` | + `OnTriggerInteract(Character, 26)` на одной закрытой точке |
| `!eaglediag record` | + чтение RecordData через struct-параметры (**падает на части сборок UE4SS**) |
| `!eaglediag cutscene` | + `OnEndCutscene(...)` на одной точке (**эксперимент, может падать**) |
| `!eaglediag write` | + `SetRecordData_Bool_ForServer` (**может падать**) |
| `!eaglediag cosmetic` | + `bUnlocked = true` |
| `!eaglediag all` | всё подряд |
| `!eaglediag help` | список команд |

Что попадает в лог:

1. **Наличие классов/функций**
   * `Default__PalUtility`, `Default__PalPlayerRecordDataUtility`,
     `PalCutsceneBindParameter_FasttravelPoint`,
     `PalUnlockFastTravelTriggerEvent_RemoveSkyIslandCloud`;
   * есть ли ещё старый RPC `RequestUnlockFastTravelPoint_ToServer`
     (в 1.0.4 должен быть `ОТСУТСТВУЕТ` — если `OK`, значит патч другой);
   * методы статуи `OnTriggerInteract`, `OnEndCutscene`, `OnCompleteSyncPlayer`,
     `IsUnlocked`, `OnUpdateFlagMapRecord`;
   * `UPalLocationPointFastTravel.IsUnlockMapPoint`, `UPalLocationPoint.IsEnableFastTravel`;
   * `PalPlayerRecordDataUtility.SetRecordData_Bool_ForServer` / `GetRecordData_Bool`;
   * `UPalDebugSetting.bIgnoreFastTravelLock`.

2. **RecordData и ключи флагов**
   * через что получен `UPalPlayerRecordData` (`PalUtility::GetLocalRecordData`
     или `PalPlayerState::GetRecordData`);
   * поддерживает ли сборка UE4SS передачу struct-параметров
     (без этого прямая запись флага невозможна — будет напечатана ошибка);
   * сколько точек уже открыто (`GetRecordData_BoolCount`);
   * до 25 записей из `FastTravelPointUnlockFlag.Items` — **по ним видно, какими
     ключами игра реально помечает открытые точки** (это главное, если
     `FastTravelPointUnlockFlag` пишется, но `IsUnlocked()` остаётся false).

3. **Локейшены** — сколько `PalLocationPointFastTravel` и у скольких
   `IsEnableFastTravel() = true` (то, что реально даёт возможность переместиться).

4. **Тест способов на одной закрытой точке** — по очереди
   `OnEndCutscene`, `OnTriggerInteract(26)`, `SetRecordData_Bool_ForServer`,
   `bUnlocked = true`; по каждому печатается:
   `вызов ok/ошибка | IsUnlocked | флаг до | флаг после`.
   Итоговая строка говорит, какой способ выставил настоящий флаг (а не косметику).

## Что уже выяснено по логам

| Факт | Вывод |
|---|---|
| `obj[name]` возвращает `TrivialObject` даже для несуществующих имён | проверять наличие надо через `type(v) == "function"`; вызов несуществующего метода падает с `attempt to call a TrivialObject value` |
| `RequestUnlockFastTravelPoint_ToServer` → `attempt to call a TrivialObject value` | RPC выпилен, SDK прав |
| `OnTriggerInteract(Other, 0..80)` не открыл точку ни с `Character`, ни с `PlayerController` | путь сообщества в этой сборке мёртв |
| `SendSystemAnnounce` выжил | он не виновник краша |
| В `FastTravelPointUnlockFlag.Items` ключ вида `DDBBFFAF43D9219AE68DF98744DF0831` | ключ флага — это GUID в верхнем регистре (32 hex) |
| `OnUpdateFlagMapRecord(GUID_статуи, true)` → `IsUnlocked=true`, но `Items`=0 и `IsEnableFastTravel()`=false | ключ флага — GUID `LevelObjectInstanceId` в ВЕРХНЕМ регистре (подтверждено); сам вызов меняет только визуальное состояние |
| `!eaglediag write` → AV **writing** address 0x24 | struct-параметры в этом UE4SS не передаются |
| `OnEndCutscene` занял 75 мс вместо обычных 10 | разблокировка может быть АСИНХРОННОЙ: теперь каждый тест проверяется ещё раз через +1 / +3 / +6 с |

## Порядок, если ничего не открывается

1. `!eaglediag` — смотри строку **КОНТРОЛЬ**. Если несуществующий метод тоже `OK`,
   значит всем проверкам верить нельзя, и ориентироваться надо только на реальные
   вызовы. Если `ОТСУТСТВУЕТ` — проверки честные.
2. `!eaglediag rpc` — если старый RPC жив и открывает точку: в основном моде
   `!eagle method rpc`, потом `!collecteagle`.
3. `!eaglediag brute` — найдёт реальный номер индикатора, если в вашей сборке
   `UnlockFastTravel` уже не 26.
4. `!eaglediag cutscene` / `!eaglediag write` — остальные пути.
5. **Ручной опыт (самое ценное):** дойди пешком до любой статуи, открой её
   вручную клавишей F, затем выполни `!eaglediag`. В разделе
   `FastTravelPointUnlockFlag.Items` появится запись с настоящим ключом —
   именно его потом и надо писать через `!eagle method record`.

Лог: `Pal/Binaries/Win64/ue4ss/UE4SS.log`.
