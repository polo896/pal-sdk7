-- =================================================================
-- AoE Resource Gathering by Wol4ara896
-- Patched for Palworld 1.0.4 (SDK: sdk-dumper-7 in this repo)
-- -----------------------------------------------------------------
-- 1.0.4 FIX NOTES (crash: EXCEPTION_ACCESS_VIOLATION reading
-- 0xffffffffffffffff when mining ore):
--
--  1) Cached UPalMapObjectModel / UPalFoliageInstance objects are now
--     liveness-checked with :IsValid() BEFORE every property access
--     (IsRockAlive / IsTreeAlive / scan readers / scan refresh).
--     Touching a GC-destroyed UObject is a NATIVE access violation
--     that pcall() can NOT catch. Patch 1.0.4 changed map-object
--     destruction/GC timing, so cache entries now routinely dangle
--     (depleted rocks, respawns, streaming, fast travel, dungeons).
--     Dead entries are detached from the spatial grid on detection.
--
--  2) Grid identity is Guid-based (byGuid) in addition to byObj, so a
--     cache refresh works even if UE4SS hands out a new userdata
--     wrapper per FindAllOf call (prevents duplicate entries and
--     wipes of the whole cache on every rescan).
--
--  3) Foliage InstanceIds TArray is length-checked via GetArrayNum()
--     before indexing. UE4SS auto-GROWS a TArray on out-of-bounds
--     read and throws on index 0 -- both corrupted the hooked params.
--
--  4) Weapon fallback no longer calls :GetCurrentWeaponActor() on the
--     character/shooter (it no longer exists there in 1.0.4 -- only
--     on the UI reticle class now). Uses
--     ShooterComponent:GetHasWeapon() + EPalWeaponType instead.
--
--  5) GetPlayerUId() is called on PalPlayerController (where it lives
--     in the 1.0.4 SDK), with PlayerState.PlayerUId as fallback.
--
--  6) No long-lived Pawn caching (a respawned player = dangling pawn).
--     The pawn is re-fetched fresh on every hit (cheap).
--
--  7) Chat hook body wrapped in pcall; FName/FString handled whether
--     UE4SS returns userdata or plain Lua strings.
-- =================================================================

local okHelpers, UEHelpers = pcall(require, "UEHelpers")
if not okHelpers then UEHelpers = nil end

-- ====================================================================
--  Configuration
-- ====================================================================
local Config = {
    -- --- Functional settings (same as the old version) ---
    PickaxeRadius       = 5500.0, -- Pickaxe AoE radius (UE units, 100 = 1 meter)
    PickaxeMaxTargets   = 100,    -- Maximum pickaxe targets per hit (NOT reduced)
    PickaxeDamagePerHit = 500,    -- Damage applied to each target within the radius

    AxeRadius           = 5500.0, -- Axe AoE radius
    AxeMaxTargets       = 100,    -- Maximum axe targets per hit (NOT reduced)

    EnableAutoLoot      = false,
    AutoLootRadius      = 30000.0,

    CommandOn           = "!aoeon",
    CommandOff          = "!aoeoff",
    EnableChatToast     = true,

    -- --- Performance (background) ---
    TickIntervalMs         = 25,    -- Background scheduler interval (ms)
    TreeScanBudgetPerTick  = 400,   -- Trees scanned per tick (background only)
    RockScanBudgetPerTick  = 200,   -- Rocks scanned per tick (background only)
    SweepBudgetPerTick     = 2000,  -- Records cleaned up per tick
    TreeRescanDelaySeconds = 5,     -- Delay between full tree scan cycles
    RockRescanDelaySeconds = 5,     -- Delay between full rock scan cycles
    GridCellSize           = 2500.0, -- Spatial grid cell size (25 m)

    MaxCachedTrees = 300000,
    MaxCachedRocks = 80000,
}

-- EPalWeaponType (sdk-dumper-7/Pal_structs.hpp) -- used for tool detection.
local WEAPON_MELEE              = 7
local WEAPON_LASER_MINING_TOOL  = 20

