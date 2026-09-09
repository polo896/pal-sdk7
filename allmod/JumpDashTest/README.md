# JumpDashTest — тестовый мод (UE4SS / Palworld)

Тестовая проверка механик перед интеграцией в основной мод.
**Цель теста** — убедиться, что три пассивки реально изменяются из Lua-мода
и что всё работает только при надетых предметах.

---

## Что делает

| Пассивка | Предметы (ID) | Что меняем | Ваниль | Как |
|---|---|---|---|---|
| `AirDash` (эффект 104) | Air Dash Boots / Double / Triple (`Accessory_AirDash1..3`), Air Walker Mk-I/II (`Accessory_JumpAir_1/2`), Mk-III/EX (`Accessory_SuperJumpAir_1/2`) | **дистанция** воздушного рывка (Ctrl в воздухе) | 400 см за 0.5 с | `Const_MoveDistance` у объекта действия `BP_ActionAirDashBase` в момент начала рывка |
| `JumpCount_Increase` (эффект 81) | Double/Triple/Quad Jump Boots (`Accessory_JumpCount_Increase1..3`), Air Walker | **число доп. прыжков** | +1/+2/+3 | `CharacterMovement.JumpMaxCount` |
| `JumpPower_Increase` (эффект 80) | Anti-Gravity Belt (`Accessory_JumpPower_Increase`) | **силу (высоту) прыжка** | +25% (x1.25) | свой множитель через `SetJumpZVelocityMultiplier("JumpDashTest", x)` |

**Ответ на вопрос из ТЗ:** у Jump Boots меняется только *количество* прыжков —
высота доп. прыжка в ванили отдельным параметром не существует (доп. прыжок
прыгает той же силой, что и обычный). Высоту меняет именно Anti-Gravity Belt
(пассивка `JumpPower_Increase`) — поэтому высота настраивается через пояс.

**Эффект «пружины» у рывка** сохраняется автоматически: кривая рывка
(`C_AirDashCurve_Location`) не трогается — она и так покрывает 90% дистанции
в первые 15% времени. Увеличивая дистанцию, мы пропорционально увеличиваем
скорость: `x10` = 40 метров за те же полсекунды, резкий «выстрел».
Импульс сохраняется в конец рывка (`bApplyFinishVelocityOnEndAction=true`),
так что разгон продолжится полётом на планере.

**Главное правило (по ТЗ):** всё применяется ТОЛЬКО когда у игрока активна
соответствующая пассивка. Снял предмет — мод возвращает ванильные значения.

---

## Установка

Скопировать папку `JumpDashTest` в `Pal/Binaries/Win64/Mods/` (рядом с другими
UE4SS-модами), чтобы получилось:

```
Pal/Binaries/Win64/Mods/JumpDashTest/enabled.txt
Pal/Binaries/Win64/Mods/JumpDashTest/config.txt
Pal/Binaries/Win64/Mods/JumpDashTest/Scripts/main.lua
```

Если UE4SS стоит иначе (Workshop-вариант) — папку туда, где лежат другие
рабочие моды; мод дополнительно ищет конфиг по нескольким путям
(см. `CONFIG_CANDIDATES` в `main.lua`).

## Конфиг — `config.txt`

```ini
Enabled = true            ; false = полное возвращение к ванили
AirDashDistanceMult = 5.0 ; 1.0 = ваниль (4 м); 10.0 = 40 м
AirDashTimeMult     = 1.0 ; 1.0 = ваниль (0.5 с); 0.5 = вдвое резче
ExtraJumpCount      = 5   ; доп. прыжки (Jump Boots); ваниль 1/2/3
JumpPowerMult       = 2.0 ; сила прыжка (пояс); 1.0 = ваниль; высота ~ x^2
```

## Команды в игровом чате (Enter)

```
!jd            — статус: пассивки, JumpMaxCount, множители, счётчики хуков
!jd help       — список команд
!jd on/off     — включить/выключить мод (мгновенный возврат к ванили)
!jd dash 10    — множитель дистанции рывка
!jd time 0.5   — множитель времени рывка
!jd jumps 8    — число доп. прыжков
!jd power 3    — множитель силы прыжка
!jd skills     — дамп всех активных пассивок игрока (тип, значение, row-имя)
!jd save       — записать текущие значения в config.txt
!jd reload     — перечитать config.txt
!jd debug      — вкл/выкл подробный лог
```

---

## Чеклист теста (что и как проверять)

