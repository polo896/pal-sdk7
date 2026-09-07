--[[
    FAST TRAVEL UNLOCKER  v2.0      By Wol4ara896
    ==================================================================
    Rebuilt for Palworld 1.0.4 (SDK dump: sdk-dumper-7).

    Chat commands
        !collecteagle            unlock everything (statues + map pillars)
        !eagle statues           statues only
        !eagle pillars           map pillars only
        !collecteaglenoexp       same as !collecteagle with EXP rate 0
        !eagle statues noexp     / !eagle pillars noexp
        !collecteaglemapclear    erase the map fog around the player
        !eaglediag               read-only dump of everything this mod needs
        !restore                 put the EXP rate back by hand

    ------------------------------------------------------------------
    WHAT BROKE IN 1.0.4 AND WHY
    ------------------------------------------------------------------
    v1 did this:

        playerNetwork:RequestUnlockFastTravelPoint_ToServer(guidOrName)

    That UFunction NO LONGER EXISTS. Checked against the 1.0.4 dump:

        sdk-dumper-7/GObjects-Dump.txt
          -> Pal.PalNetworkPlayerComponent has 77 functions in 1.0.4,
             not one of them contains "FastTravel" or "UnlockFastTravel".
          -> the only surviving fast-travel functions in the whole
             Pal package are:
                Pal.PalLevelObjectUnlockableFastTravelPoint.OnTriggerInteract
                Pal.PalLevelObjectUnlockableFastTravelPoint.OnUpdateFlagMapRecord
                Pal.PalLevelObjectUnlockableFastTravelPoint.OnCompleteSyncPlayer
                Pal.PalLevelObjectUnlockableFastTravelPoint.IsUnlocked
                Pal.PalLocationPointFastTravel.IsUnlockMapPoint
                Pal.PalPlayerController.RequestFastTravel_ToServer  (travel, not unlock)

    The call was wrapped in pcall, so it failed silently, and the old
    counter counted loop iterations instead of real unlocks - hence
    "Unlocked 174 fast travel points" in the log with nothing unlocked.
    !collecteaglemapclear kept working because it never used that RPC.

    Where the unlock state actually lives in 1.0.4:

        UPalPlayerRecordData.FastTravelPointUnlockFlag
            (FPalPlayerRecordDataRepInfoArrayThreadSafe_BoolVal, Net,
             Pal_classes.hpp:60723)  -  keyed by FastTravelPointID (FName)

    and the statue actor reacts to it through
    APalLevelObjectUnlockableFastTravelPoint::OnUpdateFlagMapRecord.
    Point unlocking was folded into the generic level-object interact
    path:

        Pal.PalNetworkPlayerComponent.RequestInteractLevelObject_ToServer
            (TScriptInterface<IPalInteractableLevelObjectInterface>)

    ------------------------------------------------------------------
    HOW v2 UNLOCKS
    ------------------------------------------------------------------
    It stops inventing its own RPC and drives the game's own code, on
    the real statue actors, then VERIFIES each one. Two routes, tried in
    order per point, first one that sticks wins:

      1. statue:OnTriggerInteract(playerCharacter, 26)
         26 = EPalInteractiveObjectIndicatorType::UnlockFastTravel
         (Pal_structs.hpp:483). This is exactly what pressing F on the
         statue runs, so the game does the RPC, the record write, the
         EXP, the sound and the map update itself.

      2. playerNetwork:RequestInteractLevelObject_ToServer(statue)
         the raw 1.0.4 server request, in case route 1 is gated on
         something local (indicator state, distance, cutscene).

    Why there is no third "just write the record flag" route:

        PalPlayerRecordDataUtility.SetRecordData_Bool_ForServer takes
        FastTravelPointUnlockFlag as a non-const struct REFERENCE
        (Parm, OutParm, ReferenceParm - Pal_parameters.hpp:12133).
        UE4SS builds its own parameter buffer for every UFunction call
        (call_ufunction_from_lua) and, for a non-const out param, it
        demands a Lua TABLE and copies the struct in and back out of
        that table (push_structproperty -> convert_lua_table_to_struct).
        So the native code would edit a temporary copy, not the player
        record. It cannot work from Lua, so it is not pretended here.

        Reading is fine: GetRecordData_Bool takes the struct as a CONST
        reference, so UE4SS deep-copies the real struct in and the value
        that comes back is the real one. That is what verification uses.

    All 176 statue actors (153 BP_LevelObject_TowerFastTravelPoint_C +
    23 BP_LevelObject_UnlockMapPoint_C) live in the persistent level and
    are loaded at all times - they are not streamed - so this reaches
    every point on the map, not just nearby ones.

    VERIFICATION. After the batch, the mod walks
    UPalPlayerRecordData.FastTravelPointUnlockFlag.Items once and builds
    the set of IDs the SAVE says are unlocked - that is the authority,
    not the actor and definitely not the mod's own writes. Points that
    are still missing are retried, then reported. The final line of the
    log is the real number, never the loop counter again.

    ------------------------------------------------------------------
    RULES THIS FILE OBEYS
    ------------------------------------------------------------------
    * NEVER call a UFunction without checking the object's class has it.
      A missing UFunction is a LowLevelFatalError from ScriptCore.cpp -
      a hard abort pcall cannot catch. See hasFunction().
    * Work is done in batches on the game thread. 174 interacts in one
      frame is a stall and the server drops requests.
    * Solo / listen-server is the target. Dedicated servers are not
      supported: the interact request needs server authority.
--]]

