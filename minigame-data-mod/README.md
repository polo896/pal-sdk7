# Мини-игры лоченных сундуков — мод «на одних данных» (без C++, без кита, без компилятора)

Разведка по твоему дампу (`FModel-PalSchema-dump-partly` + `CXXHeaderDump-sdk-ue4ss`)
показала: сложность трёх мини-игр из четырёх — это **чистые данные** в трёх ассетах.
Правишь числа в UAssetGUI → repak → готово. Инструменты: FModel (есть),
UAssetGUI (~10 МБ), repak (есть), AES-ключ (есть).

## Что где лежит (проверено по дампу)

| Мини-игра | Ассет | Что править |
|---|---|---|
| Рулетка (GaugeStop) | `Pal/Content/Pal/Blueprint/MapObject/Object/LevelObject/LockedObstacle/MiniGamePacks/BP_LevelGimmickMiniGamePack_GaugeStop001` | CDO: `GaugeRangePercent` **8.0 → 100.0**, `GaugeEndPercent` **90.0 → 50.0**, (опц.) `CursorPercentSpeed` **66.0 → 10.0** |
| Отмычка (Picking) | `Pal/Content/Pal/DataTable/PickingGame/DT_PalPickingGameSettings` | Rows → во всех рядах `UnlockableRangeSize` → **1.0** (Normal=0.1, Hard=0.01, VeryHard=0.05, VeryEasy=0.2) |
| Росчерк (OneStroke) | `Pal/Content/Pal/DataAsset/OneStrokeGame/DA_OneStrokeMinigameData` | Map `GameSettings`: у ВСЕХ ключей `GridSize→2`, `StartPosition→(0,0)`, `GoalPosition→(1,0)`, `ObstaclePositions→пусто`. **Руками в UAssetGUI это не сделать (массив не очищается) — готовые файлы уже собраны: `onestroke-patch/patched/`, см. ниже** |
| PalFight (замок «убей палов») | — | Данными НЕ лечится: у `BP_PalLevelObject_LockGimmickPalFight` нет числового пака (только TriggerSphere/Spline/`OnPalSpawnedAndInitialized`). Скип = только кит-маршрут (правка графа BP), если захочешь позже. |

Минимум для росчерка — ключи, реально висящие на сундуках: `Normal_0` (базовый пак)
и `Easy_1`…`Easy_15` (паки Easy001–015). Рекомендую пройти все 30 ключей в карте —
застрахуешься от прочих расстановок.

## Почему это работает

- **Рулетка**: виджет `WBP_SalvageGame_GaugeStopMiniGame` держит зону успеха в
  переменной `SuccessAngleRange {Min, Max}`, а `SetupRouletteSetting` заполняет её
  из пака: `GaugeEndPercent` (центр/край зоны) + `GaugeRangePercent` (ширина).
  При End=50/Range=100 зона — минимум половина шкалы при любой семантике
  (центрированной или смещённой); стрелку можно ещё и замедлить.
- **Отмычка**: `BP_PalPickingGameProcessor` через `SettingDataRowNameMap` берёт из
  `DT_PalPickingGameSettings` ряд по сложности, в ряду `UnlockableRangeSize` —
  размер «сладкой зоны» (Normal = 0.1 → 10% циферблата). Ставим 1.0 — зона
  везде. (Строка `Easy` в таблице девственно чистая: 0.0 и null-кривые — не трогай.)
- **Росчерк**: `DA_OneStrokeMinigameData` (PalOneStrokeGameDataAsset) — карта
  `Key → {GridSize, StartPosition, GoalPosition, ObstaclePositions}`.
  **Важно: правило победы — «обойти ВСЕ свободные клетки и закончить на цели»**
  (классический 一筆書き): у процессора есть `GetVisitedTileCount()` /
  `GetRequiredVisitCount()`, и все 30 оригинальных паззлов математически
  удовлетворяют условию существования гамильтонова пути (чётность цветов
  концов) — 30 из 30, это не совпадение. Поэтому НЕЛЬЗЯ просто поставить
  цель рядом со стартом — при нечётном числе клеток такой паззл станет
  нерешаемым (софтлок сундука). Правильная минимизация — сетка 2×2 и
  **полностью пустой список препятствий**.

