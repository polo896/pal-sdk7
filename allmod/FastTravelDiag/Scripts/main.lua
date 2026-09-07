--[[
    FAST TRAVEL DIAG  v1.0      By Wol4ara896
    ==================================================================
    Read-only probe for the fast travel unlock path. It changes nothing
    on its own except the single point you ask it to test.

    Use it when FastTravelUnlocker reports "still locked" after a patch:
    it prints what the game exposes now and which unlock route actually
    flips the flag, so the mod can be pointed at the right one.

        !ftdiag     dump everything: class names, counts, functions,
                    flags of one sample point. Changes nothing.

        !ftprobe    take ONE still-locked point and try the routes one
                    at a time, 1.5 s apart, re-reading the unlock flag
                    after each. Prints which route worked. This unlocks
                    at most one point.

        !ftfind <text>
                    list every UFunction on the player controller, the
                    network component, the player state, the record data
                    and the statue whose name contains <text>.
                    Example:  !ftfind fasttravel

    Everything lands in UE4SS.log with the [FTDiag] tag.

    Why the routes are what they are - checked against the 1.0.4 dump:
      * Pal.PalNetworkPlayerComponent lost RequestUnlockFastTravelPoint_ToServer
      * unlock state now lives in
        UPalPlayerRecordData.FastTravelPointUnlockFlag (keyed by FName)
      * the interact path is
        Pal.PalNetworkPlayerComponent.RequestInteractLevelObject_ToServer
      * the statue still has OnTriggerInteract / OnUpdateFlagMapRecord /
        OnCompleteSyncPlayer / IsUnlocked

    SAFETY: a UFunction call on a class that does not have that function
    is a LowLevelFatalError that pcall cannot catch. Every call here is
    checked against the class first.
--]]

local MOD     = "[FTDiag]"
local VERSION = "1.0"

local INDICATOR_UNLOCK_FAST_TRAVEL = 26 -- EPalInteractiveObjectIndicatorType::UnlockFastTravel

local STATUE_CLASSES = {
    "BP_LevelObject_TowerFastTravelPoint_C",
    "BP_LevelObject_UnlockMapPoint_C",
    "PalLevelObjectUnlockableFastTravelPoint",
}

local PROBE_STEP_MS = 1500

----------------------------------------------------------------------
-- Helpers (same safety rules as the main mod)
----------------------------------------------------------------------
local function log(msg) print(string.format("%s %s\n", MOD, tostring(msg))) end

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

local function addressOf(object)
    if not valid(object) then return nil end
    local ok, addr = pcall(function() return object:GetAddress() end)
    return (ok and addr) or nil
end

local function classNameOf(object)
    if not valid(object) then return "<invalid>" end
    return fnameToString(callOnRaw(callOnRaw(object, "GetClass"), "GetFName")) or "<unknown>"
end

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
    return classFunctionSet(callOnRaw(object, "GetClass"))[methodName] == true
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

local function firstValidOf(className)
    local list = FindAllOf(className)
    if not list then return nil end
    for _, o in ipairs(list) do
        if valid(o) then return o end
    end
    return nil
end

----------------------------------------------------------------------
-- World handles
----------------------------------------------------------------------
local function buildContext()
    local pc
    local controllers = FindAllOf("BP_PalPlayerController_C") or FindAllOf("PalPlayerController")
    if controllers then
        for _, c in ipairs(controllers) do
            if valid(c) and hasFunction(c, "IsLocalPlayerController") then
                local ok, isLocal = pcall(function() return c:IsLocalPlayerController() end)
                if ok and isLocal == true then pc = c break end
            end
        end
        if pc == nil then
            for _, c in ipairs(controllers) do
                if valid(c) then pc = c break end
            end
        end
    end
    if not valid(pc) then return nil, "no player controller" end

    local ctx = { controller = pc, worldContext = pc }

    ctx.playerCharacter = readField(pc, "Pawn")
    if not valid(ctx.playerCharacter) then ctx.playerCharacter = readField(pc, "Character") end
    if not valid(ctx.playerCharacter) then
        ctx.playerCharacter = firstValidOf("BP_PalPlayerCharacter_C") or firstValidOf("PalPlayerCharacter")
    end

    ctx.playerState = readField(pc, "PlayerState")
    if not valid(ctx.playerState) then
        ctx.playerState = firstValidOf("BP_PalPlayerState_C") or firstValidOf("PalPlayerState")
    end

    local transmitter = readField(pc, "Transmitter")
    ctx.transmitter   = transmitter
    ctx.playerNetwork = valid(transmitter) and readField(transmitter, "Player") or nil

    if valid(ctx.playerState) and hasFunction(ctx.playerState, "GetRecordData") then
        local ok, rd = pcall(function() return ctx.playerState:GetRecordData() end)
        if ok and valid(rd) then ctx.recordData = rd end
    end

    ctx.recordUtility = StaticFindObject("/Script/Pal.Default__PalPlayerRecordDataUtility")
    return ctx
