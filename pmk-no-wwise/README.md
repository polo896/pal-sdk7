# PMK без Wwise (стаб-модуль AkAudio)

Патч для [PalworldModdingKit](https://github.com/localcc/PalworldModdingKit), убирающий
требование Wwise-плагина. После патча кит открывается в чистом UE 5.1 **без установки
Wwise и без полного Visual Studio 2022 IDE**.

## Почему это работает

Официальная вика требует Wwise 2021.1.11 + SDK + лаунчер. Но анализ всех 6679 файлов
`Source/` кита показывает:

- Wwise в коде кита представлен **только именами типов**: `UAkAudioEvent` (110 упоминаний),
  `UAkCallbackInfo` (12), `UAkComponent` (7), enum `EAkCallbackType` и делегат
  `FOnAkPostEventCallback`;
- **ни одного вызова** `AkGameplayStatics::` в .cpp нет — тела всех 6668 Pal-заглушек пустые;
- `Pal.Build.cs` уже подключает зависимость `"AkAudio"` — кит ждёт модуль с таким именем.

Значит, достаточно положить рядом с `Pal` собственный модуль `AkAudio` с пустыми классами
тех же имён — и весь кит компилируется, а cooked-ассеты игры, ссылающиеся на
`/Script/AkAudio.*`, продолжают резолвиться (ссылки не теряются!).

## Что делает патч

| # | Файл кита | Действие |
|---|-----------|----------|
| 1 | `Pal.uproject` | удаляется плагин `Wwise` (исчезает диалог *Missing Plugin 'Wwise'*), добавляется модуль `AkAudio` |
| 2 | `Source/AkAudio/` (новый) | 9 файлов стаба: `AkAudio.Build.cs`, пустые `UAkAudioEvent` / `UAkComponent` / `UAkCallbackInfo`, `EAkCallbackType`, `FOnAkPostEventCallback`, пустой класс `AkGameplayStatics` |
| 3 | `Config/DefaultGame.ini` | комментируются Wwise-строки (cook/stage-папки, секция `AkSettings` с путём к Wwise-проекту) |

Остальные 6668 файлов кита не трогаются вообще.

## Применение

```text
1. git clone https://github.com/localcc/PalworldModdingKit C:\PMK
   (если скачал ZIP — обязательно переименуй папку: убери суффикс "-main",
    путь держи коротким: C:\PMK, а не C:\Users\...\Downloads\PalworldModdingKit-main)
2. python patch_pmk.py "C:\PMK"
```

Скрипт создаст бэкапы (`Pal.uproject.bak`, `Config/DefaultGame.ini.bak`), повторный
запуск безопасен.

### Ручная установка (если Python нет)

1. Скопируй папку `Source/AkAudio` из этой папки в кит → `C:\PMK\Source\AkAudio\`.
2. В `Pal.uproject` удали блок:
   ```json
   {
       "Name": "Wwise",
       "Enabled": true
   },
   ```
3. Там же в массив `"Modules": [...]` добавь в конец (с запятой после предыдущей записи):
   ```json
   {
       "Name": "AkAudio",
       "Type": "Runtime",
       "LoadingPhase": "Default"
   }
   ```
4. В `Config/DefaultGame.ini` поставь `;` в начале строк с `/Wwise/WwiseTree`,
   `/Wwise/WwiseTypes`, `WwiseAudio` и всей секции `[/Script/AkAudio.AkSettings]`
   (в исходном файле это строки 117, 118, 124 и 175–202).

## Пререквизиты — минимум мусора

- **UE 5.1** — уже есть.
- **Компилятор MSVC v143 (14.39)** — единственное, что реально нужно докачать.
  Два способа, выбери один:

  **Способ А — если стоит Visual Studio 2026 (легче, без нового продукта).**
  Visual Studio Installer → строка VS 2026 → *Modify* → вкладка *Individual
  components* → в поиске набери `v143` → отметь
  **«MSVC v143 - VS 2022 C++ x64/x86 build tools (v14.39-17.9)»**
  (может называться «MSVC v143 - инструменты сборки VS 2022 С++ х64/х86
  (v14.39-17.9)»; пометка «не поддерживается/Out of support» — не страшна,
  это значит лишь, что Microsoft его больше не патчит).
  Это ~1–2 ГБ внутри уже установленной 2026: компилятор кладётся в
  `C:\Program Files\Microsoft Visual Studio\18\<edition>\VC\Tools\MSVC\14.39.33519`,
  отдельный продукт не появляется, удаляется снятием галочки.

  Почему именно v14.39: компонента v14.38-17.8 (рекомендация вики кита) в
  каталоге VS 2026 **нет** — Microsoft её выпилил. Порог в исходниках движка
  5.1 (`WindowsPlatformCompilerSetup.h`): `_MSC_VER > 1939` → значит 14.39 —
  максимум, который движок 5.1 принимает молча (14.40+ печатает безобидное
  сообщение, v145 из 2026 ломается на новом конформантном препроцессоре —
  ошибки C4668/C4067 в `ConcurrentLinearAllocator.h`). Брать надо именно
  «build tools x64/x86» — НЕ ARM и НЕ «Spectre-mitigated libs».
  Запасной вариант, если с 14.39 что-то пойдёт не так: v14.35-17.5
  (пин 14.35.32215).

  **Способ Б — standalone «Build Tools for Visual Studio 2022»** (~3–5 ГБ,
  отдельный продукт, живёт рядом с 2026, удаляется штатно). Качается с
  [visualstudio.microsoft.com/downloads](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022)
  (внизу страницы, «Build Tools for Visual Studio 2022»). В Installer →
  *Individual components*: **MSVC v143 — VS 2022 C++ x64/x86 build tools
  (любой v143, лучше v14.39-17.9)** и **Windows 10/11 SDK**.

  Если в логе сборки появится ругань на Windows SDK — добавь компонент
  «Windows 10 SDK (10.0.19041.0)» тем же способом.
- **.NET SDK 6.x** — если UBT пожалуется при сборке (обычно хватает встроенного в движок).

### BuildConfiguration.xml

Создай файл `%APPDATA%\Unreal Engine\UnrealBuildTool\BuildConfiguration.xml`
(пинует тулчейн MSVC к установленной версии v143 — без него UBT возьмёт
новейший v145 из 2026 и сборка упадёт):

```xml
<?xml version="1.0" encoding="utf-8" ?>
<Configuration xmlns="https://www.unrealengine.com/BuildConfiguration">
    <WindowsPlatform>
        <CompilerVersion>14.39.33519</CompilerVersion>
        <ToolchainVersion>14.39.33519</ToolchainVersion>
    </WindowsPlatform>
</Configuration>
```

`14.39.33519` — это имя папки, которую ставит компонент «MSVC v143
(v14.39-17.9)». Если после установки команда
`dir "C:\Program Files\Microsoft Visual Studio\18\Community\VC\Tools\MSVC"`
покажет другое имя (например `14.39.33xxx` другой ревизии) — впиши в XML
точно такое, как в папке.

Создать файл можно из cmd (путь именно в **Roaming**-AppData, не в Local):

```bat
mkdir "%APPDATA%\Unreal Engine\UnrealBuildTool"
notepad "%APPDATA%\Unreal Engine\UnrealBuildTool\BuildConfiguration.xml"
```

**Признак, что пин подхватился:** в начале ручной сборки строка
`Using Visual Studio 2022 14.39.33519 toolchain (...\VC\Tools\MSVC\14.39.33519)`.
Если там 14.50.x — файл не читается (не тот путь/имя). Если после пина выходит
«Visual Studio 2022 is installed, but is missing the C++ toolchain» — компонент
v143 из Способа А не установлен или в XML указано несуществующее имя папки.

## Запуск кита

1. Двойной клик `C:\PMK\Pal.uproject`.
2. *«Missing Pal Modules … rebuild now?»* → **Да**. Это норма: заглушки кита
   компилируются первый раз (~5–15 мин).
3. Диалога про Wwise больше не будет.
4. Если *«Pal could not be compiled»* — не гадай, а посмотри настоящую причину
   (см. «Диагностика» ниже): она всегда есть в логе UBT.

### Диагностика: почему «Pal could not be compiled»

Окно ошибки ничего не сообщает. Настоящая причина — в логе
`%LOCALAPPDATA%\UnrealBuildTool\Log.txt` (и в `<кит>\Saved\Logs\Pal.log`),
но быстрее запустить сборку руками в cmd — она напечатает всё в консоль:

```bat
"C:\Program Files\Epic Games\UE_5.1\Engine\Build\BatchFiles\Build.bat" PalEditor Win64 Development -Project="C:\PMK\Pal.uproject" -WaitMutex
```

(подставь свой путь к движку и киту). Успешная сборка заканчивается строкой
без `ERROR:` — после неё двойной клик по `Pal.uproject` открывает редактор,
модули уже собраны.

Типовые причины из лога/консоли:

| Что написано | Причина | Лечение |
|---|---|---|
| `Detected compiler newer than Visual Studio 2022...` + ошибки C4668/C4067 в `ConcurrentLinearAllocator.h` | UBT взял v145 из VS 2026 (по умолчанию выбирает новейший тулчейн), а его конформантный препроцессор ломает движковые заголовки | поставить v143 v14.39 (Способ А) + BuildConfiguration.xml с пином 14.39.33519. Само по себе сообщение «Detected compiler newer» — безобидный `#pragma message`, но с 14.39 оно не появится вовсе (порог в 5.1 — `_MSC_VER > 1939`) |
| `Visual Studio 2022 is installed, but is missing the C++ toolchain` / `UnrealBuildTool requires at minimum the MSVC 14.xx toolchain` | v143 не установлен или UBT не видит его в инсталляции | проверить, что компонент v14.39-17.9 реально стоит (папка `...\VC\Tools\MSVC\14.39.33519` существует), и что BuildConfiguration.xml лежит в `%APPDATA%\Unreal Engine\UnrealBuildTool\` |
| Ругань на Windows SDK (`windows.h not found`, `LNK1181` и т.п.) | нет SDK или UBT взял слишком новый | добавить «Windows 10 SDK (10.0.19041.0)» в Individual components |
| Вечное «modules need recompile» при каждом запуске | путь с суффиксом `-main` или второй открытый редактор | переименовать папку (короткий путь `C:\PMK`), закрыть другие копии редактора |
| `The following modules are missing or built with a different engine version` → Да → сразу ошибка | то же, что выше: падение UBT на первом же шаге | смотреть консоль ручной сборки |

## Ограничения стаба (честно)

- BP-ноды **вызова функций** Wwise (`AkGameplayStatics::PostEvent` и т.п.) в ассетах,
  которые ты откроешь и пересохранишь в этом ките, станут битыми: класс в стабе есть,
  но функций в нём нет. Ссылки-**свойства** (`UAkAudioEvent*` и пр.) при этом
  сохраняются — классы-то существуют. В UI-виджетах мини-игр такие ноды редкость
  (звук обычно через Pal-обёртки, они в ките есть и живы); после открытия виджета
  просто глянь на его граф — не должно быть жёлтых «missing function».
- В pak-мод кладём **только контент** (правленые `.uasset`), никаких `Binaries`
  и модульных DLL стаба — игре он не нужен, звук в игре делает её настоящий Wwise.

## Что дальше (roadmap правки мини-игр)

**Почему нельзя «просто чистый проект»:** целевые виджеты — дети нативных
классов `/Script/Pal.*` (проверено по заглушкам кита):
`WBP_PickingGame02_ForDisplay` → `UPalUIPickingGame : UPalUserWidgetOverlayUI`
(внутри `UPalPickingGameProcessor*`, BP-события `SetGameResult` /
`RegisterPickinGameProcessor`); палфайт-виджет →
`UPalLockGimmickPalFightWidget : UPalUserWidget` (внутри
`TWeakObjectPtr<APalLevelObject_LockGimmickPalFight> Gimmick`, события
`OnTimerUpdated` / `OnTimeOut`). Редактор, не знающий этих классов, ассет не
откроет — поэтому и нужны 6668 заглушек кита. Чистый проект работает только
для НОВЫХ виджетов от `UUserWidget` (как HUD-таймер). Любой C++-проект на
UE 5.1 всё равно требует тулчейн v143 (14.39) — движковые заголовки с v145
не собираются нигде.

1. FModel → найти и извлечь (Export Raw Data):
   `WBP_PickingGame02_ForDisplay`, `WBP_OneStroke_ForDisplay` /
   `WBP_OneStrokeGame_ForDisplay`, `WBP_SalvageGame_GaugeStopMiniGame`,
   `BP_PalLevelObject_LockGimmickPalFight`.
   ВАЖНО: если у файла есть вариант с суффиксом `_Common` — править нужно
   именно его (иначе игра возьмёт `_Common` и мод не сработает).
2. В ките: правка графов (цепочка: `OnReceive*Success` → виджет сам
   закрывается → `Close: OnPreClose` → `OnGimmickCleared` →
   `RequestMiniGameSuccess_ToServer` → `OnMiniGameComplete(true)`; безопасный
   скип — форсировать успех внутри BP виджета).
3. Cook только правленых ассетов → repak. Внутренние пути в pak — зеркально
   игровым (как извлёк FModel), папка мода с суффиксом `_P`, установка в
   `Pal\Content\Paks\~mods` (или `LogicMods` — как у таймер-мода).

**План В без C++ (UAssetGUI):** если у виджетов найдутся «тюнингуемые»
свойства (скорость иглы, размер зоны успеха, таймаут) — их можно править
прямо в извлечённом .uasset через UAssetGUI и паковать repak'ом, вообще без
редактора и компилятора. Граф-логику (авто-успех) так не перепишешь — только
облегчить мини-игры.

## Состав папки

```text
pmk-no-wwise/
├── README.md                 ← этот файл
├── patch_pmk.py              ← авто-патчер кита
└── Source/AkAudio/           ← стаб-модуль (9 файлов)
    ├── AkAudio.Build.cs
    ├── Public/AkAudioEvent.h
    ├── Public/AkCallbackInfo.h
    ├── Public/AkComponent.h
    ├── Public/AkGameplayStatics.h   ← enum EAkCallbackType + FOnAkPostEventCallback
    └── Private/*.cpp
```