### OneStroke: готовые файлы (руками править не нужно)

Ассет Palworld сохранён в формате **unversioned properties** (UE 5.1): перед
каждым набором полей идёт 16-битный заголовок-фрагмент «skip N / values M»,
нулевые поля в поток вообще не пишутся (только бит в маске), а пустой массив
препятствий кодируется битом маски. UAssetGUI это отображает, но очистить
массив препятствий в нём нельзя — поэтому файлы правятся скриптом.

**Что уже сделано** (папка `onestroke-patch/` этого репозитория):

- `patch_onestroke.py` — парсер+пересборщик формата (с проверкой всех 30
  записей по дампу FModel и контрольной перепарсировкой результата);
- `original/` — девственные файлы, выгруженные из игры (FModel → Export Raw
  Data);
- `patched/Pal/Content/DataAsset/OneStrokeGame/` — **готовые к установке
  пропатченные файлы**: все 30 ключей → `GridSize=2`, `Start=(0,0)`,
  `Goal=(1,0)`, `ObstaclePositions=[]` (пусто).

Установка: скопируй папку `Pal` из `onestroke-patch/patched/` в корень папки
мода `MyMinigameTweaks_P/` (получится
`MyMinigameTweaks_P/Pal/Content/DataAsset/OneStrokeGame/DA_OneStrokeMinigameData.uasset`
+ `.uexp`) → repak той же командой → pak в `Pal/Content/Paks/~mods/`.

Почему рецепт безопасен при ЛЮБОМ варианте подсчёта победы:
- «обойти все клетки и закончить на цели»: путь `(0,0)→(0,1)→(1,1)→(1,0)`
  обходит все 4 свободные клетки и кончается на цели (чётность сходится);
- «дойти до цели»: `(0,0)→(1,0)` — один ход;
- даже если игра считает требуемое число шагов как `GridSize² − длина массива
  препятствий`, пустой массив даёт 4 = все клетки — путь выше всё равно
  побеждает. Никаких «выносов препятствий за сетку» больше не нужно.

Технические детали формата (для потомков): см. docstring `patch_onestroke.py`
и `FUnversionedHeader` в UE (`CoreUObject/Private/Serialization/
UnversionedPropertySerialization.cpp`): фрагмент = `SkipNum(7 бит) |
HasZeroMask(1) | IsLast(1) | ValueNum(7)`; ключи карты — FName
`(Easy, N)` = `Easy_{N-1}`; экспорт-данные .uexp заканчиваются 4-байтовым
magic `0x9E2A83C1`; при смене размера данных правится `SerialSize` в таблице
экспортов .uasset (единственное изменение хедера).

## Пайплайн (как таймер-мод, только без редактора)

1. **FModel** → найти каждый из трёх ассетов → ПКМ → *Export Raw Data* —
   получишь пары `.uasset` + `.uexp`. (Заодно глянь, нет ли в
   `MiniGamePacks/` других `GaugeStop*` паков, кроме 001 — если есть, правь все.)
2. **UAssetGUI**: сверху Palworld + UE 5.1; *Utils → Import Mappings* — тот же
   `.usmap`, что подключён в FModel. File → Open:
   - `BP_LevelGimmickMiniGamePack_GaugeStop001.uasset` → в списке экспортов
     `Default__BP_LevelGimmickMiniGamePack_GaugeStop001_C` → Properties → числа;
   - `DT_PalPickingGameSettings.uasset` → Rows → `UnlockableRangeSize`;
   - `DA_OneStrokeMinigameData.uasset` — **НЕ открываем**: берём готовые файлы
     из `onestroke-patch/patched/` (массив препятствий в UAssetGUI не
     очищается, см. секцию OneStroke выше).
   - Save (папка с .uexp должна лежать рядом — UAssetGUI пишет оба файла).