local MOD     = "[EagleCollector]"
local VERSION = "2.0"

local CONFIG = {
    ChatCommand        = "!collecteagle",
    ChatCommandNoExp   = "!collecteaglenoexp",
    ChatCommandMap     = "!collecteaglemapclear",
    ChatCommandStatues = "!eagle statues",
    ChatCommandPillars = "!eagle pillars",
    ChatCommandDiag    = "!eaglediag",
    ChatCommandRestore = "!restore",

    -- Unlock pacing. 6 points every 100 ms clears the whole map in ~3 s
    -- without a frame stall. Raise BatchDelayMs if you see hitching.
    BatchSize          = 6,
    BatchDelayMs       = 100,

    -- The unlock round-trips through the server, so a point that is not
    -- unlocked yet is not the same as one that will not unlock. Wait,
    -- then re-check, then retry the leftovers.
    VerifyDelayMs      = 2000,
    RetryPasses        = 2,

    -- After every route failed: write the client-side flags anyway so the
    -- icon shows up. Cosmetic, may not survive a reload - it is reported
    -- separately in the result line, never counted as a real unlock.
    LocalFallback      = true,

    ExpRestoreDelayMs  = 3000,

    MapClearPaintSize  = 99999.0,
    MapClearDurationMs = 10000,
    MapClearIntervalMs = 250,

    Verbose            = false,
}

-- EPalInteractiveObjectIndicatorType::UnlockFastTravel  (Pal_structs.hpp:483)
local INDICATOR_UNLOCK_FAST_TRAVEL = 26

-- Statue / pillar actor classes. FindAllOf is asked for all of them and the
-- results are de-duplicated by address, so an extra name here costs nothing.
local STATUE_CLASSES = {
    "BP_LevelObject_TowerFastTravelPoint_C",   -- 153 in the 1.0.4 dump (statues)
    "BP_LevelObject_UnlockMapPoint_C",         --  23 in the 1.0.4 dump (map pillars)
    "PalLevelObjectUnlockableFastTravelPoint", -- native base, just in case
}

----------------------------------------------------------------------
-- Logging
----------------------------------------------------------------------
local function log(msg)  print(string.format("%s %s\n", MOD, tostring(msg))) end
local function vlog(msg) if CONFIG.Verbose then log(msg) end end

----------------------------------------------------------------------
-- Safety helpers
--
-- Touching a stale UObject aborts the whole Lua callback and pcall does
-- not catch it, so everything goes through valid() first.
----------------------------------------------------------------------
local function valid(object)
    if object == nil then return false end
    local ok, result = pcall(function() return object:IsValid() end)
    return ok and result == true
end

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

local function nameOf(object)
    if not valid(object) then return "<invalid>" end
    local ok, n = pcall(function() return object:GetFullName() end)
    return (ok and n) or "<unnamed>"
end

-- GetAddress bypasses reflection, so it is a safe table key.
local function addressOf(object)
    if not valid(object) then return nil end
    local ok, addr = pcall(function() return object:GetAddress() end)
    return (ok and addr) or nil
end

local function classNameOf(object)
    if not valid(object) then return "<invalid>" end
    local cls = callOnRaw(object, "GetClass")
    return fnameToString(callOnRaw(cls, "GetFName")) or "<unknown>"
end

----------------------------------------------------------------------
-- Does this object's class actually have this UFunction?
--
-- THIS IS NOT OPTIONAL. Calling a UFunction the object does not have is
-- a LowLevelFatalError inside ScriptCore.cpp: a hard engine abort that
-- pcall CANNOT catch. It is also the whole reason v1 looked healthy in
-- the log while doing nothing - so v2 asks first, every time.
-- The answer is cached per class.
----------------------------------------------------------------------
local functionCache = {}

local function classFunctionSet(cls)
    if not valid(cls) then return {} end
    local key = addressOf(cls)
    if key == nil then return {} end

    local known = functionCache[key]
    if known ~= nil then return known end

    known = {}
    local current = cls
    for _ = 1, 12 do
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
    return known
end

local function hasFunction(object, methodName)
    if not valid(object) then return false end
    local cls = callOnRaw(object, "GetClass")
    if not valid(cls) then return false end
    return classFunctionSet(cls)[methodName] == true
end

--- Checked call. Returns ok, result-or-error.
local function tryCall(object, methodName, ...)
    if not valid(object) then return false, "invalid object" end
    if not hasFunction(object, methodName) then
        return false, "class has no function " .. methodName
    end
    local args = { ... }
    local ok, res = pcall(function() return object[methodName](object, table.unpack(args)) end)
    if ok then return true, res end
    return false, tostring(res)
end

local function readField(object, fieldName)
    if not valid(object) then return nil end
    local ok, v = pcall(function() return object[fieldName] end)
    return ok and v or nil
end

local function writeField(object, fieldName, value)
    if not valid(object) then return false end
    return pcall(function() object[fieldName] = value end)
