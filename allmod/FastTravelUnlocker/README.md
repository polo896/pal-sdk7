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

Разблокировка идёт пачками (`UnlockBatchSize = 5`, пауза `UnlockBatchDelayMs = 250`):
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

Подключи мод `allmod/FastTravelUnlockerDiag` и напиши в чат `!eaglediag` — он
выведет в `UE4SS.log`, какие функции реально есть в сборке, поддерживает ли
UE4SS struct-параметры, какими ключами игра помечает открытые точки и какой из
способов реально выставляет флаг.
