-- =================================================================
-- AoE Resource Gathering by Wol4ara896
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

    EnableAutoLoot      = true,
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

local SqRad = {
    Pick = Config.PickaxeRadius ^ 2,
    Axe  = Config.AxeRadius ^ 2,
    Loot = Config.AutoLootRadius ^ 2,
}

local State = {
    enabled    = true,
    player     = nil,
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
    local ok, r = pcall(function() return v:ToString() end)
    if ok and r ~= nil then return tostring(r) end
    return tostring(v)
end

local function SafeHook(path, cb)
    local ok, err = pcall(RegisterHook, path, cb)
    if not ok then
        print("[AoE] Hook failed: " .. path .. " (" .. tostring(err) .. ")")
    end
    return ok
end

local function GetPC()
    if UEHelpers then
        local ok, pc = pcall(function() return UEHelpers:GetPlayerController() end)
        if ok and pc and pc:IsValid() then return pc end
    end
    local ok, pc = pcall(function() return FindFirstOf("PalPlayerController") end)
    if ok and pc then return pc end
    return nil
end

local function GetLocalPlayer()
    if State.player and State.player:IsValid() then return State.player end
    local pc = GetPC()
    if pc and pc:IsValid() then
        pcall(function()
            if pc.Pawn and pc.Pawn:IsValid() then State.player = pc.Pawn end
        end)
    end
    return State.player
end

local function GetPlayerUID()
    local pc = GetPC()
    if pc and pc:IsValid() and pc.PlayerState and pc.PlayerState:IsValid() then
        local ok, uid = pcall(function() return pc.PlayerState:GetPlayerUId() end)
        if ok then return uid end
    end
    return nil
end

local function ShowToast(text, uid)
    if not Config.EnableChatToast then return end
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

local function IsUsingTool(info, tool)
    local wp = NameToStr(info.AttackStaticItemID)
    if wp == "" or wp == "None" then
        pcall(function()
            local atk = info.Attacker
            if atk and atk:IsValid() then
                local w = atk:GetCurrentWeaponActor()
                if not w and atk.ShooterComponent and atk.ShooterComponent:IsValid() then
                    w = atk.ShooterComponent:GetCurrentWeaponActor() or atk.ShooterComponent:GetHasWeapon()
                end
                if w and w:IsValid() then wp = w:GetFullName() end
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

local function GridUpsert(grid, obj, A, B, C, D, x, y, z, extra)
    local existing = grid.byObj[obj]
    if existing then
        existing.gen = grid.gen
        return existing
    end

    local cap = grid.maxTrees and Config.MaxCachedTrees or Config.MaxCachedRocks
    if grid.count >= cap then return nil end

    local entry = {
        obj = obj, key = GuidKey(A, B, C, D),
        A = A, B = B, C = C, D = D,
        x = x, y = y, z = z,
        gen = grid.gen,
    }
    if extra then
        for k, v in pairs(extra) do entry[k] = v end
    end

    local cx = math.floor(entry.x / Config.GridCellSize)
    local cy = math.floor(entry.y / Config.GridCellSize)
    local ck = CellKey(cx, cy)
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

local function GridRemove(grid, entry)
    grid.byObj[entry.obj] = nil
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

local function IsTreeAlive(entry)
    local ok, state = pcall(function() return entry.obj.InstanceState end)
    if not ok or state == nil then return true end
    return state == 0 or state == "Alive"
end

local function IsRockAlive(entry)
    local ok, hp = pcall(function() return entry.obj.Hp end)
    if not ok or hp == nil then return true end
    local cur = hp.CurrentValue
    if cur == nil then return true end
    return cur > 0
end

local function ReadTreeInstance(obj, grid)
    pcall(function()
        if not obj:IsValid() then return end

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
        if outer then group = outer:GetFullName() end
        if not isMushroom and group then
            isMushroom = group:lower():find("mushroom") ~= nil
        end

        GridUpsert(grid, obj, A, B, C, D, loc.X, loc.Y, loc.Z,
                   { group = group, isMushroom = isMushroom })
    end)
end

local function ReadRockModel(obj, grid)
    pcall(function()
        if not obj:IsValid() then return end

        local dt = obj.DamagableType
        if dt == nil or dt == 2 or dt == "NoDamage" then return end

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
        local n = #list
        local processed = 0
        while s.idx <= n and processed < budget do
            local obj = list[s.idx]
            local existing = s.grid.byObj[obj]
            if existing then
                local okv, valid = pcall(function() return obj:IsValid() end)
                if okv and valid then
                    existing.gen = s.grid.gen
                else
                    GridRemove(s.grid, existing)
                end
            else
                reader(obj, s.grid)
            end
            s.idx = s.idx + 1
            processed = processed + 1
        end
        if s.idx > n then
            s.phase = "sweep"
            s.sweepIdx = 1
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
                GridRemove(grid, e)
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

local function SendFoliageOne(net, cC, mI, ids, info, e, origA, origB, origC, origD)
    State.sendingRpc = true
    pcall(function()
        if not (net and net:IsValid()) then return end
        local el = ids and (ids[1] or ids[0])
        local g = el and el.Guid
        if g then
            g.A, g.B, g.C, g.D = e.A, e.B, e.C, e.D
            net:RequestDamageFoliage_ToServer(cC, mI, ids, info)
        end
    end)

    pcall(function()
        local el = ids and (ids[1] or ids[0])
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

    local okTarget, target = pcall(function() return ids and (ids[1] or ids[0]) or nil end)
    if not okTarget or not target then return end
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

    local pred
    if group and not hitIsMushroom then
        pred = function(e)
            return IsTreeAlive(e) and (e.isMushroom or e.group == group)
        end
    else
        pred = IsTreeAlive
    end

    local targets = CollectAndSort(grid, x, y, z, SqRad.Axe, hitKey, nil, Config.AxeMaxTargets, pred)
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

    local targets = CollectAndSort(Scans.rocks.grid, x, y, z, SqRad.Pick,
                                   GuidKey(origA, origB, origC, origD), nil,
                                   Config.PickaxeMaxTargets, IsRockAlive)
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
                    if conc and conc:IsValid() then conc:RequestPickup(true) end
                end
            end
        end
    end)
end)


SafeHook("/Script/Pal.PalUIChat:OnReceivedChat", function(ctx, msg)
    local rec = msg:get()
    if not rec or not rec.Message then return end
    local txt, uid = rec.Message:ToString(), GetPlayerUID()

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
print("[AoE] AoE Resource Gathering loaded")

return {
    Config = Config,
    State  = State,
    Grids  = { trees = Scans.trees.grid, rocks = Scans.rocks.grid },
    Scans  = Scans,
    Tick   = SchedulerTick,
}


