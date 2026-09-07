# Fast Travel Unlocker — разбор полёта после патча 1.0.4

## Симптом

```
[Lua] [EagleCollector] Mode [all]: Unlocked 174 fast travel points.
```
…и при этом ни одна точка не открылась.

## Причина (ровно одна строка кода)

```lua
pcall(function() playerNetwork:RequestUnlockFastTravelPoint_ToServer(keyParam) end)
```

`UPalNetworkPlayerComponent::RequestUnlockFastTravelPoint_ToServer` **выпилен из игры в 1.0.4.**
Проверено по SDK в этом репозитории:

| Где искали | Результат |
|---|---|
| `CXXHeaderDump/Pal.hpp` (класс `UPalNetworkPlayerComponent`, строка ~30467) | функции нет |
| `sdk-dumper-7/Pal_functions.cpp`, `Pal_parameters.hpp` | `RequestUnlockFastTravelPoint*` — нет ни одного упоминания |
| `sdk-dumper-7/FunctionsInfo.json` (все 29594 функции игры) | ни одного совпадения |
| `grep -rn "RequestUnlockFastTravelPoint"` по всему репозиторию | только `allmod/FastTravelUnlocker/Scripts/main.lua` |

В Lua вызов несуществующего метода — это `attempt to call a nil value`, ошибка
гасилась `pcall()`, а счётчик `totalUnlocked = totalUnlocked + 1` стоял **после**
вызова и увеличивался в любом случае. Отсюда честное с точки зрения кода, но
враньё по факту: «Unlocked 174».

Всё остальное, что делал старый мод, тоже не работало:

* `loc.ShouldUnlockFlag = true` — свойство `UPalLocationPointFastTravel` помечено
  `Net`, `Transient`, `EditConst` (`sdk-dumper-7/Pal_classes.hpp:47849`), т.е. это
  реплицируемое серверное поле, запись с клиента перезатрётся;
* `statue.bUnlocked = true` / `EnableRequestUnlock = true` — то же самое
  (`Pal_classes.hpp:45955`), плюс это не то, что реально хранит состояние;
* `!collecteaglemapclear` работал, потому что `BP_PalWorldMapUIData_C`
  (`MapMaskPaintSize`, `RemoveMaskByLocation`) в 1.0.4 не менялся.

## Где в 1.0.4 живёт «точка открыта» и как её открыть

Состояние хранится в данных игрока, а не в акторе статуи:

```
UPalPlayerRecordData::FastTravelPointUnlockFlag
    : FPalPlayerRecordDataRepInfoArrayThreadSafe_BoolVal   // FFastArraySerializer
        Items : TArray<FPalPlayerRecordDataRepInfoThreadSafe_BoolVal>  // {Key: FName, Value: bool}
```
(`CXXHeaderDump/Pal.hpp` строка ~32089; ключи — `FName`).
Оно же уезжает в сейв: `FPalLoggedinPlayerSaveDataRecordData::FastTravelPointUnlockFlag`.

Пишется оно сервером через
```cpp
UPalPlayerRecordDataUtility::SetRecordData_Bool_ForServer(
    const UObject* WorldContextObject,
    FPalPlayerRecordDataRepInfoArrayThreadSafe_BoolVal& RecordData,
    const FName Key, const bool bValue);          // static, BlueprintCallable
```
(`CXXHeaderDump/Pal.hpp` строка 32209, `Pal_functions.cpp:37083`)

А вся разблокировка конкретной статуи живёт в самом акторе:

```cpp
class APalLevelObjectUnlockableFastTravelPoint : public APalLevelObjectActor {
    void OnTriggerInteract(AActor* Other, EPalInteractiveObjectIndicatorType IndicatorType);
    void OnEndCutscene(UPalCutsceneBindParameter_FasttravelPoint* CutsceneParameter);
    void OnCompleteSyncPlayer(APalPlayerState* PlayerState);
    bool IsUnlocked() const;
};
```
(`CXXHeaderDump/Pal.hpp` строка 11736)

Ключевая константа — индикатор взаимодействия:
```cpp
enum class EPalInteractiveObjectIndicatorType {
    ...
    UnlockFastTravel = 26,     // Pal_enums.hpp:2403  (в 1.0.4 значение не изменилось)
    FastTravel       = 27,
    UnuseFastTravel  = 28,
```
Т.е. `statue:OnTriggerInteract(character, 26)` — это ровно «игрок нажал F у статуи».

## Режим по умолчанию — безопасный (после EXCEPTION_ACCESS_VIOLATION)

Первая версия фикса падала с `EXCEPTION_ACCESS_VIOLATION reading address 0x24`:
оба «умных» пути оказались опасны на части сборок UE4SS —

* передача `FPalPlayerRecordDataRepInfoArrayThreadSafe_BoolVal` (struct по ссылке)
  в `UPalPlayerRecordDataUtility` — UE4SS кладёт в параметры мусор/нули, нативный
  код deref'ает null;
* `OnEndCutscene(<свой BindParameter>)` — путь, которого в природе не существует
  (игра создаёт параметр и биндит делегат сама), часть хендлеров на нём падает.

Поэтому **по умолчанию включён ровно один путь** — тот, что давно и массово
используется Lua-модами (Nexus 795 и др.) и подтверждён SDK:

