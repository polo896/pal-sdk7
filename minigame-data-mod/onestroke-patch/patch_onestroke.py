#!/usr/bin/env python3
"""
Патчер DA_OneStrokeMinigameData (Palworld, UE 5.1 unversioned properties).

Зачем: делает ВСЕ 30 паззлов «Росчерка» тривиальными — сетка 2x2, старт (0,0),
цель (1,0), препятствий нет. Победа в 3 хода: (0,0)->(0,1)->(1,1)->(1,0)
(обойти все клетки и закончить на цели). Рецепт безопасен при ЛЮБОМ варианте
подсчёта победы в игре (visit-all / reach-goal / gridSize^2 - len(obstacles)).

Формат: пакет cooked UE5.1 с PKG_UnversionedProperties — свойства пишутся без
тегов; перед каждым набором полей идёт FUnversionedHeader: 16-битные фрагменты
  bits 0-6  SkipNum  — сколько свойств пропустить (равны дефолту)
  bit  7    HasZeroMask — дальше есть битовая маска нулевых значений
  bit  8    IsLast   — последний фрагмент
  bits 9-15 ValueNum — сколько значений записано
Нулевые числовые поля в поток не пишутся (только бит в маске). Карту ключей
FName хранит как (индекс имени, номер): (Easy, N) = "Easy_{N-1}".

Использование:
  python3 patch_onestroke.py [папка_с_оригиналами] [папка_вывода]
По умолчанию: original/ -> patched/Pal/Content/DataAsset/OneStrokeGame/

Проверка: перед записью скрипт сверяет все 30 распарсенных записей
с дампом FModel (если рядом лежит onestroke-dump.json) и после сборки
повторно парсит результат.
"""
import json
import struct
import sys
import os

TRAILER = bytes.fromhex('c1832a9e')  # package magic в конце .uexp
TARGET = dict(size=2, start=(0, 0), goal=(1, 0), obs=[])


class R:
    def __init__(self, b, p=0):
        self.b, self.p = b, p
    def u8(self):
        v = self.b[self.p]; self.p += 1; return v
    def u16(self):
        v = struct.unpack_from('<H', self.b, self.p)[0]; self.p += 2; return v
    def i32(self):
        v = struct.unpack_from('<i', self.b, self.p)[0]; self.p += 4; return v
    def raw(self, n):
        v = self.b[self.p:self.p + n]; self.p += n; return v