end

----------------------------------------------------------------------
-- World handles
----------------------------------------------------------------------
local function firstValidOf(className)
    local list = FindAllOf(className)
    if not list then return nil end
    for _, o in ipairs(list) do
        if valid(o) then return o end
    end
    return nil
end

local function getPlayerController()
    local controllers = FindAllOf("BP_PalPlayerController_C") or FindAllOf("PalPlayerController")
    if controllers then
        for _, c in ipairs(controllers) do
            if valid(c) and hasFunction(c, "IsLocalPlayerController") then
                local ok, isLocal = pcall(function() return c:IsLocalPlayerController() end)
                if ok and isLocal == true then return c end
            end
        end
        for _, c in ipairs(controllers) do
            if valid(c) then return c end
        end
    end
    return nil
end

local function getPlayerCharacter(pc)
    if valid(pc) then
        local pawn = readField(pc, "Pawn")
        if valid(pawn) then return pawn end
        local char = readField(pc, "Character")
        if valid(char) then return char end
    end
    return firstValidOf("BP_PalPlayerCharacter_C") or firstValidOf("PalPlayerCharacter")
end

local function getPlayerState(pc)
    if valid(pc) then
        local ps = readField(pc, "PlayerState")
        if valid(ps) then return ps end
    end
    return firstValidOf("BP_PalPlayerState_C") or firstValidOf("PalPlayerState")
end

local function getPlayerNetwork(pc)
    if not valid(pc) then return nil end
    local transmitter = readField(pc, "Transmitter")
    if not valid(transmitter) then return nil end
    local net = readField(transmitter, "Player")
    if valid(net) then return net end
    return nil
end

local function getRecordData(ps)
    if not valid(ps) then return nil end
    local ok, rd = tryCall(ps, "GetRecordData")
    if ok and valid(rd) then return rd end
    return nil
end

local function getRecordUtility()
    local cdo = StaticFindObject("/Script/Pal.Default__PalPlayerRecordDataUtility")
    if valid(cdo) then return cdo end
    return nil
end

local function getOptionSubsystem()
    return firstValidOf("PalOptionSubsystem")
end

----------------------------------------------------------------------
-- EXP rate
----------------------------------------------------------------------
local pendingRestoreRate = nil

local function setExpRate(rate)
    local subsystem = getOptionSubsystem()
    if not subsystem then return false end
    return pcall(function() subsystem.OptionWorldSettings.ExpRate = rate end)
end

local function getExpRate()
    local subsystem = getOptionSubsystem()
    if not subsystem then return nil end
    local ok, val = pcall(function() return subsystem.OptionWorldSettings.ExpRate end)
    return ok and val or nil
end

----------------------------------------------------------------------
-- Target discovery
--
-- Location points (UPalLocationPointFastTravel, 174 of them) carry
-- bUnlockMapPoint, which is what separates a statue from a map pillar.
-- The statue ACTORS are what can actually be interacted with, so the two
-- lists are joined on FastTravelPointID.
----------------------------------------------------------------------
local function collectLocationPoints()
    local byId, count = {}, 0
    local points = FindAllOf("PalLocationPointFastTravel")
    if not points then return byId, 0 end

    for _, loc in ipairs(points) do
        if valid(loc) then
            local id = fnameToString(readField(loc, "FastTravelPointID"))
            if id and id ~= "" and id ~= "None" then
                local isPillar = false
                if hasFunction(loc, "IsUnlockMapPoint") then
                    local ok, res = pcall(function() return loc:IsUnlockMapPoint() end)
                    isPillar = (ok and res == true)
                end
                if not isPillar then
                    isPillar = (readField(loc, "bUnlockMapPoint") == true)
                end
                byId[id] = { loc = loc, isPillar = isPillar }
                count = count + 1
            end
        end
    end
    return byId, count
end

local function collectStatues(locById, filterMode)
    local seen, out = {}, {}

    for _, className in ipairs(STATUE_CLASSES) do
        local list = FindAllOf(className)
        if list then
            for _, actor in ipairs(list) do
                local addr = addressOf(actor)
                if addr and not seen[addr] then
                    seen[addr] = true

                    local id = fnameToString(readField(actor, "FastTravelPointID"))
                    if id and id ~= "" and id ~= "None" then
                        local info = locById[id]
                        local isPillar
                        if info ~= nil then
                            isPillar = info.isPillar
                        else
                            isPillar = string.find(classNameOf(actor), "UnlockMapPoint") ~= nil
                        end

                        local keep = (filterMode == "all")
                            or (filterMode == "statues" and not isPillar)
                            or (filterMode == "pillars" and isPillar)

                        if keep then
                            out[#out + 1] = {
                                actor    = actor,
                                id       = id,
                                idName   = readField(actor, "FastTravelPointID"),
                                isPillar = isPillar,
                                loc      = info and info.loc or nil,
                            }
                        end
                    end
                end
            end
        end
    end

    return out
end

