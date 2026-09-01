-- ============================================================================
--  TowerHunter — Ancient Ruins / Ancient Towers helper (Palworld, UE4SS Lua)
-- ============================================================================
--  F6 opens the control panel with every Ancient Ruins tower found in the
--  world. For each tower:
--    [v] MARK - player's own "visited" checkbox (saved to a local file)
--    TP      - teleport near the tower (staged, waits for terrain streaming)
--    OPEN    - clears the tower natively (mini-game success request /
--              MarkAsCleared), unlocks its fast travel point
--    LOOT    - collects the stele (ancient shrine) reward natively
--    AUTO    - teleport -> open -> loot, chained
--  Global: RESCAN / OPEN ALL / LOOT ALL / AUTO TOUR.
--
--  Everything goes through the game's own request functions
--  (UPalNetworkPlayerComponent::Request*), so the server treats it exactly
--  as if the player did it by hand - world save flags, fast travel unlocks
--  and item grants behave normally.
-- ============================================================================

local MOD_TAG  = "[TowerHunter]"
local MOD_DIR  = "TowerHunter"
local PROGRESS_FILE = "towerhunter_progress.txt"

local towerUI = require("tower_ui")

local CONFIG = {
    OpenKey        = "F6",
    ChatPrefix     = "!",
    TeleportOffset = 900.0,    -- units (~9 m) from tower center, so you don't spawn inside the mesh
    GroupRadius    = 6000.0,   -- units (~60 m): stele/barrier/fast-travel are linked to a gimmick within this radius
    ClusterRadius  = 4000.0,   -- units (~40 m): gimmicks closer than this belong to the same tower
    PageSize       = 7,        -- tower rows per page
    CooldownMs     = 400,      -- min pause between panel actions
    WinDelayMs     = 500,      -- after you press F: let the mini-game open, then win it for you
    DirectRange    = 9000.0,   -- direct teleport if within this range, staged otherwise
    StagingZ       = 100000.0,
    TraceTop       = 200000.0,
    TraceBottom    = -200000.0,
    SurfaceOffset  = 150.0,
    StreamingPollMs = 100,
    StreamingMinMs  = 250,
    StreamingMaxMs  = 6000,
}

-- ================================ helpers ==================================

local function Log(msg) print(MOD_TAG .. " " .. tostring(msg) .. "\n") end

local function SafeCall(fn, ...)
    local ok, res = pcall(fn, ...)
    if ok then return res end
    return nil
end

local function SafeDo(fn)
    local ok, err = pcall(fn)
    if not ok then Log("suppressed error: " .. tostring(err)) end
    return ok
end

local function IsValidObj(obj)
    if obj == nil then return false end
    local ok, v = pcall(function() return obj:IsValid() end)
    if ok and v == false then return false end
    return true
end

local function IsDefaultObj(obj)
    local name = SafeCall(function() return obj:GetFullName() end)
    return type(name) == "string" and name:find("Default__", 1, true) ~= nil
end

local function hasMethod(obj, name)
    local res = false
    pcall(function() res = (type(obj[name]) == "function") end)
    return res
end

local function ValueToString(v)
    if v == nil then return nil end
    if type(v) == "string" then return v end
    if type(v) ~= "userdata" and type(v) ~= "table" then return nil end
    local out
    pcall(function()
        if hasMethod(v, "get") then
            v = v:get()
            if v == nil then return end
            if type(v) == "string" then out = v return end
        end
        if (type(v) == "userdata" or type(v) == "table") and hasMethod(v, "ToString") then
            out = v:ToString()
        else
            out = tostring(v)
        end
    end)
    return out and tostring(out) or nil
end

local function nowMs()
    local ok, c = pcall(os.clock)
    return (ok and c) and math.floor(c * 1000) or 0
end

local function quatFromYaw(yawDeg)
    local r = math.rad(yawDeg or 0) * 0.5
    return { X = 0, Y = 0, Z = math.sin(r), W = math.cos(r) }
end

local function dist2d(ax, ay, bx, by)
    return math.sqrt((ax - bx) ^ 2 + (ay - by) ^ 2)
end

-- ============================== game access ================================

local palUtilityCache, controllerCache = nil, nil

local function palUtility()
    if palUtilityCache ~= nil and IsValidObj(palUtilityCache) then return palUtilityCache end
    palUtilityCache = nil
    local ok, obj = pcall(StaticFindObject, "/Script/Pal.Default__PalUtility")
    if ok and IsValidObj(obj) then palUtilityCache = obj return obj end
    return nil
end

local function getController()
    if controllerCache ~= nil and IsValidObj(controllerCache) then return controllerCache end
    controllerCache = nil
    local ok, ctrl = pcall(FindFirstOf, "PalPlayerController")
    if ok and IsValidObj(ctrl) and not IsDefaultObj(ctrl) then controllerCache = ctrl return ctrl end
    return nil
end

local function getLocalCharacter()
    local util, ctrl = palUtility(), getController()
    if util ~= nil and ctrl ~= nil then
        local ch = SafeCall(function() return util:GetPlayerCharacter(ctrl) end)
        if IsValidObj(ch) and not IsDefaultObj(ch) then return ch end
    end
    if ctrl ~= nil then
        local pawn = SafeCall(function() return ctrl.Pawn end)
        if IsValidObj(pawn) and not IsDefaultObj(pawn) then return pawn end
    end
    return nil
end

local function notify(msg)
    Log(msg)
    local util, ctrl = palUtility(), getController()
    if util ~= nil and ctrl ~= nil then
        SafeDo(function() util:SendSystemToPlayerChat(ctrl, tostring(msg), {}) end)
    end
