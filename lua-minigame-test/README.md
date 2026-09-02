# lua-minigame-test — тестовый UE4SS-Lua мод «авто-победа мини-игр»

**Статус: тестовый скрипт. НЕ интегрирован в основу** (`pmk-no-wwise/` и `minigame-data-mod/` не тронуты).
Заточен под **форк Okaetsu RE-UE4SS `experimental-palworld`** (UE4SS 3.x API). Стоковый UE4SS 3.0.1 тоже должен работать, но тестироваться будет на форке.

---

## Ответ на главный вопрос: можно ли через Lua все 3 игры? — ДА

Все три, и именно «как хотели»: **F → виджет ~1.2 с → сам закрывается → замок открыт**.
Механизм — не правка виджетов и не data-правки, а вызов **нативных функций завершения**, которые игра сама использует при честной победе. Мы лишь дёргаем их в нужный момент.

| Игра | Параметр (создаётся при старте мини-игры) | Вызов победы |
|---|---|---|
| Отмычка (Picking) | `PalHUDDispatchParameter_PickingMiniGame` | `param:OnReceiveSuccessPicking()` |
| Росчерк (OneStroke) | `PalHUDDispatchParameter_OneStrokeMiniGame` | `param:OnReceiveGameSuccess()` |
| Рулетка (GaugeStop) | `PalHUDDispatchParameter_GaugeStopMiniGame` | `param.Model:SendResult(true)`, fallback: `param:OnReceiveMiniGameResult(true)` |

Все три параметра — наследники `PalHUDDispatchParameter_LockGimmickMiniGame`, поэтому **один** `NotifyOnNewObject` ловит все три (наследование учитывается). Дублёр-триггер — хук `APalLevelObject_LockGimmickMiniGame:OnTriggerInteract` (каждое нажатие F на замке).

## Почему этот подход должен быть безопаснее прошлых Lua-попыток (4 краша, 0x338)

- вызываются **только нативные UFunction через ProcessEvent** — тот же канал, что в уже работающих модах (Relic Collector: `util:SendSystemAnnounce(...)`, PalWarp: куча вызовов);
- **ни одного чтения по оффсетам**, MemberVariableLayout не нужен;
- каждый вызов обёрнут в `pcall`; все хуки **только логируют** и не меняют поведение;
- активное действие ровно одно — вызов функции завершения мини-игры;
- регистрация хуков с ретраями (паттерн PalWarp: pcall + повтор через 3 с).

## Файлы

```
MinigameAutoWin/
  enabled.txt      — включение мода (пустой файл)
  scripts/
    main.lua       — весь код, настройки вверху файла (Config)
```

## Установка (2 минуты)

1. Скопировать папку `MinigameAutoWin` в `<Palworld>\Pal\Binaries\Win64\Mods\`
   → должно получиться `...\Mods\MinigameAutoWin\scripts\main.lua`.
2. Если моды у тебя включаются через `mods.txt` — добавить:
   ```
   MinigameAutoWin :
     Installed : 1
     Enabled : 1
   ```
   Иначе достаточно уже лежащего в папке `enabled.txt`.
3. Для чистого теста лучше временно убрать `MyMinigameTweaks_P.pak` из `~mods`
   (рулетку мод закроет и без него; вернёшь пак после теста).
4. Запустить игру, открыть консоль UE4SS (GUI). Должно появиться:
   ```
   [MinigameAutoWin] === MinigameAutoWin v0.1 (тест) загружен ===
   [MinigameAutoWin] хук ОК: ...            (×8 строк)
   [MinigameAutoWin] все регистрации завершены (попытка N) — мод готов
   ```

## Как это работает (цепочка в логе)

```
F на замке
 ├─ [hook] ЗАМОК: F-нажатие            (APalLevelObject_LockGimmickMiniGame:OnTriggerInteract)
 ├─ игра создаёт параметр мини-игры    (ловит NotifyOnNewObject, в логе «мини-игра началась: …»)
 ├─ ждём 1200 мс (Config.DelayMs)
 ├─ вызываем нативную функцию завершения (таблица выше)
 │   ├─ [hook] ОТМЫЧКА: успех / РОСЧЕРК: успех / РУЛЕТКА: результат
 │   ├─ [hook] ЗАМОК: OnMiniGameComplete … bMiniGameSuccess=true
 │   └─ [hook] RPC: успех на сервер    (RequestMiniGameSuccess_ToServer)
 └─ замок открыт, UI закрыт (если UI завис — через 900 мс мод попробует Close())
```

## Консольные команды (консоль UE4SS)

| Команда | Действие |
|---|---|
| `mgaw status` | режим / задержка / статистика / последний параметр |
| `mgaw observe` | только логи, ничего не вызываем |
| `mgaw autowin` | авто-победа (по умолчанию) |
| `mgaw win` | вручную выиграть последнюю открытую мини-игру (работает и в observe — удобно для точечного теста) |
| `mgaw delay 2000` | поменять задержку на лету |
| `mgaw picking off` / `mgaw gauge off` / `mgaw onestroke off` | вкл/выкл отдельную игру |

## Тест-протокол

**Шаг 1 — autowin (режим по умолчанию).**
Пройди по одной мини-игре каждого типа: дверь с отмычкой, датчик-рулетка, росчерк.
Успех = через ~1.2 с после открытия виджет закрылся сам, замок открылся, в логе цепочка из 3–4 `[hook]`-строк.

**Шаг 2 — если что-то не сработало или крашнуло.**
- Введи `mgaw observe`, пройди все 3 игры **честно** (по одной победе и одному провалу на каждую) — скрипт снимет реальную цепочку честной победы. Пришли лог → добавлю точный вызов в v0.2.
- При краше — последние строки лога перед крашем + какая именно игра.

**Что прислать:** копипаст/скрин консоли UE4SS от строки «мини-игра началась» до конца цепочки.

## Известные границы (v0.1)

- Покрыты LockGimmick-мини-игры (все паки `BP_LevelGimmickMiniGamePack_*`: отмычки дверей/сундуков, датчики-рулетка, все сложности росчерка).
- Сальваж сокровищниц через `PalHUDDispatchParameter_TreasureBoxSalvageGame` (другая ветка, без LockGimmick) **не покрыт** — если такой встретится, скажи: там добавляется один вызов `Model:SendResult(true)`.
- PalFight — отдельный этап, тут не трогаем.
- Правки `main.lua` требуют перезапуска игры.
- Мод ничего не пишет на диск и не меняет ассеты.

## Удаление

Снести `Mods\MinigameAutoWin` (+ строку из `mods.txt`, если добавлял).

## Происхождение имён функций (чтобы не думать, что взято с потолка)

- нативные стабы кита: `PalHUDDispatchParameter_{PickingMiniGame,OneStrokeMiniGame,GaugeStopMiniGame,LockGimmickMiniGame}.h`, `PalNetworkPlayerComponent.h` (`RequestMiniGameSuccess_ToServer`), `PalUIMapObjectTreasureBoxSalvageGameModel.h` (`SendResult(bool)`), `PalLevelObject_LockGimmickMiniGame.h` (`OnTriggerInteract`, `OnMiniGameComplete`, `CurrentParameter`);
- GObjects-дамп из живой игры: все используемые UFunction существуют;
- тип-дампы UE4SS + FModel-дамп: состав виджетов (`WBP_PickingGame02_ForDisplay_C`, `WBP_SalvageGame_GaugeStopMiniGame_C`, `WBP_OneStrokeGame_ForDisplay_C`) и графов.