3. **repak**: корень мода с суффиксом `_P`, внутри — зеркальная структура:
   ```text
   MyMinigameTweaks_P/
     Pal/Content/Pal/Blueprint/MapObject/Object/LevelObject/LockedObstacle/MiniGamePacks/BP_LevelGimmickMiniGamePack_GaugeStop001.uasset (+.uexp)
     Pal/Content/Pal/DataTable/PickingGame/DT_PalPickingGameSettings.uasset (+.uexp)
     Pal/Content/Pal/DataAsset/OneStrokeGame/DA_OneStrokeMinigameData.uasset (+.uexp)
   ```
   Сборка (папка начинается с `Pal\`, поэтому `-m` НЕ нужен — дефолтная точка
   монтирования repak и есть `../../../`):
   ```bat
   repak.exe pack MyMinigameTweaks_P MyMinigameTweaks_P.pak
   ```
   (если твоя версия repak не принимает имя пак позиционно —
   `repak.exe pack -o MyMinigameTweaks_P.pak MyMinigameTweaks_P`).
   **AES-ключ для СОЗДАНИЯ пак-мода не нужен** — ключом зашифрован игровой
   `Pal-Windows.pak`, он нужен только на ЧТЕНИЕ (FModel). Твой таймер-пак
   тоже собирался без ключа и работал. Файл `.uexp` обязан лежать рядом с
   `.uasset` — в пак попадают оба.
4. Pak → `Pal/Content/Paks/~mods/`. Имя с `_P` = патч-приоритет поверх
   игровых ассетов (для таймера было необязательно — там пути были новые,
   а для override — обязательно).

## Тест-чеклист

- Рулетка: останови стрелку в случайном месте → успех. ✓ подтверждено автором
- Отмычка: жми попытку в произвольном положении → успех.
- Росчерк: сетка 2×2 без препятствий → клик по старту → 3 хода крестом
  `(0,0)→(0,1)→(1,1)→(1,0)` → сундук открыт. (Файлы — готовые, из
  `onestroke-patch/patched/`.)

## Альтернатива: PalSchema (JSON-правки на ходу, без pak)

Проверено по докам и исходникам (Okaetsu/PalSchema, лицензия MIT):
- `raw/` — правка **UDataTable** по имени (отмычка: `DT_PalPickingGameSettings`);
- `blueprints/` — правка **CDO блюпринт-классов** (рулетка:
  `BP_LevelGimmickMiniGamePack_GaugeStop001_C` → `GaugeRangePercent`);
- **DataAsset росчерка (`DA_OneStrokeMinigameData`) НЕ поддерживается**:
  raw-загрузчик принимает только UDataTable, blueprint-загрузчик — только
  UBlueprintGeneratedClass (проверено: `PalRawTableLoader.cpp`,
  `PalBlueprintModLoader.cpp`).
- Требует сборку UE4SS из форка Okaetsu (`experimental-palworld`), со
  стандартной 3.0.1 не заработает; перед заменой UE4SS — бэкап папки.
- Релизы привязаны к эпохе версии игры (0.3.x — весна 2025, 0.4.x — лето 2025,
  0.5.x — зима 2025/26, 0.6.x — лето 2026); схемы генерятся из установленной
  игры кнопкой в GUI-консоли UE4SS.
- Бонус: авто-релоад JSON в живой игре — удобно для подбора значений отмычки.

Стратегия: PalSchema — быстрый слой для данных (отмычка/рулетка и любые
будущие датамоды); полный авто-скип всех мини-игр «как у автора» — только
виджет-мод через кит (см. `pmk-no-wwise/README.md`).
- PalFight — без изменений (ожидаемо).

## Заметки

- Правки не трогают графы — только сериализованные данные. Это тот же класс
  модов, что редактирование DataTable рецептов из гайда pwmodding (самый
  низкорисковый тип pak-модов).
- Отмычка/рулетка остаются «играбельными» (ты по-прежнему делаешь действие),
  просто непроигрываемыми — для Nexus это чище, чем автоскип.
- Значения в дампе — с твоей версии игры, так что расхождений быть не должно.
- Полный автоскип «в одно касание» и PalFight остаются на кит-маршруте
  (`pmk-no-wwise/README.md`): v143 v14.39 → BuildConfiguration.xml → сборка →
  правка графов виджетов.
