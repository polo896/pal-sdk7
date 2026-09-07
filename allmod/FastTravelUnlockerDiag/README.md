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
| `!eaglediag` | безопасная часть: наличие функций, счётчики, чтение свойств |
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

Лог: `Pal/Binaries/Win64/ue4ss/UE4SS.log`.
