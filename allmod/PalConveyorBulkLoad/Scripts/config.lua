--[[
    Pal Conveyor Bulk Load - settings

    Key names follow UE4SS's Key table: A-Z, F1-F12, NUM_ZERO and so on.
--]]

return {
    ----------------------------------------------------------------
    -- Keys
    ----------------------------------------------------------------

    -- Hover a Pal in the box, press this, and every Pal of that type on the
    -- page is sent to the conveyor.
    --
    -- Not F: the screen already uses F for View Details, and both would fire.
    move_key = "V",

    -- Lists what would move. Changes nothing.
    dry_run_key = "F10",

    -- Moves exactly one.
    move_one_key = "F11",

    -- Turns the condensed guard on and off until you quit.
    guard_toggle_key = "F8",

    -- Read-only dump. Worth attaching to a bug report.
    dump_key = "F9",

    ----------------------------------------------------------------
    -- What counts as the same Pal
    ----------------------------------------------------------------

    --   "species"       - the same Pal, any level.
    --   "species_level" - the same Pal at the same level as the one hovered.
    match_mode = "species",

    -- Alphas carry their own internal name: a box can hold both the ordinary
    -- Pal and its BOSS_ version. Left false, the two never mix.
    -- Set true to treat them as one Pal.
    include_boss_variants = false,

    ----------------------------------------------------------------
    -- Guards
    ----------------------------------------------------------------

    -- Leave condensed Pals (rank above 1) where they are.
    --
    -- Some Pals arrive condensed without you doing anything - mutated eggs
    -- hatch alphas at two stars, for one - so a box bred for disassembly can
    -- read as condensed. Press the guard toggle key when that is the case, or
    -- set this false if it always is.
    skip_condensed = true,

    -- Leave Favourites alone. Off because the game already refuses to move
    -- them; turn it on only if you want them out of the counts.
    skip_favorites = false,

    -- Pause the first pass after this many refusals in a row, so a full
    -- destination is not hammered. Anything stalled is retried afterwards
    -- regardless, so this is a brake rather than a stop.
    stop_after_failures = 4,

    ----------------------------------------------------------------
    -- Misc
    ----------------------------------------------------------------

    -- Act only on screens whose title contains this text. Palworld 1.0.2 does
    -- not expose that title, so it currently does nothing; it is kept for a
    -- future patch. The log says so if you set it.
    restrict_to_title = "",

    -- Extra detail in UE4SS.log. Off to keep the log quiet. The summary after
    -- each press is printed either way.
    verbose = false,
}
