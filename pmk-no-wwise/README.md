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
- **Visual Studio Build Tools 2022** (standalone, БЕЗ IDE, ~3–5 ГБ). Качается с
  [visualstudio.microsoft.com/downloads](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022)
  (внизу страницы, «Build Tools for Visual Studio 2022»). Живёт рядом с VS 2026,
  не конфликтует, удаляется штатно из «Установленных приложений».
  В Installer → *Individual components* отметить:
  - **MSVC v143 — VS 2022 C++ x64/x86 build tools (v14.38-17.8)** — именно v14.38;
  - **Windows 10 SDK** (10.0.19041+) или Windows 11 SDK.
- **.NET SDK 6.x** — если UBT пожалуется при сборке (обычно хватает встроенного в движок).

### BuildConfiguration.xml

Создай файл `%APPDATA%\Unreal Engine\UnrealBuildTool\BuildConfiguration.xml`:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<Configuration xmlns="https://www.unrealengine.com/BuildConfiguration">
    <BuildConfiguration>
        <Compiler>VisualStudio2022</Compiler>
    </BuildConfiguration>
    <WindowsPlatform>
        <Compiler>VisualStudio2022</Compiler>
        <ToolchainVersion>14.38.33130</ToolchainVersion>
    </WindowsPlatform>
    <VCProjectFileGenerator>
        <Version>VisualStudio2022</Version>
    </VCProjectFileGenerator>
</Configuration>
```

Это заставит UBT движка 5.1 использовать тулчейн Build Tools 2022, а не твой VS 2026.

## Запуск кита

1. Двойной клик `C:\PMK\Pal.uproject`.
2. *«Missing Pal Modules … rebuild now?»* → **Да**. Это норма: заглушки кита
   компилируются первый раз (~5–15 мин).
3. Диалога про Wwise больше не будет.
4. Если *«Pal could not be compiled»*: проверь (а) установлен ли MSVC v143 **14.38**,
   (б) правильный ли `BuildConfiguration.xml`, (в) нет ли в пути папки `-main`,
   (г) не запущен ли второй экземпляр редактора. **Не** кликай `.uproject` повторно,
   пока идёт компиляция — это и порождает «could not be compiled».

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

1. FModel → извлечь из игры `WBP_PickingGame02_ForDisplay`, `WBP_OneStrokeGame_ForDisplay`,
   `WBP_SalvageGame_GaugeStopMiniGame`, `BP_PalLevelObject_LockGimmickPalFight`
   (+ их зависимости) в `Content/` кита по родным путям.
2. В ките: правка графов (цепочка: `OnReceive*Success` → виджет сам закрывается →
   `Close: OnPreClose` → `OnGimmickCleared` → `RequestMiniGameSuccess_ToServer` →
   `OnMiniGameComplete(true)`; безопасный скип — форсировать успех внутри BP виджета).
3. Cook только этих ассетов → упаковка в pak (имя с `-WIN64` / крипто-ключ Palworld,
   `~mods` или `LogicMods`-путь — как у твоего таймер-мода).

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