end

----------------------------------------------------------------------
-- Targets
----------------------------------------------------------------------
local function collectLocationPoints()
    local byId, n = {}, 0
    local points = FindAllOf("PalLocationPointFastTravel")
    if not points then return byId, 0 end
    for _, loc in ipairs(points) do
        if valid(loc) then
            local id = fnameToString(readField(loc, "FastTravelPointID"))
            if id and id ~= "" and id ~= "None" then
                local isPillar = readField(loc, "bUnlockMapPoint") == true
                byId[id] = { loc = loc, isPillar = isPillar }
                n = n + 1
            end
        end
    end
    return byId, n
end

local function collectTargets()
    local locById, locCount = collectLocationPoints()
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
                        out[#out + 1] = {
                            actor    = actor,
                            id       = id,
                            idName   = readField(actor, "FastTravelPointID"),
                            loc      = info and info.loc or nil,
                            isPillar = info and info.isPillar
                                       or (string.find(classNameOf(actor), "UnlockMapPoint") ~= nil),
                        }
                    end
                end
            end
        end
    end
    return out, locCount
end

local recordReadBroken = false

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

local function iterateArray(arr, callback)
    if arr == nil then return false end

    local touched = false
    pcall(function()
        arr:ForEach(function(_, element)
            touched = true
            callback(element)
        end)
    end)
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