----------------------------------------------------------------------
-- Unlock state readers
--
-- Two of them, on purpose:
--
--   isUnlockedFast  - asks the actor (statue:IsUnlocked). One reflection
--                     call, used for the immediate "did that route do
--                     anything" check inside the batch loop.
--
--   refreshUnlocked - walks UPalPlayerRecordData.FastTravelPointUnlockFlag
--                     .Items once and builds a set of the IDs the SAVE
--                     says are unlocked. This is the authority, and it is
--                     what the counters report.
--
-- The record is read through the fast-array Items rather than through
-- GetRecordData_Bool(struct, key), because every call of that function
-- makes UE4SS deep-copy the whole 456 byte record struct into its own
-- parameter buffer. One array walk beats 174 struct copies.
--
-- Why the authority matters: the cosmetic fallback writes bUnlocked on
-- the actor, so the actor can claim to be unlocked when the save does
-- not agree. v1 believing its own writes is exactly the bug being fixed.
----------------------------------------------------------------------
local function iterateArray(arr, callback)
    if arr == nil then return false end

    local touched = false
    local okForEach = pcall(function()
        arr:ForEach(function(_, element)
            touched = true
            callback(element)
        end)
    end)
    if okForEach and touched then return true end
    if touched then return true end

    local num = nil
    if not pcall(function() num = arr:GetArrayNum() end) then return false end
    if type(num) ~= "number" then return false end

    for i = 1, num do
        local element = nil
        if pcall(function() element = arr[i] end) then
            callback(element)
            touched = true
        end
    end
    return touched or num == 0
end

--- RemoteUnrealParam / LocalUnrealParam wrappers need :get() before use.
local function unwrap(parameter)
    if parameter == nil or type(parameter) ~= "userdata" then return parameter end
    local ok, t = pcall(function() return parameter:type() end)
    if not ok or (t ~= "RemoteUnrealParam" and t ~= "LocalUnrealParam") then
        return parameter
    end
    local ok2, v = pcall(function() return parameter:get() end)
    return ok2 and v or parameter
end

--- Set of FastTravelPointID -> true, straight out of the player record.
--- Returns nil when the record cannot be read at all.
local function refreshUnlocked(ctx)
    if not valid(ctx.recordData) then
        ctx.unlockedSet = nil
        return nil
    end

    local set, count, seen = {}, 0, 0
    local ok = pcall(function()
        local items = ctx.recordData.FastTravelPointUnlockFlag.Items
        iterateArray(items, function(element)
            local entry = unwrap(element)

            -- Struct entries are NOT UObjects, so readField()/valid() are the
            -- wrong tool here: read the fields straight off the userdata.
            local rawKey, rawValue = nil, nil
            pcall(function() rawKey = entry.Key end)
            pcall(function() rawValue = entry.Value end)

            local key = fnameToString(rawKey) or (type(rawKey) == "string" and rawKey or nil)
            if key and key ~= "" and key ~= "None" then
                local value = rawValue == true
                set[key] = value
                seen = seen + 1
                if value then count = count + 1 end
            end
        end)
    end)

    if not ok then
        vlog("player record not readable from Lua, falling back to statue:IsUnlocked()")
        ctx.unlockedSet = nil
        return nil
    end

    -- Zero entries means either a save where nothing is unlocked yet, or a
    -- read that silently produced nothing. Both are handled the same way:
    -- do not trust the set, ask the actors. Trusting an empty set would let
    -- the mod declare "0 unlocked" right after unlocking everything.
    if seen == 0 then
        vlog("player record has no entries yet, using statue:IsUnlocked()")
        ctx.unlockedSet = nil
        return nil
    end

    ctx.unlockedSet = set
    return count
end

--- Cheap, actor-level.
local function isUnlockedFast(ctx, target)
    if hasFunction(target.actor, "IsUnlocked") then
        local ok, res = pcall(function() return target.actor:IsUnlocked() end)
        if ok then return res == true end
    end
    return readField(target.actor, "bUnlocked") == true
end

--- Authoritative when the record could be read, actor-level otherwise.
local function isUnlocked(ctx, target)
    if ctx.unlockedSet ~= nil then
        return ctx.unlockedSet[target.id] == true
    end
    return isUnlockedFast(ctx, target)
end

----------------------------------------------------------------------
-- The unlock routes
--
-- Each returns true when it managed to RUN. Whether it WORKED is decided
-- afterwards by isUnlocked() - never by the route itself. That confusion
-- is what made v1 report 174 successes on zero unlocks.
----------------------------------------------------------------------

-- Route 1: run the game's own interact handler on the statue.
local function routeTriggerInteract(ctx, target)
    if not valid(ctx.playerCharacter) then return false, "no player character" end
    if not hasFunction(target.actor, "OnTriggerInteract") then
        return false, "no OnTriggerInteract"
    end

    -- The handler bails out early when the point is not accepting requests.
    writeField(target.actor, "EnableRequestUnlock", true)

    local ok, err = pcall(function()
        target.actor:OnTriggerInteract(ctx.playerCharacter, INDICATOR_UNLOCK_FAST_TRAVEL)
    end)
    if not ok then return false, tostring(err) end
    return true
end

-- Route 2: the 1.0.4 server request for level-object interaction.
local function routeInteractRPC(ctx, target)
    if not valid(ctx.playerNetwork) then return false, "no network component" end
    if not hasFunction(ctx.playerNetwork, "RequestInteractLevelObject_ToServer") then
        return false, "no RequestInteractLevelObject_ToServer"
    end

    local ok, err = pcall(function()
        ctx.playerNetwork:RequestInteractLevelObject_ToServer(target.actor)
    end)
    if not ok then return false, tostring(err) end
    return true