-- EPalMapObjectDamagableType
local DAMAGABLE_NODAMAGE = 2

-- EPalFoliageInstanceState
local FOLIAGE_ALIVE = 0

local SqRad = {
    Pick = Config.PickaxeRadius ^ 2,
    Axe  = Config.AxeRadius ^ 2,
    Loot = Config.AutoLootRadius ^ 2,
}

local State = {
    enabled    = true,
    sendingRpc = false,
    tickBusy   = false,
    schedulerStarted = false,
}

local function GetDistSq(a, b)
    local dx = (a.X or 0) - (b.X or 0)
    local dy = (a.Y or 0) - (b.Y or 0)
    local dz = (a.Z or 0) - (b.Z or 0)
    return dx * dx + dy * dy + dz * dz
end

local function IsZeroLoc(t)
    return not t or not t.X or (t.X == 0 and t.Y == 0 and t.Z == 0)
end

local function GuidKey(A, B, C, D)
    return A .. ":" .. B .. ":" .. C .. ":" .. D
end

local function NameToStr(v)
    if v == nil then return "" end
    if type(v) == "string" then return v end
    if type(v) == "number" then return tostring(v) end
    local ok, r = pcall(function() return v:ToString() end)
    if ok and r ~= nil then return tostring(r) end
    return ""
end

local function SafeHook(path, cb)
    local ok, err = pcall(RegisterHook, path, cb)
    if not ok then
        print("[AoE] Hook failed: " .. path .. " (" .. tostring(err) .. ")")
    end
    return ok
end

-- FIX (1.0.4): every object obtained here is used immediately (same tick),
-- so it cannot be GC-destroyed under us. Never cache these across ticks.
local function GetPC()
    if UEHelpers then
        local ok, pc = pcall(function() return UEHelpers:GetPlayerController() end)
        if ok and pc and pc:IsValid() then return pc end
    end
    local ok, pc = pcall(function() return FindFirstOf("PalPlayerController") end)
    if ok and pc and pc:IsValid() then return pc end
    return nil
end

-- FIX (1.0.4): no pawn caching. A cached pawn dangles after death/respawn
-- and K2_GetActorLocation() on it is a native AV. Re-fetch is cheap.
local function GetLocalPlayer()
    local pc = GetPC()
    if not pc then return nil end
    local ok, pawn = pcall(function()
        local p = pc.Pawn
        if p and p:IsValid() then return p end
        return nil
    end)
    if ok then return pawn end
    return nil
end

-- FIX (1.0.4): GetPlayerUId() lives on APalPlayerController in the new SDK
-- (PalPlayerState only has the PlayerUId FGuid property).
local function GetPlayerUID()
    local pc = GetPC()
    if not pc then return nil end
    local ok, uid = pcall(function() return pc:GetPlayerUId() end)
    if ok and uid then return uid end
    local ok2, uid2 = pcall(function()
        local st = pc.PlayerState
        if st and st:IsValid() then
            -- NOTE: indexing a missing member may itself throw in UE4SS,
            -- so probe it in a nested pcall and fall back to the property.
            local okM, hasM = pcall(function() return st.GetPlayerUId end)
            if okM and hasM then
                local ok3, u3 = pcall(function() return st:GetPlayerUId() end)
                if ok3 and u3 then return u3 end
            end
            return st.PlayerUId
        end
        return nil
    end)
    if ok2 then return uid2 end
    return nil
end

local function ShowToast(text, uid)
    if not Config.EnableChatToast then return end
    if type(ExecuteInGameThread) ~= "function" then return end
    pcall(function()
        ExecuteInGameThread(function()
            local gs = FindFirstOf("PalGameStateInGame")
            if gs and gs:IsValid() then
                gs:BroadcastChatMessage({
                    Category = 1, Sender = "AoE Mod", SenderPlayerUId = {},
                    Message = text,
                    ReceiverPlayerUIds = uid and { uid } or {},
                    MessageId = "", MessageArgKeys = {}, MessageArgValues = {}
                })
            end
        end)
    end)