end

local function getActorLoc(actor)
    return SafeCall(function()
        local l = actor:K2_GetActorLocation()
        return { X = tonumber(l.X) or 0, Y = tonumber(l.Y) or 0, Z = tonumber(l.Z) or 0 }
    end)
end

local function getClassName(obj)
    return SafeCall(function() return obj:GetClass():GetFName():ToString() end)
end

-- ============================== teleportation ==============================
--  Staged warp ported from the proven PalWarp mod: jump to a staging height,
--  wait for world partition streaming, trace the ground, land.

local kismetLibCache = nil

local function traceGroundZ(char, x, y)
    if kismetLibCache == nil or not IsValidObj(kismetLibCache) then
        kismetLibCache = nil
        local ok, lib = pcall(StaticFindObject, "/Script/Engine.Default__KismetSystemLibrary")
        if not (ok and IsValidObj(lib)) then return nil end
        kismetLibCache = lib
    end
    local zeroColor = { R = 0, G = 0, B = 0, A = 0 }
    for _, channel in ipairs({ 0, 1, 2, 3 }) do
        local hit = {}
        local ok, wasHit = pcall(function()
            return kismetLibCache:LineTraceSingle(char,
                { X = x, Y = y, Z = CONFIG.TraceTop }, { X = x, Y = y, Z = CONFIG.TraceBottom },
                channel, false, { char }, 0, hit, true, zeroColor, zeroColor, 0.0)
        end)
        if ok and wasHit then
            local z
            pcall(function()
                local h = hit
                if type(h) == "userdata" and hasMethod(h, "get") then h = h:get() end
                if h ~= nil and h.ImpactPoint ~= nil then z = tonumber(h.ImpactPoint.Z) end
                if z == nil and h ~= nil and h.Location ~= nil then z = tonumber(h.Location.Z) end
            end)
            if z ~= nil then return z end
        end
    end
    return nil
end

local function tryGameTeleport(char, x, y, z, yaw, bNoCheck, bAroundCheck)
    local util = palUtility()
    if util == nil or not IsValidObj(char) then return false end
    local ok, res = pcall(function()
        return util:Teleport(char, { X = x, Y = y, Z = z }, quatFromYaw(yaw),
            bNoCheck == true, bAroundCheck == true)
    end)
    return ok and res == true
end

local function getMovement(char)
    local mv = SafeCall(function() return char.CharacterMovement end)
    if not IsValidObj(mv) then
        mv = SafeCall(function() return char:GetCharacterMovement() end)
        if not IsValidObj(mv) then return nil end
    end
    return mv
end

local function stagedTeleport(char, dx, dy, dzHint, yaw, onDone)
    local sx, sy, sz
    local src = getActorLoc(char)
    if src == nil then
        if onDone then SafeDo(function() onDone(false) end) end
        return
    end
    sx, sy, sz = src.X, src.Y, src.Z

    local movement = getMovement(char)
    local prevMode = SafeCall(function() return movement.MovementMode end)
    local restored, finished = false, false

    local function restoreMovement()
        if restored then return end
        restored = true
        if movement ~= nil then
            SafeDo(function() movement:StopMovementImmediately() end)
            SafeDo(function() movement:SetMovementMode(tonumber(prevMode) or 1, 0) end)
        end
    end

    local function finish(success)
        if finished then return end
        finished = true
        restoreMovement()
        if onDone then SafeDo(function() onDone(success) end) end
    end

    if movement ~= nil then
        SafeDo(function() movement:StopMovementImmediately() end)
        SafeDo(function() movement:SetMovementMode(0, 0) end)
    end

    local okSet = SafeDo(function()
        local res = char:K2_SetActorLocation({ X = dx, Y = dy, Z = CONFIG.StagingZ }, false, {}, true)
        if res == false then error("K2_SetActorLocation returned false") end
    end)
    if not okSet then
        SafeDo(function() char:K2_SetActorLocation({ X = sx, Y = sy, Z = sz }, false, {}, true) end)
        notify("[TP] could not reach staging height")
        finish(false)
        return
    end

    local pollMs = CONFIG.StreamingPollMs
    local minWait, maxWait = CONFIG.StreamingMinMs, CONFIG.StreamingMaxMs
    local waited, land = 0, nil

    local function gameThread(fn)
        if type(ExecuteInGameThread) == "function" and pcall(ExecuteInGameThread, fn) then
            return true
        end
        return false
    end

    local function schedule(fn)
        local okS = pcall(ExecuteWithDelay, pollMs, function()
            if IsValidObj(char) and not gameThread(fn) then finish(false) end
        end)
        if not okS then
            if not gameThread(fn) then finish(false) end
        end
    end

    local function poll()
        if not IsValidObj(char) then finished = true return end
        waited = waited + pollMs
        local done = true
        SafeDo(function()
            local wp = FindFirstOf("WorldPartitionSubsystem")
            if IsValidObj(wp) then done = wp:IsAllStreamingCompleted() end
        end)
        if (done == true and waited >= minWait) or waited >= maxWait then land() else schedule(poll) end
    end

    land = function()
        if not IsValidObj(char) then finished = true return end
        local finalZ = traceGroundZ(char, dx, dy)
        if finalZ ~= nil then
            finalZ = finalZ + CONFIG.SurfaceOffset
        elseif dzHint ~= nil and dzHint < CONFIG.StagingZ - 1000 then
            finalZ = dzHint
        end
        if finalZ == nil then
            SafeDo(function() char:K2_SetActorLocation({ X = sx, Y = sy, Z = sz }, false, {}, true) end)
            notify("[TP] no surface found at the destination - rolled back")
            finish(false)
            return
        end
        if not tryGameTeleport(char, dx, dy, finalZ, yaw, true, false) then
            local ok = SafeDo(function()
                char:K2_SetActorLocationAndRotation({ X = dx, Y = dy, Z = finalZ },
                    { Pitch = 0, Yaw = yaw or 0, Roll = 0 }, false, {}, true)
            end)
            if not ok then finish(false) return end
        end
        finish(true)
    end

    schedule(poll)
