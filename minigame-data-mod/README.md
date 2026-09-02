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
| Росчерк (OneStroke) | `Pal/Content/Pal/DataAsset/OneStrokeGame/DA_OneStrokeMinigameData` | Map `GameSettings`: у всех ключей `GridSize→3`, `StartPosition→(1,1)`, `GoalPosition→(0,1)` (смежная!), `ObstaclePositions→пусто` |
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
  `Key → {GridSize, StartPosition, GoalPosition, ObstaclePositions}`. Старт,
  смежный с целью, без препятствий = победа одним ходом. Для образца: у
  `VeryEasy_0` сетка 3×3 без препятствий — берём её геометрию, но цель ставим
  вплотную к старту.

## Пайплайн (как таймер-мод, только без редактора)

1. **FModel** → найти каждый из трёх ассетов → ПКМ → *Export Raw Data* —
   получишь пары `.uasset` + `.uexp`. (Заодно глянь, нет ли в
   `MiniGamePacks/` других `GaugeStop*` паков, кроме 001 — если есть, правь все.)
2. **UAssetGUI**: сверху Palworld + UE 5.1; *Utils → Import Mappings* — тот же
   `.usmap`, что подключён в FModel. File → Open:
   - `BP_LevelGimmickMiniGamePack_GaugeStop001.uasset` → в списке экспортов
     `Default__BP_LevelGimmickMiniGamePack_GaugeStop001_C` → Properties → числа;
   - `DT_PalPickingGameSettings.uasset` → Rows → `UnlockableRangeSize`;
   - `DA_OneStrokeMinigameData.uasset` → Map `GameSettings` → значения ключей.
   - Save (папка с .uexp должна лежать рядом — UAssetGUI пишет оба файла).
3. **repak**: корень мода с суффиксом `_P`, внутри — зеркальная структура:
   ```text
   MyMinigameTweaks_P/
     Pal/Content/Pal/Blueprint/MapObject/Object/LevelObject/LockedObstacle/MiniGamePacks/BP_LevelGimmickMiniGamePack_GaugeStop001.uasset (+.uexp)
     Pal/Content/Pal/DataTable/PickingGame/DT_PalPickingGameSettings.uasset (+.uexp)
     Pal/Content/Pal/DataAsset/OneStrokeGame/DA_OneStrokeMinigameData.uasset (+.uexp)
   ```
   Собрать в pak твоим обычным `repak.exe create` (AES-ключ Palworld).
4. Pak → `Pal/Content/Paks/~mods/` (как таймер-мод). Имя с `_P` + позднее
   монтирование = ассеты перекрывают игровые.

## Тест-чеклист

- Рулетка: останови стрелку в случайном месте → успех.
- Отмычка: жми попытку в произвольном положении → успех.
- Росчерк: один шаг от старта → победа.
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