end

local function IsPlayerAttacker(info, fallbackLoc)
    local isPlayer = false
    pcall(function()
        local atk = info.Attacker
        if atk and atk:IsValid() and
           (atk:IsA("/Script/Pal.PalPlayerCharacter") or
            atk:IsA("/Script/Pal.PalPlayerController")) then
            isPlayer = true
        end
    end)
    if not isPlayer and fallbackLoc and not IsZeroLoc(fallbackLoc) then
        local p = GetLocalPlayer()
        if p then
            local pLoc
            pcall(function() pLoc = p:K2_GetActorLocation() end)
            if pLoc and GetDistSq(pLoc, fallbackLoc) <= 160000.0 then isPlayer = true end -- 400^2
        end
    end
    return isPlayer
end

-- FIX (1.0.4): APalPlayerCharacter / UPalShooterComponent no longer have
-- GetCurrentWeaponActor() (only UPalUIAimReticleBase has it now).
-- Primary signal stays AttackStaticItemID; fallback uses GetHasWeapon()
-- (+ its class name) and the WeaponType enum (LaserMiningTool = 20).
local function IsUsingTool(info, tool)
    local wp = ""
    pcall(function() wp = NameToStr(info.AttackStaticItemID) end)

    local wt = -1
    pcall(function()
        local v = info.WeaponType
        if type(v) == "number" then wt = v end
    end)
    if wt == WEAPON_LASER_MINING_TOOL then
        return true -- laser mining tool counts as both pickaxe and axe
    end

    if wp == "" or wp == "None" then
        pcall(function()
            local atk = info.Attacker
            if atk and atk:IsValid() then
                local sh = atk.ShooterComponent
                if sh and sh:IsValid() then
                    local okW, w = pcall(function() return sh:GetHasWeapon() end)
                    if okW and w and w:IsValid() then
                        local okN, nm = pcall(function() return w:GetFullName() end)
                        if okN and nm then wp = tostring(nm) end
                        local okC, cl = pcall(function() return w:GetClass() end)
                        if okC and cl then
                            local okCN, cn = pcall(function() return cl:GetFullName() end)
                            if okCN and cn then wp = wp .. " " .. tostring(cn) end
                        end
                    end
                end
            end
        end)
    end
    local plasma = wp:find("LaserMiningTool") or wp:find("Laser") or wp:find("MiningTool")
    if tool == "Pickaxe" then return wp:find("Pickaxe") or wp:find("Pickel") or plasma end
    if tool == "Axe" then return wp:find("Axe") or wp:find("Deforest") or plasma end
    return false
end

local CELL_PACK   = 67108864

local CELL_OFFSET = 2000000

local function CellKey(cx, cy)
    return (cx + CELL_OFFSET) * CELL_PACK + (cy + CELL_OFFSET)
end

local function NewGrid()
    return {
        cells  = {},
        byObj  = {},
        byGuid = {},
        flat   = {},
        count  = 0,
        gen    = 0,
    }
end

local function GridCellOf(grid, x, y)
    local cx = math.floor(x / Config.GridCellSize)
    local cy = math.floor(y / Config.GridCellSize)
    return CellKey(cx, cy)
end

-- Idempotent detach: safe to call twice and from the sweep phase.
-- `flat` is intentionally left alone here; the sweep phase owns it and
-- drops detached (stale-gen) entries there. This split lets us prune
-- dead entries from a hit callback without breaking iteration.
local function GridDetach(grid, entry)
    if not entry.attached then return end
    entry.attached = false
    if entry.obj ~= nil then grid.byObj[entry.obj] = nil end
    grid.byGuid[entry.key] = nil
    local list = grid.cells[entry.cellKey]
    if list then
        for i = 1, #list do
            if list[i] == entry then
                table.remove(list, i)
                break
            end
        end
    end
    grid.count = grid.count - 1
end

