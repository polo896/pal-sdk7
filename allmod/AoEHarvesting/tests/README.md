# AoEHarvesting — regression harness

`harness.lua` runs the mod **without the game**. It mocks UE4SS globals
(`RegisterHook`, `FindAllOf`, `LoopAsync`, …) and engine objects, then drives
realistic Palworld 1.0.4 scenarios:

- background scans incl. objects dying mid-scan (streaming/GC race),
- pickaxe hits that deplete rocks, then hits over the corpses
  (any property read on a dead object = `VIOLATION` — in-game that is a
  native `EXCEPTION_ACCESS_VIOLATION` that `pcall` cannot catch),
- rescans with fresh userdata wrappers (UE4SS wrapper instability),
- respawns, axe/foliage path, empty `InstanceIds` (TArray auto-grow check),
- chat `!aoeon`/`!aoeoff`, autoloot, weapon-detection variants,
- attacker variants, pawn respawn.

## Run

With any Lua interpreter:

```sh
AOE_TARGET=../Scripts/main.lua AOE_STRICT=1 lua harness.lua
```

or with python-lupa (`pip install lupa`):

```sh
AOE_TARGET=../Scripts/main.lua AOE_STRICT=1 python3 -c \
  "from lupa import LuaRuntime; LuaRuntime().execute(open('harness.lua').read())"
```

from this directory. `AOE_STRICT=1` fails on any violated check;
without it the harness prints a report (useful to see how the
pre-1.0.4 code misbehaves under the new engine timing).
