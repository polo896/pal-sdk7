--[[
    Pal Conveyor Bulk Load  v1.0
    ==================================================================
    Hover a Pal on the Pal Disassembly Conveyor transfer screen, press V, and
    every Pal of that type on the current box page is sent across.

        V     move every matching Pal on this page
        F11   move exactly ONE matching Pal
        F10   dry run - list what would move, change nothing
        F9    diagnostic dump - read-only

    Condensed Pals are skipped. Alphas (BOSS_ names) count as a different Pal
    unless config says otherwise. Favourites are left to the game, which
    refuses to move them anyway.

    Everything is in Scripts/config.lua.

    ------------------------------------------------------------------
    How this works, for whoever reads it next
    ------------------------------------------------------------------
    The screen is WBP_IngameMenu_CommonCharacterContainer_C, shared by every
    "move Pals between two places" UI. Layout confirmed against 1.0.2:

        container.WBP_BoxPalList_Party.WBP_BoxPalList
            :GetCurrentBoxSlots(out)  -> out[1..30], the page's slot buttons
        container.WBP_DisplayCharacterScrollList   -> the conveyor side
        container.CachedLastHoveredSlot            -> what the cursor is on
        container.MapObjectTitle                   -> "Pal Disassembly Conveyor"

    The mod never invents its own transfer. It calls the game's own handler,
    so whatever the game does about capacity, sync and ownership keeps
    happening exactly as it would if you had moved the Pal by hand.

    Three routes exist. Confirmed against 1.0.2, in the order they are tried:

      1. container:OnSendSlotInput() after pointing CachedLastHoveredSlot at
         the slot. This is the one that works - it is the same handler the
         "Move" prompt in the bottom bar runs.
      2. button:OnRightClicked_Internal(). Runs without error but moves
         nothing: the Blueprint wants a real pointer event behind it. Kept
         only as a fallback in case a patch rewires things.
      3. the container's bound OnRightClickedSlot delegate handler.

    Every move is verified by re-reading the slot. Moves go through the
    server, so a Pal that has not left yet is not the same as one that will
    not leave: anything that fails the first pass is re-checked and retried
    once, several hundred milliseconds later, before being called a failure.

    ------------------------------------------------------------------
    Two rules this mod exists under, both paid for in crashes
    ------------------------------------------------------------------
    1. NEVER call a UFunction without checking the object's class has it.
       Doing so raises a LowLevelFatalError inside ScriptCore.cpp, which
       pcall cannot catch and which kills the game. See hasFunction below.

    2. "The widget exists" is not "the screen is open". UMG keeps closed
       widgets alive with their children intact, so every entry point checks
       the container is activated before touching anything. See screenIsOpen.

    Requires the Palworld build of UE4SS:
    https://github.com/Okaetsu/RE-UE4SS/releases/tag/experimental-palworld
--]]

local config  = require "config"

local MOD     = "[PalConveyorBulkLoad]"
local VERSION = "1.0"

local CONTAINER_CLASS = "WBP_IngameMenu_CommonCharacterContainer_C"

-- The container's handler for a right-click on a box slot. Blueprint bound
-- events carry the whole generated name.
local BND_RIGHT_CLICK_BOX =
    "BndEvt__WBP_IngameMenu_CommonCharacterContainer_WBP_BoxPalList_Party_K2Node_ComponentBoundEvent_10_OnRightClickedSlot__DelegateSignature"

----------------------------------------------------------------------
-- Logging
----------------------------------------------------------------------
local function log(msg) print(string.format("%s %s\n", MOD, tostring(msg))) end
local function vlog(msg) if config.verbose then log(msg) end end

----------------------------------------------------------------------
-- Safety helpers.
--
-- Touching a stale or null UObject aborts the entire Lua callback and pcall
-- does NOT catch it, so every object access goes through valid() first.
----------------------------------------------------------------------
local function valid(object)
    if object == nil then return false end
    local ok, result = pcall(function() return object:IsValid() end)
    return ok and result == true
end

local function nameOf(object)
    if not valid(object) then return "<invalid>" end
    local ok, n = pcall(function() return object:GetFullName() end)
    return (ok and n) or "<unnamed>"
end

local function unwrap(parameter)
    if parameter == nil or type(parameter) ~= "userdata" then return parameter end
    local ok, t = pcall(function() return parameter:type() end)
    if not ok or (t ~= "RemoteUnrealParam" and t ~= "LocalUnrealParam") then
        return parameter
    end
    local ok2, v = pcall(function() return parameter:get() end)
    return ok2 and v or nil
end

--- Call one of UE4SS's own built-in UObject methods. These exist on every
--- UObject, so they need no class check - and that is what lets the class
--- check below be written at all.
local function callOnRaw(object, methodName)
    if object == nil then return nil end
    local ok, res = pcall(function() return object[methodName](object) end)
    return ok and res or nil
end

local function fnameToString(fname)
    if fname == nil then return nil end
    local ok, s = pcall(function() return fname:ToString() end)
    return (ok and s) or nil
end