end

-- There is deliberately no third route that writes FastTravelPointUnlockFlag
-- itself: SetRecordData_Bool_ForServer takes the record as a NON-CONST struct
-- reference, and UE4SS can only feed such a parameter from a Lua table, i.e.
-- from a copy - the player record would never be touched. The companion mod
-- FastTravelDiag (!ftprobe) still tries it once per probe, so the log shows
-- the exact refusal if a future UE4SS build ever changes that.
local ROUTES = {
    { name = "OnTriggerInteract",   run = routeTriggerInteract },
    { name = "InteractRPC",         run = routeInteractRPC     },
}

--- Purely cosmetic. Makes the icon appear when every real route failed.
--- Reported separately, never counted as unlocked.
local function forceLocalFlags(ctx, target)
    writeField(target.actor, "EnableRequestUnlock", true)
    writeField(target.actor, "bUnlocked", true)
    if valid(target.loc) then
        writeField(target.loc, "ShouldUnlockFlag", true)
    end
    if hasFunction(target.actor, "OnUpdateFlagMapRecord") then
        pcall(function() target.actor:OnUpdateFlagMapRecord(target.idName, true) end)
    end
    if valid(ctx.playerState) and hasFunction(target.actor, "OnCompleteSyncPlayer") then
        pcall(function() target.actor:OnCompleteSyncPlayer(ctx.playerState) end)
    end
end

----------------------------------------------------------------------
-- Sky island cloud, same as v1
----------------------------------------------------------------------
local function triggerCloudRemoval()
    local triggerClass = StaticFindObject("/Script/Pal.PalUnlockFastTravelTriggerEvent_RemoveSkyIslandCloud")
    local outer = getOptionSubsystem()
    if not valid(triggerClass) or not valid(outer) then return end

    local ok, triggerObj = pcall(function() return StaticConstructObject(triggerClass, outer) end)
    if ok and valid(triggerObj) and hasFunction(triggerObj, "TriggerEvent") then
        pcall(function() triggerObj:TriggerEvent() end)
    end
end

----------------------------------------------------------------------
-- The job runner
--
-- One job at a time, batched over frames. 174 interacts in a single
-- frame stalls the game and the server quietly drops the tail of them.
----------------------------------------------------------------------
local job = nil

local function buildContext()
    local pc = getPlayerController()
    if not valid(pc) then return nil, "local player controller not found" end

    local ctx = {
        controller      = pc,
        playerCharacter = getPlayerCharacter(pc),
        playerState     = getPlayerState(pc),
        playerNetwork   = getPlayerNetwork(pc),
        worldContext    = pc,
    }
    ctx.recordData    = getRecordData(ctx.playerState)
    ctx.recordUtility = getRecordUtility()

    if not valid(ctx.playerCharacter) then
        return nil, "player character not found (are you in a loaded world?)"
    end
    return ctx
end