--- Walk UPalPlayerRecordData.FastTravelPointUnlockFlag.Items once and build
--- the set of IDs the SAVE says are unlocked. One pass, no struct copies -
--- unlike GetRecordData_Bool, which deep-copies the whole record per call.
local function refreshUnlocked(ctx)
    if not valid(ctx.recordData) then
        ctx.unlockedSet = nil
        return nil
    end

    local set, count, seen = {}, 0, 0
    local ok, err = pcall(function()
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
        log("record Items not walkable: " .. tostring(err))
        ctx.unlockedSet = nil
        return nil
    end

    if seen == 0 then
        ctx.unlockedSet = nil
        return nil
    end

    ctx.unlockedSet = set
    return count
end

--- Single point read through the reflected getter. Kept because it is the
--- BP-facing API: if this ever stops matching the Items walk, say so.
local function readRecordFlag(ctx, target)
    if recordReadBroken then return nil end
    if not valid(ctx.recordUtility) or not valid(ctx.recordData) then return nil end
    if not hasFunction(ctx.recordUtility, "GetRecordData_Bool") then
        recordReadBroken = true
        return nil
    end
    local ok, res = pcall(function()
        return ctx.recordUtility:GetRecordData_Bool(ctx.recordData.FastTravelPointUnlockFlag, target.idName)
    end)
    if not ok then
        recordReadBroken = true
        log("GetRecordData_Bool NOT callable from Lua: " .. tostring(res))
        return nil
    end
    return res == true
end

local function unlockState(ctx, target)
    local rec = nil
    if ctx.unlockedSet ~= nil then
        rec = ctx.unlockedSet[target.id] == true
    else
        rec = readRecordFlag(ctx, target)
    end

    local actorSays = nil
    if hasFunction(target.actor, "IsUnlocked") then
        local ok, res = pcall(function() return target.actor:IsUnlocked() end)
        if ok then actorSays = (res == true) end
    end
    local flag = readField(target.actor, "bUnlocked")
    return rec, actorSays, flag
end

local function isUnlocked(ctx, target)
    local rec, actorSays, flag = unlockState(ctx, target)
    if rec ~= nil then return rec end
    if actorSays ~= nil then return actorSays end
    return flag == true
end

----------------------------------------------------------------------
-- !ftdiag
----------------------------------------------------------------------
local function dumpFunctions(obj, label, filterText)
    log("---- " .. label .. " ----")
    if not valid(obj) then log("   <not available>") return end
    log("   object: " .. nameOf(obj))
    log("   class:  " .. classNameOf(obj))

    local names = {}
    for name in pairs(classFunctionSet(callOnRaw(obj, "GetClass"))) do
        if filterText == nil or string.find(string.lower(name), filterText, 1, true) then
            names[#names + 1] = name
        end
    end
    table.sort(names)
    if #names == 0 then
        log("   <no matching functions>")
    else
        -- chunked so a 400 function class does not produce one unreadable line
        local line = {}
        for _, n in ipairs(names) do
            line[#line + 1] = n
            if #line == 8 then
                log("   " .. table.concat(line, ", "))
                line = {}
            end
        end
        if #line > 0 then log("   " .. table.concat(line, ", ")) end
    end
end

local function diagnose()
    log("")
    log("=========== FT DIAG v" .. VERSION .. " ===========")

    for _, className in ipairs(STATUE_CLASSES) do
        local list = FindAllOf(className)
        log(string.format("FindAllOf(%-40s) = %d", className, list and #list or 0))
    end
    local locs = FindAllOf("PalLocationPointFastTravel")
    log(string.format("FindAllOf(%-40s) = %d", "PalLocationPointFastTravel", locs and #locs or 0))

    local ctx, err = buildContext()
    if ctx == nil then
        log("context error: " .. tostring(err))
        log("=========== END ===========")
        return
    end

    log("controller:       " .. nameOf(ctx.controller))
    log("player character: " .. nameOf(ctx.playerCharacter))
    log("player state:     " .. nameOf(ctx.playerState))
    log("transmitter:      " .. nameOf(ctx.transmitter))
    log("network comp:     " .. nameOf(ctx.playerNetwork))
    log("record data:      " .. nameOf(ctx.recordData))
    log("record utility:   " .. nameOf(ctx.recordUtility))

    local recordCount = refreshUnlocked(ctx)
    log("record flags set (Items walk): " .. tostring(recordCount))

    local targets, locCount = collectTargets()
    local unlocked, statues, pillars = 0, 0, 0
    for _, t in ipairs(targets) do
        if isUnlocked(ctx, t) then unlocked = unlocked + 1 end
        if t.isPillar then pillars = pillars + 1 else statues = statues + 1 end
    end
    log(string.format("targets: %d (statues %d, pillars %d), location points: %d, unlocked: %d",
        #targets, statues, pillars, locCount, unlocked))

    local sample
    for _, t in ipairs(targets) do
        if not isUnlocked(ctx, t) then sample = t break end
    end
    sample = sample or targets[1]

    if sample then
        local rec, actorSays, flag = unlockState(ctx, sample)
        log("---- sample point ----")
        log("   id:                  " .. tostring(sample.id))
        log("   class:               " .. classNameOf(sample.actor))
        log("   actor:               " .. nameOf(sample.actor))
        log("   pillar:              " .. tostring(sample.isPillar))
        log("   record flag:         " .. tostring(rec))
        log("   GetRecordData_Bool:  " .. tostring(readRecordFlag(ctx, sample)))
        log("   IsUnlocked():        " .. tostring(actorSays))
        log("   bUnlocked:           " .. tostring(flag))
        log("   EnableRequestUnlock: " .. tostring(readField(sample.actor, "EnableRequestUnlock")))
        log("   loc point:           " .. nameOf(sample.loc))
        log("   ShouldUnlockFlag:    " .. tostring(readField(sample.loc, "ShouldUnlockFlag")))
        dumpFunctions(sample.actor, "statue functions", nil)
    end

    dumpFunctions(ctx.playerNetwork, "network comp: *fasttravel*", "fasttravel")
    dumpFunctions(ctx.playerNetwork, "network comp: *unlock*", "unlock")
    dumpFunctions(ctx.playerNetwork, "network comp: *interact*", "interact")
    dumpFunctions(ctx.playerNetwork, "network comp: *levelobject*", "levelobject")
    dumpFunctions(ctx.recordUtility, "record utility", "record")
    dumpFunctions(ctx.recordData,    "record data: *fasttravel*", "fasttravel")
    dumpFunctions(ctx.controller,    "controller: *fasttravel*", "fasttravel")
    dumpFunctions(ctx.playerState,   "player state: *record*", "record")

    log("---- route availability ----")
    log("   statue:OnTriggerInteract               " ..
        tostring(sample ~= nil and hasFunction(sample.actor, "OnTriggerInteract")))
    log("   statue:OnCompleteSyncPlayer            " ..
        tostring(sample ~= nil and hasFunction(sample.actor, "OnCompleteSyncPlayer")))
    log("   statue:OnUpdateFlagMapRecord           " ..
        tostring(sample ~= nil and hasFunction(sample.actor, "OnUpdateFlagMapRecord")))
    log("   net:RequestInteractLevelObject_ToServer " ..
        tostring(hasFunction(ctx.playerNetwork, "RequestInteractLevelObject_ToServer")))
    log("   net:RequestUnlockFastTravelPoint_ToServer (pre-1.0.4) " ..
        tostring(hasFunction(ctx.playerNetwork, "RequestUnlockFastTravelPoint_ToServer")))
    log("   util:SetRecordData_Bool_ForServer      " ..
        tostring(hasFunction(ctx.recordUtility, "SetRecordData_Bool_ForServer")))
    log("   util:GetRecordData_Bool                " ..
        tostring(hasFunction(ctx.recordUtility, "GetRecordData_Bool")))
    log("   record flag readable from Lua:         " .. tostring(not recordReadBroken))
    log("=========== END ===========")
end

----------------------------------------------------------------------
-- !ftprobe - one point, one route at a time, with verification
----------------------------------------------------------------------
local probeRoutes = {
    {
        name = "1. statue:OnTriggerInteract(player, 26)",
        run = function(ctx, t)
            if not valid(ctx.playerCharacter) then return false, "no player character" end
            if not hasFunction(t.actor, "OnTriggerInteract") then return false, "function missing" end
            writeField(t.actor, "EnableRequestUnlock", true)
            local ok, err = pcall(function()
                t.actor:OnTriggerInteract(ctx.playerCharacter, INDICATOR_UNLOCK_FAST_TRAVEL)
            end)
            return ok, ok and "called" or tostring(err)
        end,
    },
    {
        name = "2. net:RequestInteractLevelObject_ToServer(statue)",
        run = function(ctx, t)
            if not hasFunction(ctx.playerNetwork, "RequestInteractLevelObject_ToServer") then
                return false, "function missing"
            end
            local ok, err = pcall(function()
                ctx.playerNetwork:RequestInteractLevelObject_ToServer(t.actor)
            end)
            return ok, ok and "called" or tostring(err)
        end,
    },
    {
        name = "3. util:SetRecordData_Bool_ForServer (expected to be refused: UE4SS cannot pass a live struct to a non-const out param)",
        run = function(ctx, t)
            if not hasFunction(ctx.recordUtility, "SetRecordData_Bool_ForServer") then
                return false, "function missing"
            end
            if not valid(ctx.recordData) then return false, "no record data" end
            local ok, err = pcall(function()
                ctx.recordUtility:SetRecordData_Bool_ForServer(
                    ctx.worldContext, ctx.recordData.FastTravelPointUnlockFlag, t.idName, true)
            end)
            return ok, ok and "called" or tostring(err)
        end,
    },
    {
        name = "4. statue:OnUpdateFlagMapRecord(id, true) + OnCompleteSyncPlayer (client side only)",
        run = function(ctx, t)
            local called = false
            if hasFunction(t.actor, "OnUpdateFlagMapRecord") then
                pcall(function() t.actor:OnUpdateFlagMapRecord(t.idName, true) end)
                called = true
            end
            if valid(ctx.playerState) and hasFunction(t.actor, "OnCompleteSyncPlayer") then
                pcall(function() t.actor:OnCompleteSyncPlayer(ctx.playerState) end)
                called = true
            end
            return called, called and "called" or "functions missing"
        end,
    },
}

local probeRunning = false

local function probeStep(ctx, target, index)
    if index > #probeRoutes then
        log("PROBE: no route unlocked this point. Send this whole log.")
        probeRunning = false
        return
    end

    local route = probeRoutes[index]
    log(string.format("PROBE route %d: %s", index, route.name))

    local ok, info = route.run(ctx, target)
    log(string.format("   call: %s (%s)", tostring(ok), tostring(info)))

    ExecuteWithDelay(PROBE_STEP_MS, function()
        ExecuteInGameThread(function()
            refreshUnlocked(ctx)
            local rec, actorSays, flag = unlockState(ctx, target)
            log(string.format("   after %d ms -> record=%s IsUnlocked=%s bUnlocked=%s",
                PROBE_STEP_MS, tostring(rec), tostring(actorSays), tostring(flag)))

            if isUnlocked(ctx, target) then
                log("PROBE RESULT: route " .. index .. " WORKS -> " .. route.name)
                probeRunning = false
            else
                probeStep(ctx, target, index + 1)
            end
        end)
    end)
end

local function probe()
    if probeRunning then
        log("probe already running")
        return
    end

    local ctx, err = buildContext()
    if ctx == nil then
        log("context error: " .. tostring(err))
        return
    end

    refreshUnlocked(ctx)

    local targets = collectTargets()
    local target
    for _, t in ipairs(targets) do
        if not isUnlocked(ctx, t) then target = t break end
    end

    if target == nil then
        log("every point already reads as unlocked, nothing to probe")
        return
    end

    probeRunning = true
    log("")
    log("=========== FT PROBE ===========")
    log("point: " .. tostring(target.id) .. "  (" .. classNameOf(target.actor) .. ")")
    local rec, actorSays, flag = unlockState(ctx, target)
    log(string.format("before -> record=%s IsUnlocked=%s bUnlocked=%s",
        tostring(rec), tostring(actorSays), tostring(flag)))
    probeStep(ctx, target, 1)
end

----------------------------------------------------------------------
-- !ftfind <text>
----------------------------------------------------------------------
local function find(text)
    local needle = string.lower(text or "")
    if needle == "" then
        log("usage: !ftfind fasttravel")
        return
    end

    local ctx, err = buildContext()
    if ctx == nil then
        log("context error: " .. tostring(err))
        return
    end

    log("")
    log("=========== FT FIND '" .. needle .. "' ===========")
    dumpFunctions(ctx.controller,    "player controller", needle)
    dumpFunctions(ctx.playerNetwork, "network component", needle)
    dumpFunctions(ctx.transmitter,   "transmitter",       needle)
    dumpFunctions(ctx.playerState,   "player state",      needle)
    dumpFunctions(ctx.recordData,    "record data",       needle)
    dumpFunctions(ctx.recordUtility, "record utility",    needle)

    local targets = collectTargets()
    if targets[1] then dumpFunctions(targets[1].actor, "statue", needle) end
    if targets[1] and valid(targets[1].loc) then
        dumpFunctions(targets[1].loc, "location point", needle)
    end
    log("=========== END ===========")
end

----------------------------------------------------------------------
-- Chat hook
----------------------------------------------------------------------
local function registerChatHook()
    local ok, err = pcall(function()
        RegisterHook("/Script/Pal.PalUIChat:OnReceivedChat", function(context, message)
            local received = message:get()
            if not received or not received.Message then return end
            local text = received.Message:ToString()
            if not text then return end

            local lower = string.lower(text)
            if lower == "!ftdiag" then
                pcall(diagnose)
            elseif lower == "!ftprobe" then
                pcall(probe)
            elseif string.sub(lower, 1, 8) == "!ftfind " then
                pcall(function() find(string.sub(lower, 9)) end)
            end
        end)
    end)

    if ok then
        log("v" .. VERSION .. " ready. Commands: !ftdiag | !ftprobe | !ftfind <text>")
    else
        log("failed to register chat hook: " .. tostring(err))
    end
end

registerChatHook()