def parse_header(r):
    """FUnversionedHeader: фрагменты + опциональная маска нулей."""
    frags = []
    while True:
        p = r.u16()
        f = dict(skip=p & 0x7f, masked=bool(p & 0x80), last=bool(p & 0x100), num=(p >> 9) & 0x7f)
        frags.append(f)
        if f['last']:
            break
    nbits = sum(f['num'] for f in frags if f['masked'])
    bits = []
    if nbits:
        if nbits <= 8:
            w = r.u8(); bits = [(w >> i) & 1 for i in range(nbits)]
        elif nbits <= 16:
            w = r.u16(); bits = [(w >> i) & 1 for i in range(nbits)]
        else:
            for _ in range((nbits + 31) // 32):
                w = r.i32() & 0xffffffff
                for i in range(32):
                    if len(bits) < nbits:
                        bits.append((w >> i) & 1)
    return frags, bits


def iter_values(frags, bits):
    """(слот схемы, ненулевое ли) для каждого записанного значения."""
    slot = 0; mi = 0
    for f in frags:
        slot += f['skip']
        for _ in range(f['num']):
            nz = (bits[mi] == 0) if f['masked'] else True
            if f['masked']:
                mi += 1
            yield slot, nz
            slot += 1


def parse_coord(r):
    """FPalOneStrokeGridCoord {X:int32, Y:int32}."""
    x = y = 0
    for slot, nz in iter_values(*parse_header(r)):
        if slot == 0:
            x = r.i32() if nz else 0
        elif slot == 1:
            y = r.i32() if nz else 0
    return (x, y)


def parse_setting(r):
    """FPalOneStrokeGameSettingData {GridSize, StartPosition, GoalPosition, ObstaclePositions}."""
    d = dict(size=0, start=(0, 0), goal=(0, 0), obs=[])
    for slot, nz in iter_values(*parse_header(r)):
        if slot == 0:
            d['size'] = r.i32() if nz else 0
        elif slot == 1:
            d['start'] = parse_coord(r) if nz else (0, 0)
        elif slot == 2:
            d['goal'] = parse_coord(r) if nz else (0, 0)
        elif slot == 3:
            if nz:
                n = r.i32()
                d['obs'] = [parse_coord(r) for _ in range(n)]
    return d


def frag(skip, num, masked, last):
    return struct.pack('<H', (skip & 0x7f) | (0x80 if masked else 0)
                       | (0x100 if last else 0) | ((num & 0x7f) << 9))


def coord_bytes(x, y):
    if x == 0 and y == 0:
        return frag(0, 2, True, True) + b'\x03'
    if x != 0 and y != 0:
        return frag(0, 2, False, True) + struct.pack('<ii', x, y)
    if x == 0:
        return frag(0, 2, True, True) + b'\x01' + struct.pack('<i', y)
    return frag(0, 2, True, True) + b'\x02' + struct.pack('<i', x)


def setting_bytes(t):
    """Канонический вид UE: 4 значения; пустой массив препятствий = бит маски
    (так UE сам пишет VeryEasy_0, у которого препятствий нет)."""
    out = frag(0, 4, True, True)      # skip 0, 4 значения, есть маска, последний
    out += bytes([0b1000])            # бит3: массив = пустой; GridSize/Start/Goal записаны
    out += struct.pack('<i', t['size'])
    out += coord_bytes(*t['start'])
    out += coord_bytes(*t['goal'])
    return out


def main():
    src = sys.argv[1] if len(sys.argv) > 1 else os.path.join(os.path.dirname(__file__), 'original')
    dst = sys.argv[2] if len(sys.argv) > 2 else os.path.join(os.path.dirname(__file__), 'patched', 'Pal', 'Content', 'DataAsset', 'OneStrokeGame')
    os.makedirs(dst, exist_ok=True)

    uexp = open(os.path.join(src, 'DA_OneStrokeMinigameData.uexp'), 'rb').read()
    uasset = open(os.path.join(src, 'DA_OneStrokeMinigameData.uasset'), 'rb').read()
    assert uexp[-4:] == TRAILER, 'нет трейлера пакета'
    export = uexp[:-4]

    # --- разбор ---
    r = R(export)
    p0 = r.p
    parse_header(r)                      # заголовок объекта (GameSettings + 4 хвостовых свойства)
    obj_hdr = export[p0:r.p]
    nr, cnt = r.i32(), r.i32()
    assert (nr, cnt) == (0, 30), f'неожиданная карта: {nr}, {cnt}'
    keys, entries = [], []
    for _ in range(30):
        keys.append(r.raw(8))            # FName ключа — копируется байт-в-байт
        entries.append(parse_setting(r))
    tail = export[r.p:]                  # GenerateData-структуры и пр. — не трогаем
    assert r.p + len(tail) == len(export)

    # --- сверка с дампом FModel (если есть) ---
    dump = os.path.join(os.path.dirname(__file__), 'onestroke-dump.json')
    if os.path.exists(dump):
        jd = json.load(open(dump))
        jmap = {e['Key']: e['Value'] for e in jd[0]['Properties']['GameSettings']}
        names = ['Easy', 'Hard', 'Normal', 'VeryEasy', 'VeryHard']
        ok = 0
        for kb, d in zip(keys, entries):
            idx, num = struct.unpack('<ii', kb)
            v = jmap[f'{names[idx]}_{num - 1}']
            if (d['size'], d['start'], d['goal'], d['obs']) == (
                    v['GridSize'],
                    (v['StartPosition']['X'], v['StartPosition']['Y']),
                    (v['GoalPosition']['X'], v['GoalPosition']['Y']),
                    [(o['X'], o['Y']) for o in v['ObstaclePositions']]):
                ok += 1
        print(f'сверка с дампом: {ok}/30')
        assert ok == 30

    # --- сборка ---
    new = obj_hdr + struct.pack('<ii', 0, 30)
    for kb in keys:
        new += kb + setting_bytes(TARGET)
    new += tail
    new_uexp = new + TRAILER

    # --- патч .uasset: SerialSize в таблице экспортов ---
    ctx = b'\x0b\x00\x00\x00' + struct.pack('<i', len(export)) + b'\x00\x00\x00\x00' + struct.pack('<q', len(uasset))
    pos = uasset.find(ctx)
    assert pos != -1 and uasset.find(ctx, pos + 1) == -1, 'SerialSize не найден'
    new_uasset = bytearray(uasset)
    struct.pack_into('<i', new_uasset, pos + 4, len(new))
    new_uasset = bytes(new_uasset)

    # --- контрольная перепроверка результата ---
    r2 = R(new)
    p0 = r2.p; parse_header(r2); assert new[p0:r2.p] == obj_hdr
    assert (r2.i32(), r2.i32()) == (0, 30)
    for kb in keys:
        assert r2.raw(8) == kb
        d = parse_setting(r2)
        assert (d['size'], d['start'], d['goal'], d['obs']) == (2, (0, 0), (1, 0), [])
    assert r2.raw(len(tail)) == tail and r2.p == len(new)

    open(os.path.join(dst, 'DA_OneStrokeMinigameData.uexp'), 'wb').write(new_uexp)
    open(os.path.join(dst, 'DA_OneStrokeMinigameData.uasset'), 'wb').write(new_uasset)
    print(f'OK: экспорт {len(export)} -> {len(new)} байт; .uexp {len(uexp)} -> {len(new_uexp)}; .uasset изменён на 2 байта (SerialSize)')


if __name__ == '__main__':
    main()