В консоль UE4SS мод пишет всё с префиксом `[JumpDashTest]`.

1. **Вход в мир.** В консоли: `игрок найден: BP_Player_..._C` и
   `хук рывка зарегистрирован: ...BP_ActionAirDashBase...OnBeginAction`.
   Если «хук рывка: ЕЩЁ НЕТ» — скажи, что показывает `!jd`.
2. **Дэш.** Надень Air Dash Boots (или Air Walker), прыгни, нажми Ctrl в воздухе.
   Ожидание: рывок заметно длиннее (по умолчанию x5 = 20 м), в консоли
   `РЫВОК #N: дистанция 2000 см, время 0.50 с (x5.00)`.
   Сними ботинки — рывок снова становится ванильным микро-рывком.
3. **Доп. прыжки.** Надень Jump Boots → в консоли
   `ПРЫЖКИ: JumpMaxCount X -> 6 (JumpCount_Increase активна)`.
   В воздухе должно быть 6 прыжков (1+5). Сними —
   `ПРЫЖКИ: возврат к ванили, JumpMaxCount = 1`.
4. **Высота прыжка.** Надень Anti-Gravity Belt →
   `ПОЯС: наш множитель силы прыжка x2.00 применён`. Прыжок заметно выше
   (~x4 высоты). Сними — `ПОЯС: наш множитель сброшен до x1.00`.
5. **Катапульта.** Пояс + ботинки дэша: прыжок → в воздухе Ctrl (дэш по
   направлению) → планер. Настрой `!jd dash 10` и `!jd power 3` под себя.
6. **Без предметов.** Сними всё → `!jd` должен показать все пассивки `false`,
   JumpMaxCount = 1, поведение полностью ванильное.
7. **После теста** пришли мне: вывод `!jd` (статус) и `!jd skills`
   (в ботинках/поясе), плюс строки про `SetJumpZVelocityMultiplier` из консоли —
   по ним видно, как игра сама применяет пояс, и что оставить при интеграции.

## Важные нюансы (почему так сделано)

- **Хуки пассивок могут молчать.** `OnStartSkillEffect`/`OnEndSkillEffect` —
  нативные функции; если игра зовёт их напрямую (мимо ProcessEvent), хук не
  сработает. Это НЕ баг: модификации всё равно применит страховочный опрос
  (раз в `ReconcileMs`). Счётчики в `!jd` покажут, срабатывают ли хуки —
  при интеграции лишнее уберём.
- **Хук `SetJumpZVelocityMultiplier` — чисто диагностический** (пишет, как
  ваниль применяет множители прыжка). В финальную интеграцию не пойдёт.
- **Верховая езда.** Пока ты верхом на пале, мод не трогает JumpMaxCount
  (там своя логика прыжков у маунта).
- **Кооп.** Мод меняет параметры только локального игрока. На выделенном
  сервере UE4SS нужен на сервере (авторитетные объекты там).
- **Возможный отказ JumpMaxCount.** Если игра считает доп. прыжки не через
  `JumpMaxCount`, а внутри нативного кода по значению пассивки — количество
  прыжков не изменится (статус покажет JumpMaxCount=6, а прыжков по-прежнему
  ванильное число). Это как раз проверяет тест; запасной вариант — правка
  `Value` в `SkillInfos` — добавим по результатам.

## Точки внедрения (для будущей интеграции)

```
ХУК 1  /Game/Pal/Blueprint/Action/Common/BP_ActionAirDashBase.BP_ActionAirDashBase_C:OnBeginAction
ХУК 2  /Script/Pal.PalPassiveSkillComponent:OnStartSkillEffect   (опционально)
ХУК 3  /Script/Pal.PalPassiveSkillComponent:OnEndSkillEffect     (опционально)
ХУК 4  /Script/Pal.PalCharacterMovementComponent:SetJumpZVelocityMultiplier (только тест)
ХУК 5  /Script/Pal.PalUIChat:OnReceivedChat                      (только тест)
+ опрос Reconcile (единственная обязательная механика для прыжков)
```

Используемые данные из дампов:
`EPalPassiveSkillEffectType` (JumpPower_Increase=80, JumpCount_Increase=81,
AirDash=104), `BP_ActionAirDashBase` CDO (`Const_MoveDistance=400`,
`StepTime=0.5`), `UPalCharacterMovementComponent.SetJumpZVelocityMultiplier`,
`UCharacterMovementComponent.JumpMaxCount`, `UPalPassiveSkillComponent.HasSkill`.