-- GetAddress bypasses Unreal reflection, so it is a safe table key.
local function addressOf(object)
    if not valid(object) then return nil end
    local ok, addr = pcall(function() return object:GetAddress() end)
    return (ok and addr) or nil
end

----------------------------------------------------------------------
-- Does this object's class actually have this function?
--
-- THIS IS NOT OPTIONAL. Calling a UFunction an object does not have raises
-- a UE LowLevelFatalError from ScriptCore.cpp - a hard engine abort that
-- pcall CANNOT catch. It takes the whole game down and writes a 40MB dump.
--
-- Learned the hard way: calling IsEmpty (which lives on the character slot)
-- on a slot BUTTON crashed the game outright. Every call below is checked
-- against the real class first. The answer is cached per class, so the walk
-- happens once per class, not once per call.
--
-- IsValid / GetClass / GetFullName / GetAddress / ForEachFunction /
-- GetSuperStruct are UE4SS built-ins present on every UObject, so those are
-- safe to call unchecked - which is what makes the check itself possible.
----------------------------------------------------------------------
local functionCache = {}

local function hasFunction(object, methodName)
    if not valid(object) then return false end

    local cls = nil
    if not pcall(function() cls = object:GetClass() end) then return false end
    if not valid(cls) then return false end

    local key = addressOf(cls)
    if key == nil then return false end

    local known = functionCache[key]
    if known == nil then
        known = {}
        local current = cls
        for _ = 1, 10 do
            if not valid(current) then break end
            pcall(function()
                current:ForEachFunction(function(fn)
                    local n = fnameToString(callOnRaw(fn, "GetFName"))
                    if n then known[n] = true end
                end)
            end)
            local parent = nil
            pcall(function() parent = current:GetSuperStruct() end)
            if not valid(parent) then pcall(function() parent = current:GetSuper() end) end
            if not valid(parent) then break end
            current = parent
        end
        functionCache[key] = known
    end

    return known[methodName] == true
end

--- UE4SS's own UObject methods. These are NOT Unreal reflected UFunctions, so
--- they never appear in a class's function list - which means the class check
--- below would reject every one of them. Routing them straight through is not
--- an optimisation, it is required for correctness.
---
--- Missing this broke classNameOf(), which broke the type check on the send
--- route, which handed the game a slot button where it wanted a slot, which
--- made the game abort. One missing name in this table crashes the game.
local BUILTIN_METHODS = {
    IsValid = true, GetFullName = true, GetAddress = true, GetClass = true,
    GetFName = true, GetSuperStruct = true, GetSuper = true, GetOuter = true,
    ForEachFunction = true, ForEachProperty = true, ToString = true,
}

local function callOn(object, methodName, ...)
    if BUILTIN_METHODS[methodName] then return callOnRaw(object, methodName) end
    if not hasFunction(object, methodName) then return nil end
    local args = { ... }
    local ok, res = pcall(function() return object[methodName](object, table.unpack(args)) end)
    return ok and res or nil
end

--- Same, but hand back the error text. During discovery the error message is
--- usually the answer, so it never gets swallowed.
local function tryCall(object, methodName, ...)
    if not valid(object) then return false, "invalid object" end
    if not hasFunction(object, methodName) then
        return false, "no function named " .. methodName .. " on this class"
    end
    local args = { ... }
    local ok, err = pcall(function() object[methodName](object, table.unpack(args)) end)
    if ok then return true end
    return false, tostring(err):gsub("\n.*", "")
end

local function readField(object, fieldName)
    if not valid(object) then return nil end
    local ok, v = pcall(function() return object[fieldName] end)
    return ok and v or nil
end

local function writeField(object, fieldName, value)
    if not valid(object) then return false end
    return (pcall(function() object[fieldName] = value end))
end

--- Field read that does not demand IsValid, so it also works on structs.
local function readAny(obj, field)
    if obj == nil then return nil end
    local ok, v = pcall(function() return obj[field] end)
    return ok and v or nil
end

--- Out-parameters land in the table under the PARAMETER'S OWN name, not at
--- index 1, and array out-params spread across 1..n. Taking the first value
--- pairs() returns covers both shapes.
local function callOut(obj, method)
    if not hasFunction(obj, method) then return nil end
    local out = {}
    if not pcall(function() obj[method](obj, out) end) then return nil end
    for _, v in pairs(out) do
        local uv = unwrap(v)
        if uv ~= nil then return uv end
    end
    return nil
end

local function callOutTable(obj, method)
    if not hasFunction(obj, method) then return nil end
    local out = {}
    if not pcall(function() obj[method](obj, out) end) then return nil end
    return out
end

local function classNameOf(object)
    if not valid(object) then return nil end
    local cls = callOn(object, "GetClass")
    if not valid(cls) then return nil end
    return fnameToString(callOn(cls, "GetFName"))
end