local function GridUpsert(grid, obj, A, B, C, D, x, y, z, extra)
    local key = GuidKey(A, B, C, D)

    -- FIX (1.0.4): Guid is the primary identity. Even if UE4SS returns a
    -- fresh userdata wrapper for the same engine object on every
    -- FindAllOf, the refresh path below still hits (no duplicates,
    -- gen stays current, sweep won't wipe the cache).
    local existing = grid.byGuid[key]
    if existing then
        if existing.obj ~= nil and existing.obj ~= obj then
            grid.byObj[existing.obj] = nil
        end
        grid.byObj[obj] = existing
        existing.obj = obj
        existing.x, existing.y, existing.z = x, y, z
        existing.gen = grid.gen
        if extra then
            for k, v in pairs(extra) do existing[k] = v end
        end
        local ck = GridCellOf(grid, x, y)
        if ck ~= existing.cellKey then
            local old = grid.cells[existing.cellKey]
            if old then
                for i = 1, #old do
                    if old[i] == existing then table.remove(old, i) break end
                end
            end
            local list = grid.cells[ck]
            if not list then list = {}; grid.cells[ck] = list end
            list[#list + 1] = existing
            existing.cellKey = ck
        end
        return existing
    end

    -- Same wrapper re-seen but Guid slot empty (e.g. after a detach):
    -- fall through and create a fresh entry below (old tombstone in
    -- `flat` is collected by the sweep phase).
    if grid.byObj[obj] then grid.byObj[obj] = nil end

    local cap = grid.maxTrees and Config.MaxCachedTrees or Config.MaxCachedRocks
    if grid.count >= cap then return nil end

    local entry = {
        obj = obj, key = key, attached = true,
        A = A, B = B, C = C, D = D,
        x = x, y = y, z = z,
        gen = grid.gen,
    }
    if extra then
        for k, v in pairs(extra) do entry[k] = v end
    end

    local ck = GridCellOf(grid, entry.x, entry.y)
    local list = grid.cells[ck]
    if not list then list = {}; grid.cells[ck] = list end
    list[#list + 1] = entry
    entry.cellKey = ck

    grid.byObj[obj] = entry
    grid.byGuid[entry.key] = entry
    grid.flat[#grid.flat + 1] = entry
    grid.count = grid.count + 1
    return entry
end

local function CollectAndSort(grid, x, y, z, radiusSq, excludeKey, groupKey, maxTargets, pred)
    local half = math.floor(math.sqrt(radiusSq) / Config.GridCellSize) + 1
    local cx0 = math.floor(x / Config.GridCellSize)
    local cy0 = math.floor(y / Config.GridCellSize)

    local arr = {}
    local n = 0
    for dcx = -half, half do
        for dcy = -half, half do
            local list = grid.cells[CellKey(cx0 + dcx, cy0 + dcy)]
            if list then
                for i = 1, #list do
                    local e = list[i]
                    if e.key ~= excludeKey and (not groupKey or e.group == groupKey) and (not pred or pred(e)) then
                        local dx = e.x - x
                        local dy = e.y - y
                        local dz = e.z - z
                        local d = dx * dx + dy * dy + dz * dz
                        if d <= radiusSq then
                            n = n + 1
                            arr[n] = { e = e, d = d }
                        end
                    end
                end
            end
        end
    end

    if n == 0 then return {} end

    if n > maxTargets then
        table.sort(arr, function(a, b) return a.d < b.d end)
    end

    local res = {}
    local m = n < maxTargets and n or maxTargets
    for i = 1, m do res[i] = arr[i].e end
    return res
end

local function NoteDead(deadBin, entry)
    if deadBin then deadBin[#deadBin + 1] = entry end
end

-- FIX (1.0.4): THE crash fix. entry.obj may point at a GC-destroyed
-- UObject (depleted rock/tree, respawn churn, streaming, fast travel).
-- Reading ANY property on it is a native AV that pcall cannot catch,
-- so :IsValid() (UE4SS delete-listener-backed liveness check) MUST run
-- first. Dead entries are reported via deadBin and detached by the
-- caller AFTER CollectAndSort finishes iterating the cell lists.
local function IsTreeAlive(entry, deadBin)
    local obj = entry.obj
    if obj == nil then NoteDead(deadBin, entry) return false end
    local okV, valid = pcall(function() return obj:IsValid() end)
    if not okV or not valid then NoteDead(deadBin, entry) return false end
    local ok, state = pcall(function() return obj.InstanceState end)
    if not ok or state == nil then return true end
    return state == FOLIAGE_ALIVE or state == "Alive"
end

local function IsRockAlive(entry, deadBin)
    local obj = entry.obj
    if obj == nil then NoteDead(deadBin, entry) return false end
    local okV, valid = pcall(function() return obj:IsValid() end)
    if not okV or not valid then NoteDead(deadBin, entry) return false end
    local ok, hp = pcall(function() return obj.Hp end)
    if not ok or hp == nil then return true end
    local okC, cur = pcall(function() return hp.CurrentValue end)
    if not okC or cur == nil then return true end
    return cur > 0
end

local function PruneDead(grid, deadBin)
    if not deadBin then return end
    for i = 1, #deadBin do
        GridDetach(grid, deadBin[i])
    end
end

local function ReadTreeInstance(obj, grid)
    pcall(function()
        if not obj or not obj:IsValid() then return end

        local g = obj.InstanceId and obj.InstanceId.Guid
        if not g then return end
        local A, B, C, D = g.A, g.B, g.C, g.D
        if A == nil or B == nil or C == nil or D == nil then return end

        local wt = obj.WorldTransformCache
        local loc = wt and wt.Translation
        if not loc or loc.X == nil then return end
        if loc.X == 0 and loc.Y == 0 and loc.Z == 0 then return end

        local isMushroom = NameToStr(obj.FoliageTypeId):lower():find("mushroom") ~= nil

        local group
        local outer = obj:GetOuter()
        if outer and outer:IsValid() then
            local okF, full = pcall(function() return outer:GetFullName() end)
            if okF and full then group = tostring(full) end
        end
        if not isMushroom and group then
            isMushroom = group:lower():find("mushroom") ~= nil
        end

        GridUpsert(grid, obj, A, B, C, D, loc.X, loc.Y, loc.Z,
                   { group = group, isMushroom = isMushroom })
    end)
end

local function ReadRockModel(obj, grid)
    pcall(function()
        if not obj or not obj:IsValid() then return end

        local dt = obj.DamagableType
        if dt == nil or dt == DAMAGABLE_NODAMAGE or dt == "NoDamage" then return end

        local g = obj.InstanceId
        if not g then return end
        local A, B, C, D = g.A, g.B, g.C, g.D
        if A == nil or B == nil or C == nil or D == nil then return end

        local loc = nil
        local itc = obj.InitialTransformCache
        if itc then
            local t = itc.Translation
            if t and t.X ~= nil and (t.X ~= 0 or t.Y ~= 0 or t.Z ~= 0) then loc = t end
        end
        if not loc then
            local outer = obj:GetOuter()
            if outer and outer:IsValid() then
                local ok, l = pcall(function() return outer:K2_GetActorLocation() end)
                if ok and l and l.X ~= nil then loc = l end
            end
        end
        if not loc or loc.X == nil then return end
        if loc.X == 0 and loc.Y == 0 and loc.Z == 0 then return end

        GridUpsert(grid, obj, A, B, C, D, loc.X, loc.Y, loc.Z)
    end)
end

local Scans = {
    trees = { grid = nil, phase = "idle", list = nil, idx = 0, nextFind = 0, sweepIdx = 0 },
    rocks = { grid = nil, phase = "idle", list = nil, idx = 0, nextFind = 0, sweepIdx = 0 },
}
Scans.trees.grid = NewGrid()
Scans.rocks.grid = NewGrid()
Scans.trees.grid.maxTrees = true
Scans.rocks.grid.maxTrees = nil

local function ScanSlice(s, classShort, budget, rescanDelay, reader)
    if s.phase == "idle" then
        if os.clock() >= s.nextFind then
            local ok, list = pcall(function() return FindAllOf(classShort) end)
            if ok and list then
                s.list = list
                s.idx = 1
                s.phase = "scan"
                s.grid.gen = s.grid.gen + 1
            else
                s.nextFind = os.clock() + 5
            end
        end
        return
    end

    if s.phase == "scan" then
        local list = s.list
        if type(list) ~= "table" then
            s.phase = "idle"
            s.nextFind = os.clock() + 5
            s.list = nil
            return
        end
        local n = #list
        local processed = 0
        while s.idx <= n and processed < budget do
            local obj = list[s.idx]
            local existing = obj and s.grid.byObj[obj] or nil
            if existing then
                -- Object may have died between FindAllOf and this slice.
                local okv, valid = pcall(function() return obj:IsValid() end)
                if okv and valid then
                    existing.gen = s.grid.gen
                else
                    GridDetach(s.grid, existing)
                end
            elseif obj then
                reader(obj, s.grid)
            end
            s.idx = s.idx + 1
            processed = processed + 1
        end
        if s.idx > n then
            s.phase = "sweep"
            s.sweepIdx = 1
            s.list = nil -- release wrappers ASAP so Lua can drop them
        end
        return
    end

    if s.phase == "sweep" then
        local grid = s.grid
        local flat = grid.flat
        local processed = 0
        while s.sweepIdx <= #flat and processed < Config.SweepBudgetPerTick do
            local e = flat[s.sweepIdx]
            if e.gen ~= grid.gen then
                GridDetach(grid, e) -- idempotent: also covers hit-path prunes
                flat[s.sweepIdx] = flat[#flat]
                flat[#flat] = nil
            else
                s.sweepIdx = s.sweepIdx + 1
            end
            processed = processed + 1
        end
        if s.sweepIdx > #flat then
            s.phase = "idle"
            s.nextFind = os.clock() + rescanDelay
        end
    end
end

local function TreeScanSlice(budget)
    ScanSlice(Scans.trees, "PalFoliageInstance", budget, Config.TreeRescanDelaySeconds, ReadTreeInstance)
end

local function RockScanSlice(budget)
    ScanSlice(Scans.rocks, "PalMapObjectModel", budget, Config.RockRescanDelaySeconds, ReadRockModel)
end

-- FIX (1.0.4): UE4SS TArrays are 1-based in Lua; reading index 0 throws,
-- and reading past the end AUTO-GROWS the array (corrupting hooked
-- params!). Always length-check via GetArrayNum() first.
local function TArrayCount(t)
    if t == nil then return 0 end
    if type(t) == "table" then return #t end
    local ok, n = pcall(function() return t:GetArrayNum() end)
    if ok and type(n) == "number" then return n end
    return 0
end

local function FoliageFirstId(ids)
    if TArrayCount(ids) < 1 then return nil end
    local ok, el = pcall(function() return ids[1] end)
    if not ok then return nil end
    return el
end

local function SendFoliageOne(net, cC, mI, ids, info, e, origA, origB, origC, origD)
    State.sendingRpc = true
    pcall(function()
        if not (net and net:IsValid()) then return end
        local el = FoliageFirstId(ids)
        local g = el and el.Guid
        if g then
            g.A, g.B, g.C, g.D = e.A, e.B, e.C, e.D
            net:RequestDamageFoliage_ToServer(cC, mI, ids, info)
        end
    end)

    pcall(function()
        local el = FoliageFirstId(ids)
        local g = el and el.Guid
        if g then g.A, g.B, g.C, g.D = origA, origB, origC, origD end
    end)
    State.sendingRpc = false
end

local function SendMapObjectOne(net, inst, info, e, origA, origB, origC, origD)
    State.sendingRpc = true
    pcall(function()
        if not (net and net:IsValid()) then return end
        if inst then
            inst.A, inst.B, inst.C, inst.D = e.A, e.B, e.C, e.D
            net:RequestDamageMapObject_ToServer(inst, info)
        end
    end)
    pcall(function()
        if inst then inst.A, inst.B, inst.C, inst.D = origA, origB, origC, origD end
    end)
    State.sendingRpc = false
end


local function OnFoliageDamage(self, CellCoord, ModelId, InstanceIds, DamageInfo)
    if not State.enabled or State.sendingRpc then return end

    local ok, net, cC, mI, ids, info = pcall(function()
        return self:get(), CellCoord:get(), ModelId:get(), InstanceIds:get(), DamageInfo:get()
    end)
    if not ok or not net or not info then return end

    local target = FoliageFirstId(ids)
    if not target then return end
    local g = target.Guid
    if not g or g.A == nil or g.B == nil or g.C == nil or g.D == nil then return end
    local origA, origB, origC, origD = g.A, g.B, g.C, g.D

    if not IsUsingTool(info, "Axe") then return end

    local hitKey = GuidKey(origA, origB, origC, origD)
    local grid = Scans.trees.grid
    local entry = grid.byGuid[hitKey]

    local x, y, z, group, hitIsMushroom
    if entry and entry.x then
        x, y, z, group = entry.x, entry.y, entry.z, entry.group
        hitIsMushroom = entry.isMushroom or false
    else
        local hl = info.HitLocation
        if IsZeroLoc(hl) then return end
        x, y, z = hl.X, hl.Y, hl.Z
        hitIsMushroom = false
    end

    if not IsPlayerAttacker(info, { X = x, Y = y, Z = z }) then return end

    local deadBin = {}
    local pred
    if group and not hitIsMushroom then
        pred = function(e)
            return IsTreeAlive(e, deadBin) and (e.isMushroom or e.group == group)
        end
    else
        pred = function(e) return IsTreeAlive(e, deadBin) end
    end

    local targets = CollectAndSort(grid, x, y, z, SqRad.Axe, hitKey, nil, Config.AxeMaxTargets, pred)
    PruneDead(grid, deadBin)
    if #targets == 0 then return end

    for i = 1, #targets do
        SendFoliageOne(net, cC, mI, ids, info, targets[i], origA, origB, origC, origD)
    end
end

SafeHook("/Script/Pal.PalNetworkMapObjectComponent:RequestDamageFoliage_ToServer",
function(self, CellCoord, ModelId, InstanceIds, DamageInfo)
    pcall(OnFoliageDamage, self, CellCoord, ModelId, InstanceIds, DamageInfo)
end)


local function OnMapObjectDamage(self, InstanceId, Info)
    if not State.enabled or State.sendingRpc then return end

    local ok, net, inst, info = pcall(function()
        return self:get(), InstanceId:get(), Info:get()
    end)
    if not ok or not net or not inst or not info then return end

    if not IsPlayerAttacker(info, info.HitLocation) or not IsUsingTool(info, "Pickaxe") then return end

    local origA, origB, origC, origD = inst.A, inst.B, inst.C, inst.D
    if origA == nil or origB == nil or origC == nil or origD == nil then return end

    local x, y, z
    if not IsZeroLoc(info.HitLocation) then
        x, y, z = info.HitLocation.X, info.HitLocation.Y, info.HitLocation.Z
    else
        local entry = Scans.rocks.grid.byGuid[GuidKey(origA, origB, origC, origD)]
        if entry and entry.x then x, y, z = entry.x, entry.y, entry.z end
    end
    if not x then return end

    local grid = Scans.rocks.grid
    local deadBin = {}
    local targets = CollectAndSort(grid, x, y, z, SqRad.Pick,
                                   GuidKey(origA, origB, origC, origD), nil,
                                   Config.PickaxeMaxTargets,
                                   function(e) return IsRockAlive(e, deadBin) end)
    PruneDead(grid, deadBin)
    if #targets == 0 then return end

    pcall(function()
        info.NativeDamageValue = Config.PickaxeDamagePerHit
        info.BasePower = Config.PickaxeDamagePerHit
    end)

    for i = 1, #targets do
        SendMapObjectOne(net, inst, info, targets[i], origA, origB, origC, origD)
    end
end

SafeHook("/Script/Pal.PalNetworkMapObjectComponent:RequestDamageMapObject_ToServer",
function(self, InstanceId, Info)
    pcall(OnMapObjectDamage, self, InstanceId, Info)
end)

SafeHook("/Script/Pal.PalMapObjectDropItem:OnProceedTimerMovementActive", function(self)
    if not State.enabled or not Config.EnableAutoLoot then return end
    pcall(function()
        local drop = self:get()
        local player = GetLocalPlayer()
        if drop and drop:IsValid() and player and player:IsValid() then
            local pLoc, aLoc
            pcall(function() pLoc = player:K2_GetActorLocation() end)
            pcall(function() aLoc = drop:K2_GetActorLocation() end)
            if pLoc and aLoc and GetDistSq(pLoc, aLoc) <= SqRad.Loot then
                local model = drop:GetModel()
                if model and model:IsValid() then
                    local conc = model:GetConcreteModel(false)
                    -- FIX (1.0.4): only UPalMapObjectPickableItemModelBase
                    -- has RequestPickup(bool); anything else throws a Lua
                    -- error here instead of crashing (call is pcall'd).
                    if conc and conc:IsValid() then
                        local okP, errP = pcall(function() conc:RequestPickup(true) end)
                        if not okP then
                            print("[AoE] RequestPickup failed: " .. tostring(errP))
                        end
                    end
                end
            end
        end
    end)
end)


SafeHook("/Script/Pal.PalUIChat:OnReceivedChat", function(ctx, msg)
    -- FIX (1.0.4): hook body must never leak a Lua error.
    pcall(function()
        local okM, rec = pcall(function() return msg:get() end)
        if not okM or not rec then return end
        local okMsg, raw = pcall(function() return rec.Message end)
        if not okMsg or raw == nil then return end
        local txt = NameToStr(raw)
        local uid = GetPlayerUID()

        if txt == Config.CommandOn then
            if not State.enabled then
                State.enabled = true
                ShowToast("Mod ENABLED", uid)
            else
                ShowToast("Mod is already ENABLED", uid)
            end
        elseif txt == Config.CommandOff then
            if State.enabled then
                State.enabled = false
                ShowToast("Mod DISABLED (Tools default)", uid)
            else
                ShowToast("Mod is already DISABLED", uid)
            end
        end
    end)
end)

pcall(function()
    NotifyOnNewObject("/Script/Pal.PalFoliageInstance", function(obj)
        pcall(function()
            local grid = Scans.trees.grid
            if grid.count < Config.MaxCachedTrees then
                ReadTreeInstance(obj, grid)
            end
        end)
    end)
end)


local function SchedulerTick()
    if State.tickBusy then return end
    State.tickBusy = true
    local ok, err = pcall(function()
        pcall(TreeScanSlice, Config.TreeScanBudgetPerTick)
        pcall(RockScanSlice, Config.RockScanBudgetPerTick)
    end)
    if not ok then
        print("[AoE] Tick error: " .. tostring(err))
    end
    State.tickBusy = false
end

local function StartScheduler()
    if State.schedulerStarted then return end
    State.schedulerStarted = true

    if type(LoopAsync) == "function" then
        local ok = pcall(LoopAsync, Config.TickIntervalMs, SchedulerTick)
        if ok then return end
    end
    if type(ExecuteWithDelay) == "function" then
        local function chain()
            pcall(SchedulerTick)
            pcall(ExecuteWithDelay, Config.TickIntervalMs, chain)
        end
        pcall(chain)
        return
    end
    print("[AoE] WARNING: no LoopAsync/ExecuteWithDelay - background scans unavailable")
end

StartScheduler()
print("[AoE] AoE Resource Gathering loaded (1.0.4 patch)")

return {
    Config = Config,
    State  = State,
    Grids  = { trees = Scans.trees.grid, rocks = Scans.rocks.grid },
    Scans  = Scans,
    Tick   = SchedulerTick,
}