end

local function warpToRawCoords(dx, dy, dzHint, yaw, zTrusted, onDone)
    local char = getLocalCharacter()
    if char == nil then notify("[TP] player not found (are you in the world?)") return end
    local src = getActorLoc(char)
    if src == nil then notify("[TP] could not read your position") return end

    if dist2d(src.X, src.Y, dx, dy) <= CONFIG.DirectRange then
        local tz = traceGroundZ(char, dx, dy)
        local z = tz and (tz + CONFIG.SurfaceOffset) or nil
        if z == nil and zTrusted and dzHint ~= nil then z = dzHint end
        if z == nil then z = src.Z end
        if tryGameTeleport(char, dx, dy, z, yaw, tz ~= nil, tz == nil) then
            if onDone then SafeDo(function() onDone(true) end) end
            return
        end
    end
    stagedTeleport(char, dx, dy, dzHint, yaw, onDone)
end

-- ============================== progress file ==============================

local Progress = {}

local function pickFile(filename, mode)
    local folders = {}
    if type(debug) == "table" and type(debug.getinfo) == "function" then
        local src
        pcall(function()
            local info = debug.getinfo(2, "S")
            if info ~= nil and type(info.source) == "string" then src = info.source end
        end)
        if src ~= nil then
            if src:sub(1, 1) == "@" then src = src:sub(2) end
            local root = src:match("^(.-)[/\\]Scripts[/\\][^/\\]*%.lua$")
            if root == nil or root == "" then root = src:match("^(.-)[/\\][^/\\]*%.lua$") end
            if root ~= nil and root ~= "" then folders[1] = root end
        end
    end
    folders[#folders + 1] = "ue4ss/Mods/" .. MOD_DIR
    folders[#folders + 1] = "Mods/" .. MOD_DIR
    folders[#folders + 1] = MOD_DIR
    folders[#folders + 1] = "."
    for _, folder in ipairs(folders) do
        local p = folder .. "/" .. filename
        local f = io.open(p, mode)
        if f ~= nil then f:close() return p end
    end
    return nil
end

local progressPath = nil

local function loadProgress()
    if progressPath == nil then return 0 end
    local f = io.open(progressPath, "r")
    if f == nil then return 0 end
    local n = 0
    for line in f:lines() do
        local key = line:match("^([%-%d_]+)|1$")
        if key ~= nil then Progress[key] = true n = n + 1 end
    end
    f:close()
    return n
end

local function saveProgress()
    if progressPath == nil then return false end
    local ok = pcall(function()
        local f = io.open(progressPath, "w")
        if f == nil then error("cannot open " .. tostring(progressPath)) end
        f:write("# TowerHunter progress. Format: towerKey|1 (key = rounded coordinates)\n")
        for key in pairs(Progress) do f:write(key .. "|1\n") end
        f:close()
    end)
    return ok
end

-- ============================== tower discovery ============================

local Towers = {}
local Page   = 1
local Busy   = false
local uiRefresh  -- forward declaration (defined in the UI section)

local function towerKey(loc)
    return string.format("%d_%d", math.floor(loc.X / 100 + 0.5), math.floor(loc.Y / 100 + 0.5))
end

local GIMMICK_KINDS = {
    { pat = "Destruction", kind = "ROCKS" },
    { pat = "MiniGame",    kind = "MINIGAME" },
    { pat = "PalFight",    kind = "PAL FIGHT" },
    { pat = "Interact",    kind = "INTERACT" },
}

local function classifyGimmick(clsName)
    if clsName == nil then return "TOWER" end
    for _, m in ipairs(GIMMICK_KINDS) do
        if clsName:find(m.pat, 1, true) ~= nil then return m.kind end
    end
    return "TOWER"
end

local function collectActors(className)
    local out = {}
    local ok, list = pcall(FindAllOf, className)
    if ok and type(list) == "table" then
        for _, a in ipairs(list) do
            if IsValidObj(a) and not IsDefaultObj(a) then
                local loc = getActorLoc(a)
                if loc ~= nil then out[#out + 1] = { actor = a, loc = loc } end
            end
        end
    end
    return out
end

local function nearestFree(items, used, center, radius)
    local best, bestD = nil, radius
    for i, it in ipairs(items) do
        if not used[i] then
            local d = dist2d(center.X, center.Y, it.loc.X, it.loc.Y)
            if d < bestD then best, bestD = i, d end
        end
    end
    return best, bestD
end

-- read an FGuid (4 x uint32) as a comparable string key
local function readGuidKey(struct)
    if struct == nil then return nil end
    local a = SafeCall(function() return struct.A end)
    local b = SafeCall(function() return struct.B end)
    local c = SafeCall(function() return struct.C end)
    local d = SafeCall(function() return struct.D end)
    if a == nil or b == nil or c == nil or d == nil then return nil end
    return string.format("%d_%d_%d_%d", a, b, c, d)
end

local function actorGuidKey(actor)
    return readGuidKey(SafeCall(function() return actor.LevelObjectInstanceId end))
end

-- the barrier knows the instance ids of the gimmicks that control it
-- (TArray<FGuid> GimmickObjectIds) - exact link when readable
local function barrierGimmickKeys(barrier)
    local out = {}
    local ids = SafeCall(function() return barrier.GimmickObjectIds end)
    if type(ids) == "table" then
        local n = SafeCall(function() return #ids end) or 0
        for i = 1, n do
            local key = readGuidKey(SafeCall(function() return ids[i] end))
            if key ~= nil then out[key] = true end
        end
    end
    return out
end

local SortMode = 1   -- 1 = distance, 2 = type, 3 = status
local SORT_LABELS = { "DIST", "TYPE", "STATUS" }
local getTowerState  -- forward declaration (defined in the tower state section)

-- current state rank for status sorting: towers to open first,
-- then loot to grab, finished, marked-done last
local function statusRank(tw)
    local st = getTowerState(tw)
    if st.done then return 3 end
    if st.cleared == false then return 0 end
    if not st.looted then return 1 end
    return 2
end

local function resortTowers()
    local char = getLocalCharacter()
    local src = char and getActorLoc(char) or nil
    if SortMode == 1 and src ~= nil then
        table.sort(Towers, function(a, b)
            return dist2d(a.loc.X, a.loc.Y, src.X, src.Y) < dist2d(b.loc.X, b.loc.Y, src.X, src.Y)
        end)
    elseif SortMode == 2 then
        table.sort(Towers, function(a, b)
            if a.name ~= b.name then return a.name < b.name end
            return a.key < b.key
        end)
    else
        table.sort(Towers, function(a, b)
            local ra, rb = statusRank(a), statusRank(b)
            if ra ~= rb then return ra < rb end
            return a.key < b.key
        end)
    end
end

-- One physical tower can hold SEVERAL gimmick actors (e.g. a ROCKS tower has
-- one gimmick per rock - the wall only falls when ALL of them are cleared),
-- so gimmicks are merged into tower clusters:
--   1) exact link via barrier.GimmickObjectIds (works across any distance),
--   2) proximity merge for the rest (ClusterRadius).
local function scanTowers(preserveOrder)
    local gims     = collectActors("PalLevelObject_LockGimmickBase")
    local steles   = collectActors("BP_LevelObject_ItemPickupTower_C")
    local barriers = collectActors("BP_LevelObject_TowerLockBarrier_C")
    local fts      = collectActors("BP_LevelObject_TowerFastTravelPoint_C")

    local n = #gims
    local parent = {}
    for i = 1, n do parent[i] = i end
    local function find(i)
        while parent[i] ~= i do parent[i] = parent[parent[i]] i = parent[i] end
        return i
    end
    local function union(i, j)
        local ri, rj = find(i), find(j)
        if ri ~= rj then parent[ri] = rj end
    end

    -- 1) exact links through the barrier
    local guidToIdx = {}
    for i, g in ipairs(gims) do
        local k = actorGuidKey(g.actor)
        if k ~= nil then guidToIdx[k] = i end
    end
    for _, b in ipairs(barriers) do
        local members = {}
        for k in pairs(barrierGimmickKeys(b.actor)) do
            local gi = guidToIdx[k]
            if gi ~= nil then members[#members + 1] = gi end
        end
        for i = 2, #members do union(members[1], members[i]) end
    end

    -- 2) proximity merge
    for i = 1, n do
        for j = i + 1, n do
            if dist2d(gims[i].loc.X, gims[i].loc.Y, gims[j].loc.X, gims[j].loc.Y) <= CONFIG.ClusterRadius then
                union(i, j)
            end
        end
    end

    -- 3) cluster records
    local clusters = {}
    for i = 1, n do
        local r = find(i)
        clusters[r] = clusters[r] or { idxs = {} }
        clusters[r].idxs[#clusters[r].idxs + 1] = i
    end

    local towers = {}
    for _, c in pairs(clusters) do
        local cx, cy, cz, count = 0, 0, 0, 0
        local kinds, gimmicks = {}, {}
        for _, gi in ipairs(c.idxs) do
            local g = gims[gi]
            cx, cy, cz, count = cx + g.loc.X, cy + g.loc.Y, cz + g.loc.Z, count + 1
            gimmicks[#gimmicks + 1] = g.actor
            local kind = classifyGimmick(getClassName(g.actor))
            kinds[kind] = (kinds[kind] or 0) + 1
        end
        local bestKind, bestN = "TOWER", 0
        for k, cnt in pairs(kinds) do
            if cnt > bestN then bestKind, bestN = k, cnt end
        end
        local loc = { X = cx / count, Y = cy / count, Z = cz / count }
        towers[#towers + 1] = {
            gimmicks = gimmicks, kind = bestKind, name = bestKind, loc = loc,
            key = towerKey(loc), steles = {}, barrier = nil, ft = nil,
        }
    end

    -- 4) attach barriers / steles / fast travel points to the nearest cluster
    local usedBarrier, usedFt = {}, {}
    for _, t in ipairs(towers) do
        local bi = nearestFree(barriers, usedBarrier, t.loc, CONFIG.GroupRadius)
        if bi then usedBarrier[bi] = true t.barrier = barriers[bi].actor end
        local fi = nearestFree(fts, usedFt, t.loc, CONFIG.GroupRadius)
        if fi then usedFt[fi] = true t.ft = fts[fi].actor end
    end
    local usedStele = {}
    for si, s in ipairs(steles) do
        local bestT, bestD = nil, CONFIG.GroupRadius
        for _, t in ipairs(towers) do
            local d = dist2d(t.loc.X, t.loc.Y, s.loc.X, s.loc.Y)
            if d < bestD then bestT, bestD = t, d end
        end
        if bestT ~= nil then
            usedStele[si] = true
            bestT.steles[#bestT.steles + 1] = s.actor
        end
    end

    -- steles without a cluster are still useful (loot-only entries)
    for si, s in ipairs(steles) do
        if not usedStele[si] then
            towers[#towers + 1] = {
                gimmicks = {}, kind = "STELA", name = "STELA", loc = s.loc,
                key = towerKey(s.loc), steles = { s.actor }, barrier = nil, ft = nil,
            }
        end
    end

    -- drop clusters that look like junk: no stele, no barrier, no fast travel
    -- point anywhere near (e.g. leftover/test gimmicks that are not towers)
    local kept = {}
    for _, t in ipairs(towers) do
        if #t.steles > 0 or IsValidObj(t.barrier) or IsValidObj(t.ft) then
            kept[#kept + 1] = t
        else
            Log(string.format("scan: skipped a gimmick cluster without stele/barrier/ft at (%.0f, %.0f)",
                    t.loc.X, t.loc.Y))
        end
    end
    towers = kept
    local oldTowers = Towers
    Towers = towers

    if preserveOrder then
        -- internal rescan: keep the CURRENT row order (matched by key) so
        -- the list does not jump around while an action is running;
        -- genuinely new towers are appended at the end
        local oldPos = {}
        for i, t in ipairs(oldTowers) do oldPos[t.key] = i end
        table.sort(towers, function(a, b)
            local pa = oldPos[a.key] or math.huge
            local pb = oldPos[b.key] or math.huge
            if pa ~= pb then return pa < pb end
            return a.key < b.key
        end)
        Towers = towers
    else
        resortTowers()
    end

    if Page > math.max(1, math.ceil(#Towers / CONFIG.PageSize)) then Page = 1 end
    return #towers, #gims, #steles
end

local function findTowerByKey(key)
    for _, tw in ipairs(Towers) do
        if tw.key == key then return tw end
    end
    return nil
end

-- ============================== tower state ================================

local function countCleared(tw)
    local total, clearedCount = #tw.gimmicks, 0
    for _, g in ipairs(tw.gimmicks) do
        if IsValidObj(g) and SafeCall(function() return g:IsCleared() end) == true then
            clearedCount = clearedCount + 1
        end
    end
    return total, clearedCount
end

local function countLooted(tw)
    local total, lootedCount = #tw.steles, 0
    for _, s in ipairs(tw.steles) do
        if IsValidObj(s) and SafeCall(function() return s.bPickedInClient end) == true then
            lootedCount = lootedCount + 1
        end
    end
    return total, lootedCount
end

getTowerState = function(tw)
    local gTotal, gCleared = countCleared(tw)
    local sTotal, sLooted = countLooted(tw)
    local cleared = nil
    if gTotal > 0 then cleared = (gCleared == gTotal) end
    local looted = (sTotal > 0 and sLooted == sTotal)
    local done = Progress[tw.key] == true

    -- the barrier is the real truth about "is the tower open"
    local wallUp = nil
    if IsValidObj(tw.barrier) then
        wallUp = (SafeCall(function() return tw.barrier.bLocked end) == true)
    end

    local state
    if wallUp == true then state = "WALL UP"
    elseif wallUp == false then state = "WALL DOWN"
    elseif gTotal == 0 then state = "?"
    elseif cleared then state = "OPEN"
    else state = "LOCKED" end
    if gTotal > 1 then state = state .. string.format(" %d/%d", gCleared, gTotal) end
    if sTotal > 0 then
        if looted then state = state .. " | LOOTED"
        elseif sLooted > 0 then state = state .. string.format(" | LOOT %d/%d", sLooted, sTotal)
        else state = state .. " | LOOT" end
    else
        state = state .. " | NO STELE"
    end

    local stateKind = "unknown"
    if done then stateKind = "done"
    elseif wallUp == true then stateKind = "locked"
    elseif wallUp == false then stateKind = "open"
    elseif cleared == true then stateKind = "open"
    elseif cleared == false then stateKind = "locked" end

    -- distance from the player (informational)
    local distStr = ""
    local char = getLocalCharacter()
    local src = char and getActorLoc(char) or nil
    if src ~= nil then
        distStr = string.format("  |  %.0f m", dist2d(src.X, src.Y, tw.loc.X, tw.loc.Y) / 100)
    end

    return {
        name      = tw.name or "TOWER",
        coords    = string.format("(%.0f, %.0f)%s", tw.loc.X, tw.loc.Y, distStr),
        state     = state,
        stateKind = stateKind,
        done      = done,
        cleared   = cleared,
        looted    = looted,
        wallUp    = wallUp,
    }
end

-- ================================ actions ==================================

local lastActionMs = -math.huge
local function tryConsumeCooldown()
    local now = nowMs()
    if now - lastActionMs < CONFIG.CooldownMs then return false end
    lastActionMs = now
    return true
end

local function teleportToTower(tw, onDone, offsetOverride)
    local char = getLocalCharacter()
    if char == nil then notify("[TP] player not found") if onDone then onDone(false) end return end
    local src = getActorLoc(char)

    -- offset from the tower center toward the player's current position,
    -- so we never spawn inside the tower mesh
    local dx, dy, len = 1, 0, 1
    if src ~= nil then
        dx, dy = src.X - tw.loc.X, src.Y - tw.loc.Y
        len = math.sqrt(dx * dx + dy * dy)
        if len < 1 then dx, dy, len = 1, 0, 1 end
    end
    local off = offsetOverride or CONFIG.TeleportOffset
    local ox = tw.loc.X + dx / len * off
    local oy = tw.loc.Y + dy / len * off
    local yaw = math.deg(math.atan(tw.loc.X - ox, tw.loc.Y - oy))

    warpToRawCoords(ox, oy, tw.loc.Z, yaw, false, onDone)
end

-- mini-game overlay widgets live on the PERSISTENT game-instance UI stack:
-- one left open survives the world unload and crashes the game on the next
-- world load (stale references to dead tower actors). Close() is the game's
-- own stackable-UI close, exactly what ESC does.
local MINGAME_WIDGET_PATS = { "MiniGame", "Picking", "OneStroke", "GaugeStop" }

local function isMinigameWidget(w)
    local cls = getClassName(w) or ""
    for _, p in ipairs(MINGAME_WIDGET_PATS) do
        if cls:find(p, 1, true) ~= nil then return true end
    end
    return false
end

local function closeMinigameWidgets()
    local ok, list = pcall(FindAllOf, "PalUserWidgetStackableUI")
    if not (ok and type(list) == "table") then return 0 end
    local n = 0
    for _, w in ipairs(list) do
        if IsValidObj(w) and isMinigameWidget(w) then
            if SafeDo(function() w:Close() end) then n = n + 1 end
        end
    end
    if n > 0 then Log(string.format("cleanup: closed %d mini-game widget(s)", n)) end
    return n
end

-- the pal-fight widget holds a WEAK pointer to its gimmick; a stale one reads
-- bUseLightOrb (offset 0x338) through NULL on the next world load
local function closeFightWidgets()
    local ok, list = pcall(FindAllOf, "PalLockGimmickPalFightWidget")
    if not (ok and type(list) == "table") then return end
    for _, w in ipairs(list) do
        if IsValidObj(w) then
            SafeDo(function() w:FinishClose() end)
            Log("cleanup: closed a stale pal-fight widget")
        end
    end
end

-- the world can be torn down (exit to menu) while deferred steps are pending
local function worldAlive()
    return getLocalCharacter() ~= nil
end

-- ======================= mini-game assist (event-driven) ===================
-- The mod never touches towers on its own. When YOU press F on a mini-game
-- pedestal, the game opens the mini-game - and the mod replays the player's
-- winning move through the exact native calls the widget itself uses:
--   parameter OnReceive*Success()  (what the widget calls when you win)
--   gimmick OnMiniGameComplete(param)  (what the HUD calls afterwards)
--   widget Close()  (what ESC does - nothing stays on screen)
-- Everything is hook-driven: zero background polling.

-- unwrap a RegisterHook argument (RemoteUnrealParam or plain value)
local function hookArg(p)
    if type(p) == "table" and hasMethod(p, "get") then
        return SafeCall(function() return p:get() end) or p
    end
    return p
end

local recentWins = setmetatable({}, { __mode = "k" })   -- gimmick -> true

local function winMinigame(g, param)
    if not IsValidObj(g) or not IsValidObj(param) then return end
    if recentWins[g] then return end
    if SafeCall(function() return g:IsCleared() end) == true then return end
    recentWins[g] = true
    Log("[mini-game] auto-winning for you")
    -- exactly what the mini-game widget calls when the player wins:
    local reported = false
    if hasMethod(param, "OnReceiveGameSuccess") then        -- one-stroke puzzle
        reported = SafeDo(function() param:OnReceiveGameSuccess() end)
    elseif hasMethod(param, "OnReceiveSuccessPicking") then -- point picking
        reported = SafeDo(function() param:OnReceiveSuccessPicking() end)
    elseif hasMethod(param, "OnReceiveMiniGameResult") then -- gauge / ring stop
        reported = SafeDo(function() param:OnReceiveMiniGameResult(true) end)
    end
    if not reported then
        SafeDo(function() param.bMiniGameSuccess = true end)
    end
    SafeDo(function() g:OnMiniGameComplete(param) end)
    -- the widget never saw the player "play", so close it like ESC does
    ExecuteWithDelay(300, function() closeMinigameWidgets() end)
end

-- find a mini-game gimmick that is currently waiting for its result and win it
local function autoWinOpenedMinigames()
    if not worldAlive() then return end
    local ok, list = pcall(FindAllOf, "PalLevelObject_LockGimmickMiniGame")
    if not (ok and type(list) == "table") then return end
    for _, g in ipairs(list) do
        if IsValidObj(g) and SafeCall(function() return g:IsCleared() end) ~= true then
            local param = SafeCall(function() return g.CurrentParameter end)
            if IsValidObj(param) then
                winMinigame(g, param)
            end
        end
    end
end

local function registerMinigameAssist()
    -- HOOK 1: you pressed F on the pedestal (the gimmick's own interact event)
    local ok1 = pcall(RegisterHook,
        "/Script/Pal.PalLevelObject_LockGimmickMiniGame:OnTriggerInteract",
        function() end,
        function()
            -- the mini-game is opening right now - win it in a moment
            ExecuteWithDelay(CONFIG.WinDelayMs, autoWinOpenedMinigames)
        end)
    Log(ok1 and "mini-game assist: F hook attached" or "mini-game assist: F hook unavailable")

    -- HOOK 2: the mini-game widget itself just appeared on screen (covers
    -- gimmick classes whose F goes through a blueprint override)
    local widgetPaths = {
        "/Game/Pal/Blueprint/UI/OneStrorke/WBP_OneStrokeGame_ForDisplay.WBP_OneStrokeGame_ForDisplay_C",
        "/Game/Pal/Blueprint/UI/OneStroke/WBP_OneStrokeGame_ForDisplay.WBP_OneStrokeGame_ForDisplay_C",
        "/Game/Pal/Blueprint/UI/Picking/WBP_PickingGame02_ForDisplay.WBP_PickingGame02_ForDisplay_C",
        "/Game/Pal/Blueprint/UI/Salvage/WBP_SalvageGame_GaugeStopMiniGame.WBP_SalvageGame_GaugeStopMiniGame_C",
    }
    local hooked = 0
    for _, p in ipairs(widgetPaths) do
        local ok = pcall(RegisterHook, p .. ":Construct",
            function() end,
            function()
                ExecuteWithDelay(CONFIG.WinDelayMs, autoWinOpenedMinigames)
            end)
        if ok then hooked = hooked + 1 end
    end
    Log(string.format("mini-game assist: %d widget hook(s) attached", hooked))

    -- HOOK 3 (safety net): whatever finishes the mini-game - even a FAIL -
    -- is turned into a win before the gimmick processes the result, so the
    -- tower always opens once you have played it
    local ok3 = pcall(RegisterHook,
        "/Script/Pal.PalLevelObject_LockGimmickMiniGame:OnMiniGameComplete",
        function(_selfParam, paramParam)
            local param = hookArg(paramParam)
            if IsValidObj(param) and SafeCall(function() return param.bMiniGameSuccess end) ~= true then
                Log("[mini-game] turning your result into a win")
                SafeDo(function()
                    if hasMethod(param, "OnReceiveGameSuccess") then
                        param:OnReceiveGameSuccess()
                    elseif hasMethod(param, "OnReceiveSuccessPicking") then
                        param:OnReceiveSuccessPicking()
                    elseif hasMethod(param, "OnReceiveMiniGameResult") then
                        param:OnReceiveMiniGameResult(true)
                    else
                        param.bMiniGameSuccess = true
                    end
                end)
            end
        end)
    Log(ok3 and "mini-game assist: result hook attached" or "mini-game assist: result hook unavailable")
end

-- ======================= world-entry cleanup (event-driven) ================
-- A mini-game overlay left on screen survives the world unload (it lives on
-- the persistent game-instance UI stack) and crashes the game on the next
-- world load - the 0x338 bug. Instead of a background timer, the cleanup runs
-- exactly when a new player character spawns (= you entered a world).
local function registerWorldEntryCleanup()
    if type(NotifyOnNewObject) ~= "function" then
        Log("WARNING: NotifyOnNewObject unavailable - close mini-games with ESC before exiting to menu")
        return
    end
    local ok = pcall(NotifyOnNewObject, "/Script/Pal.PalPlayerCharacter", function()
        SafeDo(function()
            ExecuteWithDelay(500, function()
                closeMinigameWidgets()
                closeFightWidgets()
                controllerCache = nil
                kismetLibCache = nil
                SafeDo(function() if towerUI.is_visible() then towerUI.close() end end)
            end)
        end)
    end)
    Log(ok and "world-entry cleanup attached" or "WARNING: world-entry cleanup unavailable")
end

-- ================================== UI =====================================

local uiCtx

uiRefresh = function()
    if towerUI.is_visible() then
        towerUI.refresh()
    end
end

local function uiStats()
    local total, opened, looted, marked = #Towers, 0, 0, 0
    for _, tw in ipairs(Towers) do
        local st = getTowerState(tw)
        if st.cleared == true then opened = opened + 1 end
        if st.looted then looted = looted + 1 end
        if st.done then marked = marked + 1 end
    end
    local pages = math.max(1, math.ceil(total / CONFIG.PageSize))
    return string.format("Found %d | Opened %d | Looted %d | Marked %d | Page %d/%d",
            total, opened, looted, marked, Page, pages)
end

local function openUI()
    if towerUI.is_visible() then
        towerUI.close()
        return
    end
    scanTowers()
    -- after a re-sort the row you were looking at can land on another page;
    -- open the panel on the page of the tower you are standing at
    do
        local char = getLocalCharacter()
        local src2 = char and getActorLoc(char) or nil
        if src2 ~= nil and #Towers > 0 then
            local best, bestD = 1, math.huge
            for i, t in ipairs(Towers) do
                local d = dist2d(t.loc.X, t.loc.Y, src2.X, src2.Y)
                if d < bestD then best, bestD = i, d end
            end
            Page = math.floor((best - 1) / CONFIG.PageSize) + 1
        end
    end
    uiCtx = {
        getTowers  = function() return Towers end,
        getPage    = function() return Page end,
        setPage    = function(p) Page = p end,
        getPageSize = function() return CONFIG.PageSize end,
        getStats   = uiStats,
        getTowerState = getTowerState,
        getSortLabel = function() return SORT_LABELS[SortMode] end,
        onCycleSort = function()
            SortMode = (SortMode % #SORT_LABELS) + 1
            resortTowers()
            uiRefresh()
        end,

        onRescan  = function() scanTowers() resortTowers() notify(string.format("scan: %d towers", #Towers)) uiRefresh() end,
        onTpNearest = function()
            if Busy then return notify("another action is still running") end
            local best = nil
            for _, tw in ipairs(Towers) do
                local st = getTowerState(tw)
                local needOpen = #tw.gimmicks > 0 and st.cleared ~= true
                local needLoot = #tw.steles > 0 and not st.looted
                if (needOpen or needLoot) and not st.done then best = tw break end
            end
            if best == nil then best = Towers[1] end
            if best == nil then return notify("no towers found - press RESCAN") end
            Busy = true
            teleportToTower(best, function(ok)
                Busy = false
                if ok then notify(string.format("[TP] %s (%.0f, %.0f)", best.name, best.loc.X, best.loc.Y)) end
            end)
        end,
        onHelp    = function()
            notify("TP = teleport | MARK = your own checklist (saved) | press F on the tower " ..
                   "and the mod wins the mini-game for you | !th help in chat")
        end,
        onPrev = function() Page = math.max(1, Page - 1) uiRefresh() end,
        onNext = function() Page = Page + 1 uiRefresh() end,

        onToggleDone = function(tw)
            if Progress[tw.key] then Progress[tw.key] = nil else Progress[tw.key] = true end
            saveProgress()
            uiRefresh()
        end,
        onTeleport = function(tw)
            if Busy then return notify("another action is still running") end
            if not tryConsumeCooldown() then return end
            Busy = true
            teleportToTower(tw, function(ok)
                Busy = false
                if ok then notify(string.format("[TP] %s (%.0f, %.0f)", tw.name, tw.loc.X, tw.loc.Y)) end
                uiRefresh()
            end)
        end,
    }
    towerUI.show(uiCtx)
end

-- ================================ chat =====================================

local function isLocalPlayerState(selfParam)
    local util, ctrl = palUtility(), getController()
    if util == nil or ctrl == nil then return true end
    local same = true
    SafeDo(function()
        local selfObj = selfParam
        if (type(selfObj) == "userdata" or type(selfObj) == "table") and hasMethod(selfObj, "get") then
            selfObj = selfObj:get()
        end
        local lps = util:GetLocalPlayerState(ctrl)
        if IsValidObj(lps) and IsValidObj(selfObj)
           and hasMethod(lps, "GetFullName") and hasMethod(selfObj, "GetFullName") then
            same = (lps:GetFullName() == selfObj:GetFullName())
        end
    end)
    return same
end

local function handleChatCommand(text)
    local prefix = CONFIG.ChatPrefix
    text = (text or ""):gsub("^%s+", ""):gsub("%s+$", "")
    if text == "" or text:sub(1, #prefix) ~= prefix then return false end
    local rest = text:sub(#prefix + 1)
    local cmd, sub = rest:match("^(%S+)%s*(.*)$")
    if cmd == nil then return false end
    cmd = cmd:lower()
    sub = (sub or ""):lower():gsub("^%s+", "")

    if cmd == "th" or cmd == "tower" or cmd == "towers" then
        if sub == "rescan" then
            local n = scanTowers()
            notify(string.format("scan complete: %d towers", n))
            uiRefresh()
        elseif sub == "stats" then
            notify(uiStats())
        elseif sub == "help" then
            notify("!th - toggle panel | !th rescan | !th stats | press F on a tower and the mini-game is won for you")
        else
            openUI()
        end
        return true
    end
    return false
end

local function onEnterChat(selfParam, msgParam, _catParam)
    SafeDo(function()
        local txt = ValueToString(msgParam)
        if txt == nil then return end
        if not isLocalPlayerState(selfParam) then return end
        handleChatCommand(txt)
    end)
end

local function registerChatHook()
    local ok = pcall(RegisterHook, "/Script/Pal.PalPlayerState:EnterChat", onEnterChat)
    if ok then
        Log("chat hook attached (PalPlayerState:EnterChat)")
    else
        Log("chat hook unavailable - use the F6 hotkey")
    end
end

-- ================================ hotkeys ==================================

local function bindAction(fn)
    local guarded = function() SafeDo(fn) end
    return function()
        if type(ExecuteInGameThread) == "function" and pcall(ExecuteInGameThread, guarded) then
            return
        end
        SafeDo(guarded)
    end
end

local function bindKey(keyName, fn)
    if type(RegisterKeyBind) ~= "function" or type(Key) ~= "table" then
        Log("WARNING: RegisterKeyBind unavailable")
        return false
    end
    local keyEnum = Key[tostring(keyName):upper()]
    if keyEnum == nil then
        Log("unknown key: " .. tostring(keyName))
        return false
    end
    return pcall(RegisterKeyBind, keyEnum, bindAction(fn))
end

-- ================================ init =====================================

-- debug / console access (type TowerHunter.stats() in the UE4SS Lua console)
TowerHunter = {
    rescan   = function() return scanTowers() end,
    stats    = function() return uiStats() end,
    count    = function() return #Towers end,
    tower    = function(i) return Towers[i] end,
    state    = function(i) return getTowerState(Towers[i]) end,
    teleport = function(i) teleportToTower(Towers[i], function() end) end,
    ui       = openUI,
}

local function init()
    progressPath = pickFile(PROGRESS_FILE, "r") or pickFile(PROGRESS_FILE, "a")
    local loaded = loadProgress()
    if progressPath ~= nil then
        Log(string.format("progress file: %s (%d marked towers)", progressPath, loaded))
    else
        Log("WARNING: no writable folder for progress - marks live only in this session")
    end

    bindKey(CONFIG.OpenKey, openUI)
    bindKey("ESCAPE", function()
        if towerUI.is_visible() then towerUI.close() end
    end)
    registerChatHook()
    registerMinigameAssist()
    registerWorldEntryCleanup()

    Log(string.format("ready | F6 = panel | !th in chat | %s",
            IsValidObj(getLocalCharacter()) and "in world" or "enter a world to start"))
end

SafeDo(init)