--- Re-test for a short while. Transfers are not always instant, so
--- verification gets a grace period rather than a snap judgement.
---
--- Deliberately not a tight spin: each test is a handful of reflection calls,
--- so idle cycles are burned between tests instead of re-reading flat out.
local function waitUntil(test, milliseconds)
    local haveClock = (type(os) == "table" and type(os.clock) == "function")
    local deadline  = haveClock and (os.clock() + (milliseconds / 1000)) or nil
    local attempts  = math.max(2, math.floor(milliseconds / 20))

    for _ = 1, attempts do
        if test() then return true end
        if deadline and os.clock() > deadline then return false end
        local burn = 0
        for _ = 1, 200000 do burn = burn + 1 end
    end
    return false
end

----------------------------------------------------------------------
-- Reading a Pal out of a slot.
--
-- Fresh reads go button -> GetTargetSlot -> GetHandle ->
-- TryGetIndividualParameter. The cache below only exists as a fallback for
-- slots the direct route cannot reach.
----------------------------------------------------------------------
local function paramFromCharacterSlot(target)
    if not valid(target) then return nil end
    if callOn(target, "IsEmpty") == true then return nil end
    local handle = callOn(target, "GetHandle") or callOut(target, "GetHandle")
    if handle == nil then return nil end
    return callOn(handle, "TryGetIndividualParameter")
        or callOut(handle, "TryGetIndividualParameter")
end

local function paramFromButton(button)
    if not valid(button) then return nil end
    local slot = callOut(button, "GetTargetSlot")
    local param = paramFromCharacterSlot(slot)
    if param ~= nil then return param end

    -- Fallbacks, in case GetTargetSlot is unavailable on this widget.
    param = callOut(button, "GetIndividualParameter")
    if param ~= nil then return param end

    local inner = readField(button, "WBP_PalCommonCharacterSlot")
    if valid(inner) then
        param = callOut(inner, "GetIndividualParameter")
        if param ~= nil then return param end
        local handle = callOut(inner, "GetIndividualHandle")
        if handle ~= nil then
            return callOn(handle, "TryGetIndividualParameter")
                or callOut(handle, "TryGetIndividualParameter")
        end
    end
    return nil
end

local function speciesFromParam(param)
    if param == nil then return nil end
    local s = fnameToString(readAny(param, "CharacterID"))
    if s then return s end
    s = fnameToString(callOn(param, "GetCharacterID"))
    if s then return s end
    s = fnameToString(callOut(param, "GetCharacterID"))
    if s then return s end
    local sp = readAny(param, "SaveParameter")
    if sp ~= nil then return fnameToString(readAny(sp, "CharacterID")) end
    return nil
end

local function coerceNumber(v)
    if type(v) == "number" then return v end
    if type(v) == "userdata" then
        local n = readAny(v, "Value")
        if type(n) == "number" then return n end
    end
    return nil
end

local function levelFromParam(param)
    if param == nil then return nil end
    return coerceNumber(callOn(param, "GetLevel"))
        or coerceNumber(readAny(param, "Level"))
        or coerceNumber(readAny(readAny(param, "SaveParameter"), "Level"))
end

--- Condensation rank. Confirmed 1.0.2: an un-condensed Pal reports 1, so
--- "condensed" means above 1.
local function rankFromParam(param)
    if param == nil then return nil end
    return coerceNumber(callOn(param, "GetRank"))
        or coerceNumber(readAny(readAny(param, "SaveParameter"), "Rank"))
        or coerceNumber(readAny(param, "Rank"))
end

