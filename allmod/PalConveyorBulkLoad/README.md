# Pal Conveyor Bulk Load — v1.0

Hover a Pal at the Pal Disassembly Conveyor, press **`V`**, and every Pal of that type on
the page goes across.

---

## Requirements

The Palworld build of UE4SS:
[RE-UE4SS experimental-palworld](https://github.com/Okaetsu/RE-UE4SS/releases/tag/experimental-palworld)

Don't run two copies of UE4SS. The old `UE4SS_Xinput` into `Win64\` layout is obsolete and
crashes the game.

---

## Install

Quit the game, drop the `PalConveyorBulkLoad` folder into:

```
<Palworld>\Pal\Binaries\Win64\ue4ss\Mods\
```

`enabled.txt` is included, so `mods.txt` needs nothing. To uninstall, delete the folder.

---

## Keys

| Key | Does |
|---|---|
| `V` | Send every matching Pal on the page to the conveyor |
| `F11` | Send exactly one |
| `F10` | Dry run. Lists what would move, changes nothing |
| `F8` | Condensed guard on/off, until you quit |
| `F9` | Read-only dump for bug reports |

All rebindable in `Scripts/config.lua`.

`F` is deliberately avoided — the screen already uses it for View Details, and both would
fire at once.

The keys do nothing unless a Pal transfer screen is open.

---

## Matching

Pals are matched on their internal ID, which is what you'll see in the log. Aegidron reads
as `DomeArmorDragon`; that's normal.

**Alphas are separate.** A box can hold both the ordinary Pal and its `BOSS_` version, and
the two never mix. Set `include_boss_variants = true` to treat them as one.

Level, passives, IVs and gender are ignored. `match_mode = "species_level"` narrows it to
the level you're hovering.

---

## Guards

| Setting | Default | Effect |
|---|---|---|
| `skip_condensed` | `true` | Leaves condensed Pals (rank above 1) alone |
| `skip_favorites` | `false` | Leaves Favourites alone |

Every press reports what it spared: *"Sent 26 DomeArmorDragon to the conveyor (1 condensed
kept back)"*.

**Some Pals arrive condensed on their own.** A mutated egg hatches an alpha at two stars,
so a box bred for disassembly can read as condensed even though you never condensed
anything. Press `F8` when that happens, or set `skip_condensed = false` if it's always the
case. The mod says so in the log when a guard takes most of a page.

---

## Worth knowing

One page at a time, like the Condensation screen. The Pal you're hovering moves last, so
the cursor keeps pointing at something real — press `V` again on the emptied slot and it
carries on with the same Pal.

Every move is checked afterwards. Moves go through the server, so anything slow is retried
before it counts as a failure. When the conveyor fills up, the mod stops and says so
instead of hammering away.

It doesn't move Pals itself — it fires the game's own Move action, the same one the
on-screen prompt uses. Anything the game would refuse if you did it by hand, it still
refuses. Nothing is written to your save.

No on-screen key prompt — the game builds those through something mods can't reach, so the
key works but isn't advertised.

**One way only.** Pals go box to conveyor. Taking them back out is a drag-and-drop the game
doesn't expose to mods, so those you drag by hand.

The conveyor shares its screen with other Pal transfer UIs, so `V` works on those too.

---

## If something looks off

Set `verbose = true`, reproduce it, and grab `Win64\ue4ss\UE4SS.log`. `F9` adds a
read-only dump. Every line is prefixed `[PalConveyorBulkLoad]`.

| Symptom | Likely cause |
|---|---|
| `Hover the mouse over a Pal...` | Cursor isn't on a Pal |
| `That Pal would not move` | Conveyor full, or a patch moved things |
| Nothing at all | Mod not loaded — check the log for `v1.0 loaded` |
| Wrong Pals moved | Try `F10` first, or `match_mode = "species_level"` |

---

## Compatibility

Built against Palworld 1.0.2 (Steam), single player / host. Multiplayer as a guest is
untested.

---

## Credits

- **Okaetsu** — the Palworld build of UE4SS this runs on
- [Palworld Modding Docs](https://pwmodding.wiki/)


---

## Changelog

### 1.0
- First release.