local function finishJob()
    local j = job
    if j == nil then return end

    local ctx = j.ctx
    refreshUnlocked(ctx)

    local unlocked, stillLocked, forced, actorOnly = 0, {}, 0, 0

    for _, target in ipairs(j.targets) do
        if isUnlocked(ctx, target) then
            unlocked = unlocked + 1
        else
            stillLocked[#stillLocked + 1] = target
            -- Statue claims unlocked, save does not: either a leftover from a
            -- previous cosmetic fallback, or replication has not landed yet.
            if ctx.unlockedSet ~= nil and isUnlockedFast(ctx, target) then
                actorOnly = actorOnly + 1
            end
        end
    end

    if #stillLocked > 0 and CONFIG.LocalFallback then
        for _, target in ipairs(stillLocked) do
            forceLocalFlags(ctx, target)
            forced = forced + 1
        end
    end

    if j.mode == "all" or j.mode == "statues" then
        triggerCloudRemoval()
    end

    local hits = {}
    for _, route in ipairs(ROUTES) do
        hits[#hits + 1] = string.format("%s=%d", route.name, j.stats[route.name] or 0)
    end

    log("================ RESULT ================")
    log(string.format("mode: %s   points: %d   unlocked before: %d",
        j.mode, #j.targets, j.alreadyUnlocked))
    log(string.format("unlocked now: %d   newly unlocked: %d   still locked: %d",
        unlocked, unlocked - j.alreadyUnlocked, #stillLocked))
    log("source of truth: " ..
        (ctx.unlockedSet ~= nil and "player record" or "statue:IsUnlocked() (record unreadable)"))
    log("route that worked: " .. table.concat(hits, "  "))
    if actorOnly > 0 then
        log(string.format("%d statue(s) look unlocked in the world but are NOT in the save -", actorOnly))
        log("that is a client-side-only unlock (yours or the previous version's).")
    end
    if forced > 0 then
        log(string.format("%d point(s) only got client-side flags - the icon shows up but the", forced))
        log("unlock may not survive a reload. Run !eaglediag and check the log.")
    end
    if #j.errors > 0 then
        log("first errors:")
        for i = 1, math.min(5, #j.errors) do log("   " .. j.errors[i]) end
    end
    log("========================================")

    local onDone = j.onDone
    job = nil
    if onDone then pcall(onDone) end
end

local function verifyPass()
    local j = job
    if j == nil then return end

    refreshUnlocked(j.ctx)

    local leftovers = {}
    for _, target in ipairs(j.targets) do
        if not isUnlocked(j.ctx, target) then
            leftovers[#leftovers + 1] = target
        end
    end

    if #leftovers == 0 or j.pass >= CONFIG.RetryPasses then
        finishJob()
        return
    end

    j.pass  = j.pass + 1
    j.queue = leftovers
    j.index = 1
    log(string.format("pass %d: retrying %d point(s) that did not stick", j.pass, #leftovers))
    j.step()
end

local function processTarget(ctx, target, stats, errors)
    if isUnlocked(ctx, target) then return true end

    for _, route in ipairs(ROUTES) do
        local ok, err = route.run(ctx, target)
        if ok then
            -- Actor level on purpose: the record only catches up a frame or
            -- two later, the verify pass re-reads it authoritatively.
            if isUnlockedFast(ctx, target) then
                stats[route.name] = (stats[route.name] or 0) + 1
                return true
            end
        elseif err and #errors < 20 then
            errors[#errors + 1] = string.format("%s [%s]: %s", target.id, route.name, err)
        end
    end

    -- Not unlocked yet is not the same as failed - the request may still be
    -- travelling. The verify pass decides.
    return false
end

local function stepJob()
    local j = job
    if j == nil then return end

    ExecuteInGameThread(function()
        if job ~= j then return end

        local processed = 0
        while j.index <= #j.queue and processed < CONFIG.BatchSize do
            local target = j.queue[j.index]
            j.index = j.index + 1
            processed = processed + 1
            if valid(target.actor) then
                pcall(function() processTarget(j.ctx, target, j.stats, j.errors) end)
            end
        end

        if j.index > #j.queue then
            ExecuteWithDelay(CONFIG.VerifyDelayMs, function()
                ExecuteInGameThread(function()
                    if job == j then verifyPass() end
                end)
            end)
        else
            ExecuteWithDelay(CONFIG.BatchDelayMs, function()
                if job == j then j.step() end
            end)
        end
    end)
end

local function collectEagles(filterMode, onDone)
    filterMode = filterMode or "all"

    if job ~= nil then
        log("a run is already in progress, wait for the result line")
        return
    end

    local ctx, err = buildContext()
    if ctx == nil then
        log("error: " .. tostring(err))
        if onDone then pcall(onDone) end
        return
    end

    local locById, locCount = collectLocationPoints()
    local targets = collectStatues(locById, filterMode)

    if #targets == 0 then
        log(string.format("no fast travel actors found (location points seen: %d)", locCount))
        log("run !eaglediag and send the log - the actor class names may have changed again")
        if onDone then pcall(onDone) end
        return
    end

    local recordCount = refreshUnlocked(ctx)

    local already = 0
    for _, t in ipairs(targets) do
        if isUnlocked(ctx, t) then already = already + 1 end
    end

    log(string.format("mode [%s]: %d point(s) found (%d location points, %d already unlocked)",
        filterMode, #targets, locCount, already))
    log(string.format("player record: %s | network component: %s",
        recordCount and ("readable, " .. recordCount .. " flag(s) set")
                     or "NOT readable - falling back to statue:IsUnlocked()",
        valid(ctx.playerNetwork) and "yes" or "NO"))

    job = {
        ctx             = ctx,
        mode            = filterMode,
        targets         = targets,
        queue           = targets,
        index           = 1,
        pass            = 1,
        stats           = {},
        errors          = {},
        alreadyUnlocked = already,
        onDone          = onDone,
        step            = stepJob,
    }

    stepJob()
end

local function collectEaglesNoExp(filterMode)
    local originalRate = getExpRate()
    if originalRate == nil or not setExpRate(0.0) then
        log("warning: could not zero the EXP rate, collecting normally")
        collectEagles(filterMode)
        return
    end

    pendingRestoreRate = originalRate
    log(string.format("EXP rate set to 0.0 (was %.2f)", originalRate))

    -- Restore only once the run is actually over, not on a fixed timer -
    -- batching makes a run take seconds, v1 restored while it was still going.
    collectEagles(filterMode, function()
        ExecuteWithDelay(CONFIG.ExpRestoreDelayMs, function()
            ExecuteInGameThread(function()
                if pendingRestoreRate ~= nil then
                    setExpRate(pendingRestoreRate)
                    log(string.format("EXP rate restored to %.2f", pendingRestoreRate))
                    pendingRestoreRate = nil
                end
            end)
        end)
    end)
end

----------------------------------------------------------------------
-- Map fog eraser - unchanged from v1, it never used the dead RPC
----------------------------------------------------------------------
local mapClearState = { active = false, originalPaintSize = nil }

local function getMapUIData()
    return firstValidOf("BP_PalWorldMapUIData_C")
end

local function removeMaskAtPlayerPosition()
    local mapUIData = getMapUIData()
    local player = getPlayerCharacter(getPlayerController())
    if not valid(mapUIData) or not valid(player) then return false end
    if not hasFunction(mapUIData, "RemoveMaskByLocation") then return false end

    local okLoc, location = pcall(function() return player:K2_GetActorLocation() end)
    if not okLoc or not location then return false end

    return pcall(function() mapUIData:RemoveMaskByLocation(player, location) end)
end

local function restoreMapPaintSize()
    if not mapClearState.active and mapClearState.originalPaintSize == nil then return end

    local original = mapClearState.originalPaintSize
    mapClearState.active = false
    mapClearState.originalPaintSize = nil

    ExecuteInGameThread(function()
        local mapUIData = getMapUIData()
        if valid(mapUIData) then
            pcall(function() mapUIData.MapMaskPaintSize = original end)
            log(string.format("[MAP] restored paint size to %.2f", original or 0))
        end
    end)
end

local function runMapClearPulse(endTime)
    if not mapClearState.active then return end

    if os.clock() >= endTime then
        restoreMapPaintSize()
        return
    end

    ExecuteInGameThread(function()
        if mapClearState.active then removeMaskAtPlayerPosition() end
    end)

    ExecuteWithDelay(CONFIG.MapClearIntervalMs, function() runMapClearPulse(endTime) end)
end

local function collectEaglesMapClear()
    if mapClearState.active then
        log("[MAP] map clear is already active")
        return
    end

    mapClearState.active = true

    ExecuteInGameThread(function()
        local mapUIData = getMapUIData()
        if not valid(mapUIData) then
            mapClearState.active = false
            log("[MAP] error: BP_PalWorldMapUIData_C not found")
            return
        end

        local okRead, oldVal = pcall(function() return mapUIData.MapMaskPaintSize end)
        if not okRead then
            mapClearState.active = false
            log("[MAP] error: unable to read MapMaskPaintSize")
            return
        end
        mapClearState.originalPaintSize = tonumber(oldVal)

        if not pcall(function() mapUIData.MapMaskPaintSize = CONFIG.MapClearPaintSize end) then
            mapClearState.active = false
            log("[MAP] error: failed to set MapMaskPaintSize")
            return
        end

        removeMaskAtPlayerPosition()
        log(string.format("[MAP] eraser active for %d ms", CONFIG.MapClearDurationMs))

        local endTime = os.clock() + (CONFIG.MapClearDurationMs / 1000.0)
        ExecuteWithDelay(CONFIG.MapClearIntervalMs, function() runMapClearPulse(endTime) end)
    end)
end

----------------------------------------------------------------------
-- Diagnostics: read-only, changes nothing, prints what a patch would break
----------------------------------------------------------------------
local function dumpClassTree(obj, label, maxLevels)
    log("---- " .. label .. " ----")
    if not valid(obj) then log("   <not available>") return end
    log("   object: " .. nameOf(obj))

    local cls = callOnRaw(obj, "GetClass")
    local level = 0
    while valid(cls) and level < (maxLevels or 4) do
        local fns = {}
        pcall(function()
            cls:ForEachFunction(function(fn)
                fns[#fns + 1] = fnameToString(callOnRaw(fn, "GetFName")) or "?"
            end)
        end)
        table.sort(fns)
        log("   [" .. level .. "] " .. (fnameToString(callOnRaw(cls, "GetFName")) or "?"))
        log("       " .. (#fns > 0 and table.concat(fns, ", ") or "<none>"))

        local nextCls = callOnRaw(cls, "GetSuperStruct") or callOnRaw(cls, "GetSuper")
        if not valid(nextCls) then break end
        cls = nextCls
        level = level + 1
    end
end

local function dumpMatchingFunctions(obj, label, keywords)
    log("---- " .. label .. " ----")
    if not valid(obj) then log("   <not available>") return end
    log("   object: " .. nameOf(obj))

    local cls = callOnRaw(obj, "GetClass")
    local set = classFunctionSet(cls)
    local hitList = {}
    for name in pairs(set) do
        local lower = string.lower(name)
        for _, kw in ipairs(keywords) do
            if string.find(lower, kw, 1, true) then
                hitList[#hitList + 1] = name
                break
            end
        end
    end
    table.sort(hitList)
    log("   matching: " .. (#hitList > 0 and table.concat(hitList, ", ") or "<none>"))
end

local function diagnostic()
    log("")
    log("============ DIAGNOSTIC v" .. VERSION .. " ============")

    for _, className in ipairs(STATUE_CLASSES) do
        local list = FindAllOf(className)
        log(string.format("FindAllOf(%s) = %d", className, list and #list or 0))
    end
    local locs = FindAllOf("PalLocationPointFastTravel")
    log(string.format("FindAllOf(PalLocationPointFastTravel) = %d", locs and #locs or 0))

    local ctx, err = buildContext()
    if ctx == nil then
        log("context error: " .. tostring(err))
        log("======== END ========")
        return
    end

    log("controller:       " .. nameOf(ctx.controller))
    log("player character: " .. nameOf(ctx.playerCharacter))
    log("player state:     " .. nameOf(ctx.playerState))
    log("network comp:     " .. nameOf(ctx.playerNetwork))
    log("record data:      " .. nameOf(ctx.recordData))
    log("record utility:   " .. nameOf(ctx.recordUtility))

    dumpMatchingFunctions(ctx.playerNetwork, "PalNetworkPlayerComponent",
        { "fasttravel", "unlock", "interact", "levelobject" })
    dumpMatchingFunctions(ctx.recordUtility, "PalPlayerRecordDataUtility", { "record" })

    local recordCount = refreshUnlocked(ctx)
    log("record flags currently set: " .. tostring(recordCount))

    local locById, locCount = collectLocationPoints()
    local targets = collectStatues(locById, "all")
    log(string.format("joined targets: %d (location points: %d)", #targets, locCount))

    local statues, pillars, unlockedNow = 0, 0, 0
    for _, t in ipairs(targets) do
        if t.isPillar then pillars = pillars + 1 else statues = statues + 1 end
        if isUnlocked(ctx, t) then unlockedNow = unlockedNow + 1 end
    end
    log(string.format("statues: %d   pillars: %d   currently unlocked: %d", statues, pillars, unlockedNow))
    log("player record readable: " .. tostring(ctx.unlockedSet ~= nil))

    local sample = targets[1]
    if sample then
        log("---- sample target ----")
        log("   id:      " .. tostring(sample.id))
        log("   actor:   " .. nameOf(sample.actor))
        log("   class:   " .. classNameOf(sample.actor))
        log("   pillar:  " .. tostring(sample.isPillar))
        log("   bUnlocked:           " .. tostring(readField(sample.actor, "bUnlocked")))
        log("   EnableRequestUnlock: " .. tostring(readField(sample.actor, "EnableRequestUnlock")))
        log("   IsUnlocked():        " .. tostring(select(2, tryCall(sample.actor, "IsUnlocked"))))
        log("   record flag:         " ..
            tostring(ctx.unlockedSet and ctx.unlockedSet[sample.id] or "<record unreadable>"))
        log("   loc point:           " .. nameOf(sample.loc))
        if valid(sample.loc) then
            log("   ShouldUnlockFlag:    " .. tostring(readField(sample.loc, "ShouldUnlockFlag")))
        end
        dumpClassTree(sample.actor, "statue class tree", 3)
    end

    log("route availability on this build:")
    log("   OnTriggerInteract:                  " ..
        tostring(sample ~= nil and hasFunction(sample.actor, "OnTriggerInteract")))
    log("   RequestInteractLevelObject_ToServer: " ..
        tostring(hasFunction(ctx.playerNetwork, "RequestInteractLevelObject_ToServer")))
    log("   SetRecordData_Bool_ForServer:        " ..
        tostring(hasFunction(ctx.recordUtility, "SetRecordData_Bool_ForServer")))
    log("   RequestUnlockFastTravelPoint_ToServer (v1, expected false): " ..
        tostring(hasFunction(ctx.playerNetwork, "RequestUnlockFastTravelPoint_ToServer")))
    log("======== END ========")
end

----------------------------------------------------------------------
-- Chat commands
----------------------------------------------------------------------
local COMMANDS = {}

local function registerCommands()
    COMMANDS[CONFIG.ChatCommand]        = function() collectEagles("all") end
    COMMANDS["!eagle all"]              = function() collectEagles("all") end
    COMMANDS[CONFIG.ChatCommandStatues] = function() collectEagles("statues") end
    COMMANDS[CONFIG.ChatCommandPillars] = function() collectEagles("pillars") end
    COMMANDS[CONFIG.ChatCommandNoExp]   = function() collectEaglesNoExp("all") end
    COMMANDS["!eagle all noexp"]        = function() collectEaglesNoExp("all") end
    COMMANDS["!eagle statues noexp"]    = function() collectEaglesNoExp("statues") end
    COMMANDS["!eagle pillars noexp"]    = function() collectEaglesNoExp("pillars") end
    COMMANDS[CONFIG.ChatCommandMap]     = collectEaglesMapClear
    COMMANDS[CONFIG.ChatCommandDiag]    = diagnostic
    COMMANDS["!eagle diag"]             = diagnostic
    COMMANDS[CONFIG.ChatCommandRestore] = function()
        local rateToRestore = pendingRestoreRate or 1.0
        if setExpRate(rateToRestore) then
            log(string.format("EXP rate manually restored to %.2f", rateToRestore))
        end
        pendingRestoreRate = nil
    end
end

local function registerChatHook()
    registerCommands()

    local success, err = pcall(function()
        RegisterHook("/Script/Pal.PalUIChat:OnReceivedChat", function(context, message)
            local received = message:get()
            if not received or not received.Message then return end

            local text = received.Message:ToString()
            if not text then return end

            local handler = COMMANDS[string.lower(text)]
            if handler then pcall(handler) end
        end)
    end)

    if success then
        log(string.format("v%s ready. Commands: %s | %s | %s | %s | %s | %s",
            VERSION, CONFIG.ChatCommand, CONFIG.ChatCommandStatues, CONFIG.ChatCommandPillars,
            CONFIG.ChatCommandNoExp, CONFIG.ChatCommandMap, CONFIG.ChatCommandDiag))
    else
        log("failed to register chat hook: " .. tostring(err))
    end
end

registerChatHook()