--- Favourite flag, plus which read produced it.
---
--- Careful here. GetFavoriteIndex returns 0 for a Pal in no favourite group,
--- so testing it for >= 0 marks every Pal in the game as a favourite. Only a
--- real boolean is trusted, and the index route needs a positive value.
--- Every number that might be the condensation rank, side by side.
---
--- rankFromParam has to commit to one of these. This prints all of them, so a
--- Pal whose stars disagree with the guard immediately shows which field the
--- guard should have been reading instead.
local function rankSources(param)
    if param == nil then return "no Pal to read" end
    local parts = {}
    local function add(label, value)
        local n = coerceNumber(value)
        if n ~= nil then parts[#parts + 1] = label .. "=" .. n end
    end

    add("GetRank()",          callOn(param, "GetRank"))
    add("SaveParameter.Rank", readAny(readAny(param, "SaveParameter"), "Rank"))
    add("Rank",               readAny(param, "Rank"))
    add("GetPalSoulRank()",   callOn(param, "GetPalSoulRank"))
    add("GetRankUpExp()",     callOn(param, "GetRankUpExp"))
    add("GetLevel()",         callOn(param, "GetLevel"))

    if #parts == 0 then return "nothing readable" end
    return table.concat(parts, "   ")
end

local function favouriteFromParam(param)
    if param == nil then return nil, "no param" end

    local b = callOn(param, "IsFavoritePal")
    if type(b) == "boolean" then return b, "IsFavoritePal" end

    b = callOut(param, "IsFavoritePal")
    if type(b) == "boolean" then return b, "IsFavoritePal(out)" end

    local idx = coerceNumber(callOn(param, "GetFavoriteIndex"))
                or coerceNumber(callOut(param, "GetFavoriteIndex"))
    if idx ~= nil then return idx > 0, "GetFavoriteIndex=" .. tostring(idx) end

    return nil, "unreadable"
end

--- Everything the mod needs to know about one slot, in one read.
local function inspect(button)
    local param = paramFromButton(button)
    if param == nil then return nil end
    local fav, favVia = favouriteFromParam(param)
    return {
        species      = speciesFromParam(param),
        level        = levelFromParam(param),
        rank         = rankFromParam(param),
        favourite    = fav,
        favouriteVia = favVia,
    }
end

local function slotIsEmpty(button)
    local slot = callOut(button, "GetTargetSlot")
    if not valid(slot) then return nil end

    local e = callOn(slot, "IsEmpty")
    if type(e) == "boolean" then return e end

    -- IsEmpty not exposed on this class: fall back to whether a Pal can still
    -- be read out of the slot. Without this, every move looks like a failure.
    return paramFromCharacterSlot(slot) == nil
end

----------------------------------------------------------------------
-- Finding the screen.
--
-- FindAllOf hands back the Blueprint asset template alongside live instances,
-- often the template first. Live ones sit under /Engine/Transient; on a
-- template every child reads as invalid.
----------------------------------------------------------------------
--- Is this screen actually on screen?
---
--- "The widget object exists" is NOT the same as "the screen is open". UMG
--- keeps closed widgets alive, so a conveyor screen you shut ten minutes ago
--- is still a valid object with a valid Pal grid hanging off it. Acting on
--- one of those means poking slot buttons for a UI that is not there, which
--- is exactly how pressing V at an Anubis statue took the game down.
local function screenIsOpen(container)
    local activated = callOn(container, "IsActivated")
    if type(activated) == "boolean" then return activated end
    local visible = callOn(container, "IsVisible")
    if type(visible) == "boolean" then return visible end
    return false   -- cannot confirm it is open, so do not touch it
end

local function findContainer()
    local all = FindAllOf(CONTAINER_CLASS)
    if not all then return nil end
    for _, o in ipairs(all) do
        if valid(o) and nameOf(o):find("/Engine/Transient", 1, true) then
            if valid(readField(o, "WBP_BoxPalList_Party")) and screenIsOpen(o) then
                return o
            end
        end
    end
    return nil
end

--- The screen's heading, e.g. "Pal Disassembly Conveyor". It is an FText, and
--- UE4SS hands those over in more than one shape, so try each.
local function titleOf(container)
    local t = readField(container, "MapObjectTitle")
    if t == nil then return nil end

    local ok, s = pcall(function() return t:ToString() end)
    if ok and type(s) == "string" and s ~= "" then return s end

    local unwrapped = unwrap(t)
    if unwrapped ~= t then
        ok, s = pcall(function() return unwrapped:ToString() end)
        if ok and type(s) == "string" and s ~= "" then return s end
    end
    if type(t) == "string" then return t end
    return nil
end

local warnedAboutTitle = false

local function titleAllowed(container)
    local want = config.restrict_to_title or ""
    if want == "" then return true end

    local have = titleOf(container)
    if have == nil then
        -- Never block the user over a read we could not make - but say so
        -- once, rather than letting a setting quietly do nothing.
        if not warnedAboutTitle then
            warnedAboutTitle = true
            log("restrict_to_title is set, but this game build does not expose the")
            log("screen title to mods, so the restriction cannot be applied and is")
            log("being ignored. Set it back to \"\" to silence this.")
        end
        return true
    end
    return have:lower():find(want:lower(), 1, true) ~= nil
end

local function getBoxList(container)
    local party = readField(container, "WBP_BoxPalList_Party")
    if not valid(party) then return nil end
    local list = readField(party, "WBP_BoxPalList")
    if not valid(list) then return nil end
    return list
end

local function getPageSlots(container)
    local list = getBoxList(container)
    if list == nil then return nil end
    local out = callOutTable(list, "GetCurrentBoxSlots")
    if out == nil then return nil end
    local slots, n = {}, 0
    for _ in pairs(out) do n = n + 1 end
    for i = 1, n do
        local b = unwrap(out[i])
        if valid(b) then slots[#slots + 1] = b end
    end
    return slots
end

----------------------------------------------------------------------
-- Which Pal is the cursor on?
--
-- The container caches it, which is the cheapest answer. If that read fails,
-- fall back to asking each slot on the page whether it is hovered - confirmed
-- working, exactly one slot reports true.
----------------------------------------------------------------------
--- Ask the widgets what the cursor is on before trusting the container's
--- cache. The move route has to write to that cache, so after a sweep it
--- points at the last Pal we sent rather than at the cursor - which would put
--- us on the wrong side of the screen entirely.
---
--- The cache holds a PalIndividualCharacterSlot, the Pal's data slot rather
--- than the widget, so it is matched against each button's target slot.
local function hoveredByCursor(slots)
    for _, b in ipairs(slots) do
        if callOn(b, "IsHovered") == true then return b end
    end
    return nil
end

local function hoveredByCache(container, slots)
    local cachedAddr = addressOf(readField(container, "CachedLastHoveredSlot"))
    if cachedAddr == nil then return nil end
    for _, b in ipairs(slots) do
        if addressOf(b) == cachedAddr then return b end
        local target = callOut(b, "GetTargetSlot")
        if target ~= nil and addressOf(target) == cachedAddr then return b end
    end
    return nil
end

----------------------------------------------------------------------
-- Matching
----------------------------------------------------------------------

-- The condensed guard can be flipped at runtime. Lua only loads at startup, so
-- without this, changing your mind about it costs a full restart of the game.
local skipCondensed = (config.skip_condensed ~= false)

local function toggleCondensedGuard()
    skipCondensed = not skipCondensed
    if skipCondensed then
        log("Condensed guard ON - Pals above rank 1 stay where they are.")
    else
        log("Condensed guard OFF - condensed Pals move like any other.")
        log("This lasts until you quit. Set skip_condensed = false in config.lua")
        log("to make it the default.")
    end
end

local function baseSpecies(name)
    if name == nil then return nil end
    return (name:gsub("^BOSS_", ""))
end

local function sameSpecies(a, b)
    if a == nil or b == nil then return false end
    if a == b then return true end
    if config.include_boss_variants then return baseSpecies(a) == baseSpecies(b) end
    return false
end

--- Returns eligible, reasonKey, detail.
--- The key is short enough to tally; the detail is for a human reading a line.
local function eligible(info, reference)
    if info == nil or info.species == nil then return false, "empty" end
    if not sameSpecies(info.species, reference.species) then return false, "different Pal" end
    if config.match_mode == "species_level"
       and type(info.level) == "number" and type(reference.level) == "number"
       and info.level ~= reference.level then
        return false, "different level", "Lv " .. info.level
    end
    if skipCondensed and type(info.rank) == "number" and info.rank > 1 then
        return false, "condensed", "rank " .. info.rank
    end
    if config.skip_favorites and info.favourite == true then
        return false, "favourite"
    end
    return true
end

--- Turn a tally like { condensed = 13 } into "13 condensed".
local function summariseReasons(tally)
    local parts = {}
    for key, count in pairs(tally) do
        parts[#parts + 1] = count .. " " .. key
    end
    table.sort(parts)
    return table.concat(parts, ", ")
end

----------------------------------------------------------------------
-- Moving one Pal.
--
-- Route 1 replays the game's own right-click, so capacity checks, sync and
-- ownership all still run. The other two exist only in case a patch renames
-- it. Whichever route first actually empties a slot is remembered and reused.
----------------------------------------------------------------------
local confirmedRoute = nil

local function attemptRoute(routeName, container, button)
    if routeName == "right-click" then
        local ok, err = tryCall(button, "OnRightClicked_Internal")
        if not ok then return false, err end
        return true

    elseif routeName == "send-input" then
        -- Point the container's cache at the slot we want, then run the same
        -- handler the "Move" input runs.
        --
        -- The type written here MUST be the type the game expects, because the
        -- game's own Blueprint immediately calls slot functions on it. Hand it
        -- a slot button instead of a character slot and Unreal aborts the
        -- process - not a Lua error, a hard crash. So: default to the slot,
        -- which is the type this has always worked with, and only write the
        -- button if the value already sitting there is positively identified
        -- as a button. Never guess.
        local slot = callOut(button, "GetTargetSlot")
        local cachedName = classNameOf(readField(container, "CachedLastHoveredSlot"))

        local toWrite = slot
        if cachedName ~= nil and cachedName:find("SlotButton", 1, true) then
            toWrite = button
        end

        if toWrite == nil then
            return false, "could not resolve a character slot for this button"
        end
        -- If we believe we are writing a slot, prove it is slot-shaped first.
        if toWrite ~= button and not hasFunction(toWrite, "IsEmpty") then
            return false, "that object does not look like a character slot"
        end

        if not writeField(container, "CachedLastHoveredSlot", toWrite) then
            return false, "could not write CachedLastHoveredSlot"
        end
        local ok, err = tryCall(container, "OnSendSlotInput")
        if not ok then return false, err end
        return true

    elseif routeName == "bound-delegate" then
        local ok, err = tryCall(container, BND_RIGHT_CLICK_BOX, button)
        if not ok then
            local ok2, err2 = tryCall(container, BND_RIGHT_CLICK_BOX)
            if not ok2 then return false, err .. " / " .. err2 end
        end
        return true

    end
    return false, "unknown route"
end

-- send-input leads because it is the route that works. The other two run
-- without complaint and move nothing, so trying them first would only waste a
-- verification window on the first Pal of the session.
local ROUTES = { "send-input", "right-click", "bound-delegate" }

local VERIFY_MS_FAST = 250   -- normal case: the slot clears almost at once
local VERIFY_MS_SLOW = 600   -- retry case: give the server room to catch up

--- Has this Pal left the slot?
---
--- The box empties a slot in place. The conveyor is a scroll list, so removing
--- one either destroys the widget or shuffles a different Pal into it. All
--- three count as gone.
local function slotVacated(button, species)
    if not valid(button) then return true end
    if slotIsEmpty(button) == true then return true end
    if species ~= nil then
        local info = inspect(button)
        if info == nil or info.species ~= species then return true end
    end
    return false
end

--- Move one Pal and confirm it actually left. Returns true, routeName.
local function moveOne(container, button, patient, species)
    if slotVacated(button, nil) then return false, nil, "already empty" end

    local known = confirmedRoute
    local routes = known and { known } or ROUTES

    -- Until a route is confirmed, report each attempt at normal level. verbose
    -- is off by default, and "nothing moved" with no reason logged is not a bug
    -- report anyone can act on.
    local note = known and vlog or log
    local lastError = nil

    for _, routeName in ipairs(routes) do
        local ok, err = attemptRoute(routeName, container, button)
        if not ok then
            lastError = routeName .. ": " .. tostring(err)
            note("  route " .. lastError)
        else
            local moved = waitUntil(function() return slotVacated(button, species) end,
                                    patient and VERIFY_MS_SLOW or VERIFY_MS_FAST)
            if moved then
                if confirmedRoute ~= routeName then
                    confirmedRoute = routeName
                    log("Working route: " .. routeName)
                end
                return true, routeName
            end
            lastError = routeName .. ": ran, but the Pal did not move"
            note("  route " .. lastError)
        end
    end

    return false, nil, lastError or "no route worked"
end

----------------------------------------------------------------------
-- The three actions
----------------------------------------------------------------------

-- The Pal the cursor was last on. Kept because the hovered Pal is itself a
-- candidate: once it has been sent across, the cursor is sitting over an empty
-- slot, and pressing the key again should carry on rather than give up.
local lastReference = nil

--- Shared setup. Returns container, pageSlots, reference, hovered
--- or nil plus a reason.
local function prepare()
    local container = findContainer()
    if container == nil then
        return nil, "Open the Pal Disassembly Conveyor first."
    end
    if not titleAllowed(container) then
        return nil, "This screen is \"" .. tostring(titleOf(container)) ..
                    "\", which config.restrict_to_title excludes."
    end

    local pageSlots = getPageSlots(container)
    if pageSlots == nil or #pageSlots == 0 then
        return nil, "Could not read the box page."
    end

    local hovered = hoveredByCursor(pageSlots) or hoveredByCache(container, pageSlots)
    local how = hovered and "cursor" or nil

    local reference = hovered and inspect(hovered) or nil

    if reference == nil or reference.species == nil then
        -- The cursor is over an empty slot. Very often that is the slot we
        -- just emptied, so carry on with the Pal it used to hold.
        if lastReference ~= nil then
            reference = lastReference
            how = "remembered from the last press"
        elseif hovered == nil then
            return nil, "Hover the mouse over a Pal in the box grid, then press the key."
        else
            return nil, "That slot is empty. Hover a Pal and try again."
        end
    else
        lastReference = reference
    end

    vlog(string.format("Reference: %s Lv %s rank %s  (%s)",
        tostring(reference.species), tostring(reference.level),
        tostring(reference.rank), tostring(how)))

    return container, pageSlots, reference, hovered
end

local function describe(info)
    if info == nil then return "<empty>" end
    return string.format("%s Lv %s%s%s",
        tostring(info.species), tostring(info.level),
        (type(info.rank) == "number" and info.rank > 1) and (" rank " .. info.rank) or "",
        info.favourite == true and " [fav]" or "")
end

local function dryRun()
    local container, pageSlots, reference, hovered = prepare()
    if container == nil then log(pageSlots) return end

    log("")
    log("---- dry run: nothing will move ----")
    local title = titleOf(container)
    if title then log("screen: " .. title) end
    log("reference Pal: " .. describe(reference))
    log(string.format("guard readings on that Pal: rank=%s  favourite=%s (%s)",
        tostring(reference.rank), tostring(reference.favourite),
        tostring(reference.favouriteVia)))

    local wouldMove, heldBack, otherPals = 0, 0, 0
    local tally, firstHeld = {}, nil
    for i, button in ipairs(pageSlots) do
        local info = inspect(button)
        local ok, reason, detail = eligible(info, reference)
        if ok then
            wouldMove = wouldMove + 1
            log(string.format("  [%02d] MOVE  %s", i, describe(info)))
        elseif info ~= nil and reason ~= "empty" then
            if reason == "different Pal" then
                otherPals = otherPals + 1
            else
                heldBack = heldBack + 1
                tally[reason] = (tally[reason] or 0) + 1
                if firstHeld == nil then firstHeld = button end
                log(string.format("  [%02d] KEEP  %s   (%s%s)", i, describe(info),
                    reason, detail and (": " .. detail) or ""))
            end
        end
    end

    -- Print every rank-shaped number for one Pal the guard let through and one
    -- it stopped. Compare them against the stars on screen and it is obvious
    -- whether the guard is reading the right field.
    log("")
    log("rank sources, the Pal you are hovering:")
    log("   " .. rankSources(paramFromButton(hovered)))
    if firstHeld ~= nil then
        log("rank sources, the first Pal a guard stopped:")
        log("   " .. rankSources(paramFromButton(firstHeld)))
    end
    log("")
    log(string.format("Would move %d. Held back %d by the guards%s. %d other Pals untouched.",
        wouldMove, heldBack,
        heldBack > 0 and (" - " .. summariseReasons(tally)) or "",
        otherPals))

    -- Whole pages of condensed Pals are usually not hand-condensed keepers.
    -- Some arrive that way: a mutated egg hatches an alpha at two stars.
    if heldBack >= 5 and heldBack >= wouldMove and (tally["condensed"] or 0) >= 5 then
        log("The condensed guard is holding back most of this page.")
        log("Some Pals arrive condensed on their own - mutated eggs hatch alphas at")
        log("two stars - so a box bred for disassembly can read as condensed.")
        log("Press " .. tostring(config.guard_toggle_key) ..
            " to turn the guard off for this session.")
        log("")
    end

    log("---- end dry run ----")
end

local function doMove(limit)
    local container, pageSlots, reference, hovered = prepare()
    if container == nil then log(pageSlots) return end

    -- The Pal under the cursor is a candidate like any other, but it is also
    -- the reference. Send it last so the cursor keeps pointing at something
    -- real for as long as possible.
    local hoveredAddr = addressOf(hovered)
    local targets, hoveredTarget, heldBack = {}, nil, 0
    local tally = {}
    for _, button in ipairs(pageSlots) do
        local info = inspect(button)
        local ok, reason, detail = eligible(info, reference)
        if ok then
            local entry = { button = button, info = info }
            if hoveredAddr ~= nil and addressOf(button) == hoveredAddr then
                hoveredTarget = entry
            else
                targets[#targets + 1] = entry
            end
        elseif info ~= nil and reason ~= "different Pal" and reason ~= "empty" then
            -- Same Pal, but a guard says no. Worth counting, and worth naming:
            -- a guard that saves a condensed Pal should be visible without a
            -- dry run, and "kept back" on its own does not say which guard.
            heldBack = heldBack + 1
            tally[reason] = (tally[reason] or 0) + 1
            vlog(string.format("  keeping %s (%s%s)", describe(info),
                tostring(reason), detail and (": " .. detail) or ""))
        end
    end
    if hoveredTarget ~= nil then targets[#targets + 1] = hoveredTarget end

    if #targets == 0 then
        log(string.format("Nothing on this page matches %s.%s",
            tostring(reference.species),
            heldBack > 0 and (" " .. summariseReasons(tally) ..
                              " held back by the guards.") or ""))
        return
    end

    -- The container caches what the cursor is on, and the send route has to
    -- repoint it. Put it back afterwards so the screen is left as we found it.
    local cacheBefore = readField(container, "CachedLastHoveredSlot")

    local moved, refused, consecutiveFailures = 0, 0, 0
    local stalled = {}
    local discovering = (confirmedRoute == nil)

    -- Pass one.
    for i, entry in ipairs(targets) do
        if limit and moved >= limit then break end

        local ok, _, why = moveOne(container, entry.button, discovering and i == 1,
                                   entry.info and entry.info.species)
        if ok then
            moved = moved + 1
            consecutiveFailures = 0
        elseif confirmedRoute == nil then
            -- Nothing moved on the first Pal of the session. A broken transfer
            -- route and a conveyor with no room look identical from here, so
            -- give it one patient retry before drawing any conclusion.
            vlog("  first Pal did not move - retrying patiently before giving up")
            if moveOne(container, entry.button, true, entry.info and entry.info.species) then
                moved = moved + 1
                consecutiveFailures = 0
            else
                log("That Pal would not move. Either the conveyor is full, or a game")
                log("update has changed how Pals are transferred.")
                log("If there is room in the conveyor, press " ..
                    tostring(config.dump_key) .. " and send UE4SS.log - the mod")
                log("has stopped rather than repeat a call that is doing nothing.")
                vlog("  last route result: " .. tostring(why))
                return
            end
        elseif entry.info ~= nil and entry.info.favourite == true then
            -- The game refuses to move favourites. That is the game working as
            -- intended, not a sign of trouble.
            refused = refused + 1
            vlog("  the game would not move a favourite - left in the box")
        else
            stalled[#stalled + 1] = entry
            consecutiveFailures = consecutiveFailures + 1
            if consecutiveFailures >= (config.stop_after_failures or 4) then
                vlog("  pausing pass one after " .. consecutiveFailures .. " in a row")
                break
            end
        end
    end

    -- Pass two. A move that had not landed yet is not a move that will not
    -- land, and pass one is quick enough that the difference matters. By now
    -- some of these will have gone through on their own.
    local failed = 0
    if #stalled > 0 and (not limit or moved < limit) then
        vlog("Second pass over " .. #stalled .. " that had not moved yet.")
        for _, entry in ipairs(stalled) do
            if limit and moved >= limit then break end
            if slotVacated(entry.button, entry.info and entry.info.species) then
                moved = moved + 1                      -- landed late
            elseif moveOne(container, entry.button, true, entry.info and entry.info.species) then
                moved = moved + 1
            else
                failed = failed + 1
            end
        end
    end

    if valid(cacheBefore) then
        writeField(container, "CachedLastHoveredSlot", cacheBefore)
    end

    log(string.format("Sent %d %s to the conveyor%s%s%s.",
        moved, tostring(reference.species),
        heldBack > 0 and (" (" .. summariseReasons(tally) .. " kept back)") or "",
        failed   > 0 and (" (" .. failed .. " stayed put)") or "",
        refused  > 0 and (" (" .. refused .. " favourite left in the box)") or ""))

    if failed > 0 then
        log("The destination may be full, or the game may still be catching up. " ..
            "Press " .. tostring(config.move_key) .. " again to sweep up the rest.")
    end
end

----------------------------------------------------------------------
-- F9 : read-only diagnostic.
----------------------------------------------------------------------

----------------------------------------------------------------------
local function dumpClassTree(obj, label, maxLevels)
    log("")
    log("---- " .. label .. " ----")
    if not valid(obj) then log("   <not available>") return end
    log("   object: " .. nameOf(obj))

    local cls = callOn(obj, "GetClass")
    local level = 0
    while valid(cls) and level < (maxLevels or 6) do
        log("   [level " .. level .. "] " .. nameOf(cls))
        local fns, props = {}, {}
        pcall(function()
            cls:ForEachFunction(function(fn)
                fns[#fns + 1] = fnameToString(callOn(fn, "GetFName")) or "?"
            end)
        end)
        pcall(function()
            cls:ForEachProperty(function(pr)
                props[#props + 1] = fnameToString(callOn(pr, "GetFName")) or "?"
            end)
        end)
        log("      functions:  " .. (#fns > 0 and table.concat(fns, ", ") or "<none>"))
        log("      properties: " .. (#props > 0 and table.concat(props, ", ") or "<none>"))

        local nextCls = callOn(cls, "GetSuperStruct") or callOn(cls, "GetSuper")
        if not valid(nextCls) then break end
        cls = nextCls
        level = level + 1
    end
end

local function diagnostic()
    log("")
    log("======== DIAGNOSTIC  v" .. VERSION .. " ========")

    local container = findContainer()
    if container == nil then
        log("No transfer screen open.")
        log("======== END ========")
        return
    end

    log("screen:  " .. nameOf(container))
    log("title:   " .. tostring(titleOf(container)))
    log("route:   " .. tostring(confirmedRoute or "<not yet established>"))

    local cached = readField(container, "CachedLastHoveredSlot")
    log("CachedLastHoveredSlot: " .. tostring(classNameOf(cached)) .. "  " .. nameOf(cached))
    log("hoverdSlotType: " .. tostring(readField(container, "hoverdSlotType")) ..
        "   (the side the cursor is on)")

    -- The conveyor has no right-click or Move action - it is drag-and-drop

    -- These are the candidates; their parameter lists say how to call them.
    log("")
    local pageSlots = getPageSlots(container)
    log("")
    log("page slots: " .. tostring(pageSlots and #pageSlots or "unreadable"))
    if pageSlots then
        for i, button in ipairs(pageSlots) do
            local info = inspect(button)
            log(string.format("   [%02d] %-32s hovered=%-5s empty=%-5s fav=%s via %s",
                i, describe(info), tostring(callOn(button, "IsHovered")),
                tostring(slotIsEmpty(button)),
                tostring(info and info.favourite),
                tostring(info and info.favouriteVia)))
        end
    end

    log("======== END ========")
end

----------------------------------------------------------------------
-- Key binding.
--
-- UE4SS keybinds are global, so every action checks the transfer screen is
-- actually open first and quietly does nothing otherwise. That keeps V free
-- everywhere else in the game.
----------------------------------------------------------------------
local function bind(keyName, fn, needsScreen)
    if keyName == nil then return end
    local keyCode = Key[keyName]
    if keyCode == nil then
        log("Unknown key in config.lua: " .. tostring(keyName))
        return
    end
    RegisterKeyBind(keyCode, function()
        if needsScreen and findContainer() == nil then return end
        pcall(fn)
    end)
end

pcall(function()
    bind(config.move_key,         function() doMove(nil) end, true)
    bind(config.move_one_key,     function() doMove(1)   end, true)
    bind(config.dry_run_key,      dryRun,                     true)
    bind(config.guard_toggle_key, toggleCondensedGuard,       false)
    bind(config.dump_key,         diagnostic,                 false)
end)

log(string.format(
    "v%s loaded.  %s = move all matching on the page, %s = move one, " ..
    "%s = dry run, %s = toggle condensed guard, %s = diagnostic.",
    VERSION, tostring(config.move_key), tostring(config.move_one_key),
    tostring(config.dry_run_key), tostring(config.guard_toggle_key),
    tostring(config.dump_key)))