```
statue.EnableRequestUnlock = true
statue:OnTriggerInteract(playerCharacter, 26)   -- UnlockFastTravel
statue:OnCompleteSyncPlayer(playerState)
```

Всё остальное — **opt-in**, включается командой в чате, а не правкой файла:

| Команда | Что включает |
|---|---|
| `!eagle method interact` | (по умолчанию) только `OnTriggerInteract(26)` |
| `!eagle method cutscene` | `OnEndCutscene(<BindParameter>)` — эксперимент, может ронять игру |
| `!eagle method record` | прямая запись `FastTravelPointUnlockFlag` + проверка по флагу — может ронять игру |
| `!eagle method rpc` | старый RPC `RequestUnlockFastTravelPoint_ToServer` (в SDK 1.0.4 его нет, но в некоторых установленных сборках он ещё жив — см. `!eaglediag rpc`) |
| `!eagle method cosmetic` | вообще без вызовов в игру: только `bUnlocked = true` — чтобы понять, падает игра на вызовах статуи или нет |
| `!eagle method` | показать текущий режим |
| `!eagle verifystruct` | разовая проба: поддерживает ли ваш UE4SS struct-параметры (и отключит проверку, если нет) |

Проверка результата по умолчанию идёт через `IsUnlocked()` (без struct-вызовов).

## Что делает мод теперь

На каждую статую по очереди (порядок задаётся `CONFIG.PrimaryMethod`):

1. `statue:OnEndCutscene(<свой UPalCutsceneBindParameter_FasttravelPoint>)`
   — сразу дёргает хендлер завершения катсцены, без самой катсцены;
2. `statue:OnTriggerInteract(playerCharacter, 26)` — симуляция нажатия F;
3. прямая запись флага:
   `UPalPlayerRecordDataUtility::SetRecordData_Bool_ForServer(...)` с ключами
   `FastTravelPointID` и `LevelObjectInstanceId`;
4. косметика `bUnlocked = true` (визуал; в сейв не попадает).

После каждой попытки зовётся `statue:OnCompleteSyncPlayer(playerState)`, чтобы
статуя перечитала флаг из `RecordData`.

Главное отличие от старой версии: **результат проверяется**. Если доступно чтение
`RecordData` (нужна поддержка struct-параметров в UE4SS), мод проверяет именно
флаг `FastTravelPointUnlockFlag`, а не только `IsUnlocked()`:
`IsUnlocked() = true` при невыставленном флаге = косметика, и мод автоматически
пробует следующий способ. Итог по флагам печатается в лог:
`Подтверждение: флаг в RecordData выставлен у N точек, не подтверждён у M ...`.

`CONFIG.AnnounceInGame = false` — внутриигровые уведомления (`PalUtility::SendSystemAnnounce`)
по умолчанию выключены: по логам именно этот вызов ронял UE4SS сразу после старта
разблокировки. Включать только после проверки `!eaglediag announce`.

Каждые 25 точек печатается прогресс: `[all] прогресс: N/174 (открыто X, не открылось Y)`.

Разблокировка идёт пачками (`UnlockBatchSize = 3`, пауза `UnlockBatchDelayMs = 350`):
если скормить игре ~174 разблокировки в один кадр, она падает (это же и есть
причина массовых жалоб «мод крашит игру» у аналогичных скриптов).

## Команды

| Команда | Что делает |
|---|---|
| `!collecteagle` / `!eagle all` | открыть все загруженные точки |
| `!eagle statues` | только статуи (не `IsUnlockMapPoint()`) |
| `!eagle pillars` | только колонны/мап-поинты (`IsUnlockMapPoint()` = true) |
| `!collecteaglenoexp`, `!eagle all noexp`, `!eagle statues noexp`, `!eagle pillars noexp` | то же, но с `ExpRate = 0.0` на время разблокировки (иначе игра начисляет EXP за каждую точку) |
| `!collecteaglemapclear` | стереть туман войны (без изменений) |
| `!eagle verify` | посчитать, сколько статуй реально `IsUnlocked()` |
| `!eagle bypass` / `!eagle bypass off` | выключить/включить `UPalDebugSetting::bIgnoreFastTravelLock` (последний рубеж для соло: позволяет пользоваться перемещением даже без записи флагов, но в сейв не попадает) |
| `!restore` | вернуть `ExpRate` вручную |

## Ограничения

* Мод открывает только то, что загружено стримингом (World Partition): точек,
  которых нет в памяти, в списке не будет. Это ограничение любого Lua-мода.
* Соло / listen-server — основной режим. На выделенном сервере клиент не
  authority, и запись флага с клиента не пройдёт (мод это честно покажет в логе).

## Если что-то не так

Подключи мод `allmod/FastTravelUnlockerDiag` и напиши в чат `!eaglediag` (безопасный
режим), затем `!eaglediag statue`, и только если нужно — `!eaglediag record`.
Каждый опасный вызов обрамляется метками `>>> ПЕРЕД ВЫЗОВОМ` / `<<< ВЫЖИЛИ ПОСЛЕ`,
так что последняя строка `>>>` перед падением — это и есть виновник. Он
выведет в `UE4SS.log`, какие функции реально есть в сборке, поддерживает ли
UE4SS struct-параметры, какими ключами игра помечает открытые точки и какой из
способов реально выставляет флаг.
