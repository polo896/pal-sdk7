#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
patch_pmk.py — превращает клон PalworldModdingKit в Wwise-free кит.

Что делает:
  1) Pal.uproject: убирает плагин "Wwise" (исчезает диалог Missing Plugin 'Wwise')
     и добавляет runtime-модуль "AkAudio";
  2) копирует стаб-модуль Source/AkAudio (пустые UAkAudioEvent / UAkComponent /
     UAkCallbackInfo, enum EAkCallbackType, делегат FOnAkPostEventCallback) —
     ровно те имена, на которые ссылается Pal-код кита (58 файлов из 6679);
  3) Config/DefaultGame.ini: комментирует Wwise-строки (cook/stage-папки,
     секция AkSettings) — кит больше не ищет Wwise-проект.

Запуск (Python 3.8+):
    python patch_pmk.py "C:\\PMK"
где C:\\PMK — папка кита, в которой лежит Pal.uproject.

Скрипт идемпотентный: повторный запуск ничего не сломает.
Бэкапы: Pal.uproject.bak, Config/DefaultGame.ini.bak (только при первом запуске).
"""

import json
import re
import shutil
import sys
from pathlib import Path


def patch_uproject(kit: Path) -> bool:
    uproject = kit / "Pal.uproject"
    text = uproject.read_text(encoding="utf-8")

    if '"AkAudio"' in text and '"Wwise"' not in text:
        print("  [=] Pal.uproject уже пропатчен (Wwise отсутствует, AkAudio на месте)")
        return True

    # бэкап при первом запуске
    bak = kit / "Pal.uproject.bak"
    if not bak.exists():
        shutil.copy2(uproject, bak)
        print(f"  [+] бэкап: {bak.name}")

    try:
        data = json.loads(text)
        # 1. убрать плагин Wwise
        before = len(data.get("Plugins", []))
        data["Plugins"] = [p for p in data.get("Plugins", []) if p.get("Name") != "Wwise"]
        removed = before - len(data["Plugins"])
        print(f"  [-] плагин Wwise удалён из Pal.uproject ({removed} запис(ь/и))")

        # 2. добавить модуль AkAudio, если его нет
        modules = data.setdefault("Modules", [])
        if not any(m.get("Name") == "AkAudio" for m in modules):
            modules.append({"Name": "AkAudio", "Type": "Runtime", "LoadingPhase": "Default"})
            print("  [+] модуль AkAudio добавлен в Pal.uproject")
        else:
            print("  [=] модуль AkAudio уже был в Pal.uproject")

        uproject.write_text(
            json.dumps(data, indent="\t", ensure_ascii=False) + "\n", encoding="utf-8"
        )
        # контрольная проверка, что JSON валиден и Wwise исчез
        check = json.loads(uproject.read_text(encoding="utf-8"))
        assert not any(p.get("Name") == "Wwise" for p in check.get("Plugins", [])), "Wwise остался!"
        return True
    except (json.JSONDecodeError, ValueError):
        # запасной путь: аккуратная вырезка блока регуляркой
        print("  [!] Pal.uproject не парсится как JSON — использую регулярку")
        text2 = re.sub(
            r",?\s*\{\s*\"Name\"\s*:\s*\"Wwise\"\s*,\s*\"Enabled\"\s*:\s*true\s*\}",
            "",
            text,
            count=1,
        )
        if '"Wwise"' in text2:
            print("  [X] не удалось удалить блок Wwise — сделай вручную (см. README)")
            return False
        uproject.write_text(text2, encoding="utf-8")
        print("  [-] блок Wwise вырезан регуляркой")
        return True


def install_stub_module(kit: Path) -> bool:
    stub_src = Path(__file__).resolve().parent / "Source" / "AkAudio"
    if not stub_src.is_dir():
        print("  [X] не найдена папка стаба Source/AkAudio рядом со скриптом")
        return False
    dst = kit / "Source" / "AkAudio"
    shutil.copytree(stub_src, dst, dirs_exist_ok=True)
    files = sorted(p.relative_to(dst).as_posix() for p in dst.rglob("*") if p.is_file())
    print(f"  [+] стаб-модуль Source/AkAudio записан ({len(files)} файлов):")
    for f in files:
        print(f"        {f}")
    return True


def patch_default_game_ini(kit: Path) -> bool:
    ini = kit / "Config" / "DefaultGame.ini"
    if not ini.is_file():
        print("  [!] Config/DefaultGame.ini не найден — пропускаю")
        return True
    lines = ini.read_text(encoding="utf-8-sig").splitlines(keepends=True)
    out, in_ak_section, changed = [], False, 0
    for line in lines:
        stripped = line.strip()
        new_line = line
        if stripped.startswith("[") and not stripped.startswith(";"):
            in_ak_section = stripped.lower().startswith("[/script/akaudio")
        needs_comment = (
            in_ak_section and stripped != ""  # всё внутри секции AkSettings
        ) or ("Wwise" in line and stripped.startswith("+DirectoriesTo"))
        if needs_comment and not stripped.startswith(";"):
            eol = "\r\n" if line.endswith("\r\n") else ("\n" if line.endswith("\n") else "")
            body = line.rstrip("\r\n")
            new_line = ";" + body + eol
            changed += 1
        out.append(new_line)
    if changed:
        bak = kit / "Config" / "DefaultGame.ini.bak"
        if not bak.exists():
            shutil.copy2(ini, bak)
            print(f"  [+] бэкап: Config/{bak.name}")
        ini.write_text("".join(out), encoding="utf-8", newline="")
        print(f"  [-] Wwise/Ak-строки в DefaultGame.ini закомментированы ({changed} шт.)")
    else:
        print("  [=] Wwise-строк в DefaultGame.ini нет")
    return True


def main() -> int:
    if len(sys.argv) != 2:
        print("Использование: python patch_pmk.py <путь к папке кита с Pal.uproject>")
        return 1
    kit = Path(sys.argv[1]).expanduser().resolve()
    if not (kit / "Pal.uproject").is_file():
        print(f"ОШИБКА: {kit / 'Pal.uproject'} не найден. Укажи папку, куда склонирован PalworldModdingKit.")
        return 1

    print(f"Кит: {kit}")
    print("\n[1/3] Pal.uproject:")
    ok1 = patch_uproject(kit)
    print("\n[2/3] Стаб-модуль AkAudio:")
    ok2 = install_stub_module(kit)
    print("\n[3/3] Config/DefaultGame.ini:")
    ok3 = patch_default_game_ini(kit)

    print("\n" + "=" * 60)
    if ok1 and ok2 and ok3:
        print("ГОТОВО. Киту больше не нужен Wwise.")
        print("Дальше (по README):")
        print("  1. Папка кита: короткий путь без '-main' (например C:\\PMK)")
        print("  2. Build Tools 2022 + MSVC v143 (14.38) + BuildConfiguration.xml")
        print("  3. Двойной клик по Pal.uproject -> 'Missing Pal Modules' -> Да")
        print("     (диалога Wwise больше не будет), ждём компиляции.")
        return 0
    print("ЕСТЬ ПРОБЛЕМЫ — смотри строки с [X] выше и раздел README 'Ручная установка'.")
    return 1


if __name__ == "__main__":
    sys.exit(main())
