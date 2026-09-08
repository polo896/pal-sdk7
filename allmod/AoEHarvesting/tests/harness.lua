-- =================================================================
-- AoEHarvesting regression harness (runs WITHOUT the game).
-- Mocks UE4SS globals + engine objects and drives the mod through
-- realistic 1.0.4 scenarios, including GC-destroyed map objects.
--
-- Any property read / method call on a DEAD mocked object is recorded
-- in VIOLATIONS (in the real game that is a native
-- EXCEPTION_ACCESS_VIOLATION that pcall cannot catch).
--
-- Usage:
--   AOE_TARGET=/path/to/main.lua AOE_STRICT=1 lua harness.lua
-- (also runs under python-lupa)
-- =================================================================

local TARGET = os.getenv("AOE_TARGET")
assert(TARGET and TARGET ~= "", "AOE_TARGET env var required")
local STRICT = os.getenv("AOE_STRICT") == "1"

local failures = {}
local function check(cond, msg)
    if cond then return end
    if STRICT then failures[#failures + 1] = msg
    else print("[SOFT-FAIL] " .. msg) end
end

-- ---------------------------------------------------------------- mocks
local VIOLATIONS = {}
local function violate(msg) VIOLATIONS[#VIOLATIONS + 1] = msg end

local GROWN = { count = 0 } -- UE4SS TArray auto-grow watcher

local UE_METHODS = {}

UE_METHODS.IsValid = function(w, rec) return not rec.dead end
UE_METHODS.IsA = function(w, rec, path)
    if rec.dead then violate("IsA on dead " .. rec.name) return false end
    return (rec.isA and rec.isA[path]) or false
end
UE_METHODS.GetFullName = function(w, rec)
    if rec.dead then violate("GetFullName on dead " .. rec.name) return "" end
    return rec.fullname or rec.name
end
UE_METHODS.GetClass = function(w, rec)
    if rec.dead then violate("GetClass on dead " .. rec.name) return nil end
    return rec.classObj
end
UE_METHODS.GetOuter = function(w, rec)
    if rec.dead then violate("GetOuter on dead " .. rec.name) return nil end
    return rec.outer
end
UE_METHODS.K2_GetActorLocation = function(w, rec)
    if rec.dead then violate("K2_GetActorLocation on dead " .. rec.name) return nil end
    return { X = rec.loc.X, Y = rec.loc.Y, Z = rec.loc.Z }
end
UE_METHODS.GetHasWeapon = function(w, rec)
    if rec.dead then violate("GetHasWeapon on dead " .. rec.name) return nil end
    if rec.noSuchFunc then error("UFunction not found: GetHasWeapon") end
    return rec.weapon
end
UE_METHODS.GetCurrentWeaponActor = function(w, rec)
    -- Simulates 1.0.4: missing on character/shooter -> Lua error (catchable).
    error("UFunction not found: GetCurrentWeaponActor")
end
UE_METHODS.GetModel = function(w, rec)
    if rec.dead then violate("GetModel on dead " .. rec.name) return nil end
    return rec.model
end
UE_METHODS.GetConcreteModel = function(w, rec, bForce)
    if rec.dead then violate("GetConcreteModel on dead " .. rec.name) return nil end
    return rec.conc
end
UE_METHODS.RequestPickup = function(w, rec, b)
    if rec.dead then violate("RequestPickup on dead " .. rec.name) return nil end
    if rec.noSuchFunc then error("UFunction not found: RequestPickup") end
    rec.pickups = (rec.pickups or 0) + 1
    rec.lastPickupArg = b
end
UE_METHODS.GetPlayerUId = function(w, rec)
    if rec.noSuchFunc then error("UFunction not found: GetPlayerUId") end
    if rec.dead then violate("GetPlayerUId on dead " .. rec.name) return nil end
    return rec.uid
end
UE_METHODS.BroadcastChatMessage = function(w, rec, tbl)
    if rec.dead then violate("BroadcastChatMessage on dead " .. rec.name) return nil end
    rec.toasts = rec.toasts or {}
    rec.toasts[#rec.toasts + 1] = tbl.Message
end
UE_METHODS.ToString = function(w, rec)
    return rec.str or ""
end

-- RPC records + inline "server" damage simulation.
local RPC = { map = {}, foliage = {} }
local ROCKS_BY_GUID = {}
local TREES_BY_GUID = {}

UE_METHODS.RequestDamageMapObject_ToServer = function(w, rec, inst, info)
    if rec.dead then violate("RequestDamageMapObject_ToServer on dead net") return nil end
    RPC.map[#RPC.map + 1] = { A = inst.A, B = inst.B, C = inst.C, D = inst.D }
    local key = inst.A .. ":" .. inst.B .. ":" .. inst.C .. ":" .. inst.D
    local r = ROCKS_BY_GUID[key]
    if r and not r.dead then
        local dmg = (info and info.NativeDamageValue) or 0
        r.props.Hp.CurrentValue = r.props.Hp.CurrentValue - dmg
        if r.props.Hp.CurrentValue <= 0 then r.dead = true end
    end
end
UE_METHODS.RequestDamageFoliage_ToServer = function(w, rec, cC, mI, ids, info)
    if rec.dead then violate("RequestDamageFoliage_ToServer on dead net") return nil end
    local el = ids[1]
    local g = el and el.Guid
    RPC.foliage[#RPC.foliage + 1] = g and { A = g.A, B = g.B, C = g.C, D = g.D } or nil
    if g then
        local key = g.A .. ":" .. g.B .. ":" .. g.C .. ":" .. g.D
        local t = TREES_BY_GUID[key]
        if t and not t.dead then t.dead = true end -- one hit fells a tree
    end
end

local UObjectMT = {}
UObjectMT.__index = function(w, k)
    local rec = rawget(w, "_rec")
    local fn = UE_METHODS[k]
    if fn then
        return function(w2, ...) return fn(w2, rec, ...) end
    end
    if rec.dead then violate("read '" .. tostring(k) .. "' on dead " .. rec.name) return nil end
    return rec.props[k]
end

local function wrap(rec) return setmetatable({ _rec = rec }, UObjectMT) end
local function newRec(name, props)
    return { name = name, dead = false, props = props or {} }
end

-- Faithful UE4SS TArray: 1-based; [0] throws; OOB read auto-grows.
local function makeTArray(elems)
    local t = { _n = #elems }
    for i, e in ipairs(elems) do t[i] = e end
    return setmetatable(t, {
        __index = function(self, k)
            if k == "GetArrayNum" then
                local s = self
                return function() return rawget(s, "_n") end
            end
            if type(k) == "number" then
                if k < 1 then error("TArray index out of range.") end
                local n = rawget(self, "_n")
                if k > n then
                    for j = n + 1, k do
                        rawset(self, j, { Guid = { A = 0, B = 0, C = 0, D = 0 } })
                    end
                    rawset(self, "_n", k)
                    GROWN.count = GROWN.count + 1
                end
                return rawget(self, k)
            end
            return rawget(self, k)
        end,
    })
end

local function makeParam(v)
    return { get = function() return v end }
end

local function fname(s) return { ToString = function() return s end } end

-- ---------------------------------------------------------------- world
local HOOKS = {}
local FINDALL, FINDFIRST = {}, {}

_G.RegisterHook = function(path, cb) HOOKS[path] = cb return true end
_G.NotifyOnNewObject = function(path, cb) return true end
_G.FindAllOf = function(cls) return FINDALL[cls] or {} end
_G.FindFirstOf = function(cls) return FINDFIRST[cls] end
local tickFn
_G.LoopAsync = function(ms, fn) tickFn = fn return true end
_G.ExecuteWithDelay = function(ms, fn) return true end
_G.ExecuteInGameThread = function(fn) fn() end

local PLAYER_LOC = { X = 1000, Y = 1000, Z = 100 }

local pcRec, pawnRec, shooterRec, weaponRec, netRec, gsRec, playerStateRec

local function buildWorld()
    weaponRec = newRec("BP_Pickaxe_C_0", {})
    weaponRec.fullname = "/Game/Weapons/BP_Pickaxe.BP_Pickaxe_C"
    local weaponClassRec = newRec("BP_Pickaxe_C", {})
    weaponClassRec.fullname = "/Game/Weapons/BP_Pickaxe.BP_Pickaxe_C"
    weaponRec.classObj = wrap(weaponClassRec)

    shooterRec = newRec("ShooterComp_0", {})
    shooterRec.weapon = wrap(weaponRec)

    pawnRec = newRec("PalPlayerChar_0", {})
    pawnRec.isA = { ["/Script/Pal.PalPlayerCharacter"] = true }
    pawnRec.loc = PLAYER_LOC
    pawnRec.props.ShooterComponent = wrap(shooterRec)

    playerStateRec = newRec("PalPlayerState_0", {})
    playerStateRec.noSuchFunc = true -- 1.0.4: no GetPlayerUId on PlayerState
    playerStateRec.props.PlayerUId = { A = 7, B = 7, C = 7, D = 7 }

    pcRec = newRec("PalPlayerController_0", {})
    pcRec.props.Pawn = wrap(pawnRec)
    pcRec.props.PlayerState = wrap(playerStateRec)
    pcRec.uid = { A = 7, B = 7, C = 7, D = 7 }

    netRec = newRec("NetMapObjectComp", {})
    gsRec = newRec("GameStateInGame", {})

    package.preload["UEHelpers"] = function()
        return {
            GetPlayerController = function(self) return wrap(pcRec) end,
        }
    end

    FINDFIRST["PalPlayerController"] = wrap(pcRec)
    FINDFIRST["PalGameStateInGame"] = wrap(gsRec)
end

local rockSeq = 0
local function makeRock(x, y, z, hp)
    rockSeq = rockSeq + 1
    local guid = { A = 1000 + rockSeq, B = 0, C = 0, D = 0 }
    local rec = newRec("RockModel_" .. rockSeq, {
        DamagableType = 0,
        InstanceId = guid,
        InitialTransformCache = { Translation = { X = x, Y = y, Z = z } },
        Hp = { CurrentValue = hp or 200, MaxValue = 1000 },
    })
    rec.fullname = "RockModel_" .. rockSeq
    ROCKS_BY_GUID[guid.A .. ":" .. guid.B .. ":" .. guid.C .. ":" .. guid.D] = rec
    return rec
end

local treeSeq = 0
local function makeTree(x, y, z, foliageType, outerName)
    treeSeq = treeSeq + 1
    local guid = { A = 2000 + treeSeq, B = 0, C = 0, D = 0 }
    local outerRec = newRec(outerName or "FoliageGrid_A", {})
    outerRec.fullname = outerName or "/Game/Foliage/Grid_A"
    local rec = newRec("TreeInst_" .. treeSeq, {
        InstanceId = { Guid = guid },
        WorldTransformCache = { Translation = { X = x, Y = y, Z = z } },
        FoliageTypeId = fname(foliageType or "Tree_Oak"),
        InstanceState = 0,
    })
    rec.outer = wrap(outerRec)
    rec.fullname = "TreeInst_" .. treeSeq
    TREES_BY_GUID[guid.A .. ":" .. guid.B .. ":" .. guid.C .. ":" .. guid.D] = rec
    return rec
end

-- ---------------------------------------------------------------- load
buildWorld()
local chunk, lerr = loadfile(TARGET)
assert(chunk, "loadfile failed: " .. tostring(lerr))
local mod = chunk()
assert(type(mod) == "table", "mod must return a table")
assert(tickFn, "scheduler did not start (LoopAsync not called)")

local HOOK_MAP = "/Script/Pal.PalNetworkMapObjectComponent:RequestDamageMapObject_ToServer"
local HOOK_FOL = "/Script/Pal.PalNetworkMapObjectComponent:RequestDamageFoliage_ToServer"
local HOOK_DRP = "/Script/Pal.PalMapObjectDropItem:OnProceedTimerMovementActive"
local HOOK_CHT = "/Script/Pal.PalUIChat:OnReceivedChat"
assert(HOOKS[HOOK_MAP], "map hook missing")
assert(HOOKS[HOOK_FOL], "foliage hook missing")
assert(HOOKS[HOOK_DRP], "drop hook missing")
assert(HOOKS[HOOK_CHT], "chat hook missing")

local function runTicks(n)
    for _ = 1, n do tickFn() end
end
local function runUntilIdle(maxTicks)
    for _ = 1, (maxTicks or 20000) do
        tickFn()
        if mod.Scans.trees.phase == "idle" and mod.Scans.rocks.phase == "idle" then return true end
    end
    return false
end

local function checkGridInvariants(grid, tag)
    local attached, flatN = 0, #grid.flat
    local seen = {}
    for i = 1, flatN do
        local e = grid.flat[i]
        -- Old mod revisions have no `attached` flag (nil counts as attached).
        if e.attached ~= false then
            attached = attached + 1
            if e.key then
                check(grid.byGuid[e.key] == e, tag .. ": byGuid mismatch @" .. i)
                check(not seen[e.key], tag .. ": duplicate guid in flat: " .. e.key)
                seen[e.key] = true
            end
            if grid.byObj[e.obj] ~= nil then
                check(grid.byObj[e.obj] == e, tag .. ": byObj mismatch @" .. i)
            end
            local list = grid.cells[e.cellKey]
            local found = false
            if list then for j = 1, #list do if list[j] == e then found = true break end end end
            check(found, tag .. ": cell list mismatch @" .. i)
        end
    end
    check(grid.count == attached, tag .. ": count=" .. grid.count .. " attached=" .. attached)
end

local function resetRpc() RPC.map = {} RPC.foliage = {} end

local function mapHit(rockRec, opts)
    opts = opts or {}
    local g = rockRec.props.InstanceId
    local inst = { A = g.A, B = g.B, C = g.C, D = g.D }
    local t = rockRec.props.InitialTransformCache.Translation
    local info = {
        Attacker = (opts.attacker ~= nil) and opts.attacker or wrap(pawnRec),
        AttackStaticItemID = (opts.itemId ~= nil) and opts.itemId or "Stone_Pickaxe_T2",
        HitLocation = opts.hitLoc or { X = t.X, Y = t.Y, Z = t.Z },
        WeaponType = opts.weaponType or 7,
        NativeDamageValue = 10,
        BasePower = 10,
    }
    if opts.attacker == false then info.Attacker = nil end
    local okH, errH = pcall(HOOKS[HOOK_MAP], makeParam(wrap(netRec)), makeParam(inst), makeParam(info))
    check(okH, "map hook raised: " .. tostring(errH))
    return inst, info
end

local function folHit(treeRec, opts)
    opts = opts or {}
    local g = treeRec.props.InstanceId.Guid
    local ids = makeTArray({ { Guid = { A = g.A, B = g.B, C = g.C, D = g.D } } })
    local t = treeRec.props.WorldTransformCache.Translation
    local info = {
        Attacker = wrap(pawnRec),
        AttackStaticItemID = (opts.itemId ~= nil) and opts.itemId or "Stone_Axe_T1",
        HitLocation = { X = t.X, Y = t.Y, Z = t.Z },
        WeaponType = 7,
    }
    local okH, errH = pcall(HOOKS[HOOK_FOL], makeParam(wrap(netRec)), makeParam({ X = 0, Y = 0, Z = 0 }),
        makeParam(fname("OakModel")), makeParam(ids), makeParam(info))
    check(okH, "foliage hook raised: " .. tostring(errH))
    return ids
end

local function rpcGuidSet(list)
    local s, dup = {}, 0
    for _, c in ipairs(list) do
        local k = c.A .. ":" .. c.B .. ":" .. c.C .. ":" .. c.D
        if s[k] then dup = dup + 1 else s[k] = true end
    end
    return s, dup
end

print("== A. scan rocks+trees (r7 dies between FindAllOf and its slice) ==")
local r1 = makeRock(1000, 1000, 100)
local r2 = makeRock(1500, 1000, 100)
local r3 = makeRock(1000, 1500, 100)
local r4 = makeRock(3000, 3000, 100)
local r5 = makeRock(6000, 1000, 100)
local r6 = makeRock(50000, 50000, 100)
local r7 = makeRock(1000, 1100, 100)
FINDALL["PalMapObjectModel"] = { wrap(r1), wrap(r2), wrap(r3), wrap(r4), wrap(r5), wrap(r6), wrap(r7) }
local t1 = makeTree(1000, 1000, 100)
local t2 = makeTree(1200, 1000, 100)
local t3 = makeTree(1000, 1300, 100, "Mushroom_Glow")
local t4 = makeTree(90000, 90000, 100)
FINDALL["PalFoliageInstance"] = { wrap(t1), wrap(t2), wrap(t3), wrap(t4) }

runTicks(1)   -- lists picked up, slices not processed yet
r7.dead = true -- streaming/GC race: dies before its slice runs
r7.props.Hp.CurrentValue = 0
check(runUntilIdle(), "scans did not finish")
check(mod.Scans.rocks.grid.count == 6, "rocks cached=" .. mod.Scans.rocks.grid.count .. " expected 6")
check(mod.Scans.trees.grid.count == 4, "trees cached=" .. mod.Scans.trees.grid.count .. " expected 4")
checkGridInvariants(mod.Scans.rocks.grid, "rocks")
checkGridInvariants(mod.Scans.trees.grid, "trees")
check(#VIOLATIONS == 0, "violations during scan: " .. #VIOLATIONS)

print("== C. pickaxe hit #1 (expect r2,r3,r4,r5; r1 excluded, r6 far) ==")
resetRpc()
local inst = mapHit(r1)
check(#RPC.map == 4, "AoE RPCs=" .. #RPC.map .. " expected 4")
local _, dupC = rpcGuidSet(RPC.map)
check(dupC == 0, "duplicate RPC Guids in hit#1")
check(inst.A == r1.props.InstanceId.A, "inst Guid not restored")
check(r2.dead and r3.dead and r4.dead and r5.dead, "server sim should kill r2..r5")
check(not r6.dead, "far rock must survive")
check(#VIOLATIONS == 0, "violations during hit#1: " .. #VIOLATIONS)

print("== D. hit #2 over corpses (prune, don't touch) ==")
resetRpc()
mapHit(r1)
check(#RPC.map == 0, "expected 0 RPCs (neighbours dead), got " .. #RPC.map)
check(#VIOLATIONS == 0, "violations during hit#2: " .. #VIOLATIONS)
for i, v in ipairs(VIOLATIONS) do if i <= 10 then print("   VIOLATION: " .. v) end end
check(mod.Scans.rocks.grid.count == 2, "after prune count=" .. mod.Scans.rocks.grid.count .. " expected 2 (r1+r6)")
checkGridInvariants(mod.Scans.rocks.grid, "rocks-after-prune")

print("== E. rescan with FRESH wrappers (wrapper instability) ==")
FINDALL["PalMapObjectModel"] = { wrap(r1), wrap(r6) }
FINDALL["PalFoliageInstance"] = { wrap(t1), wrap(t2), wrap(t3), wrap(t4) }
mod.Scans.rocks.nextFind = 0
mod.Scans.trees.nextFind = 0
check(runUntilIdle(), "rescan did not finish")
check(mod.Scans.rocks.grid.count == 2, "rocks after rescan=" .. mod.Scans.rocks.grid.count .. " expected 2")
check(mod.Scans.trees.grid.count == 4, "trees after rescan=" .. mod.Scans.trees.grid.count .. " expected 4")
checkGridInvariants(mod.Scans.rocks.grid, "rocks-rescan")
check(#VIOLATIONS == 0, "violations during rescan: " .. #VIOLATIONS)

print("== F. respawn: brand-new rocks r8,r9 ==")
local r8 = makeRock(1400, 1000, 100)
local r9 = makeRock(1000, 1400, 100)
FINDALL["PalMapObjectModel"] = { wrap(r1), wrap(r6), wrap(r8), wrap(r9) }
mod.Scans.rocks.nextFind = 0
check(runUntilIdle(), "respawn scan did not finish")
check(mod.Scans.rocks.grid.count == 4, "rocks=" .. mod.Scans.rocks.grid.count .. " expected 4")
resetRpc()
mapHit(r1)
check(#RPC.map == 2, "AoE RPCs after respawn=" .. #RPC.map .. " expected 2 (r8,r9)")
check(#VIOLATIONS == 0, "violations: " .. #VIOLATIONS)

print("== G. axe hit on tree t1 (expect t2 + mushroom t3) ==")
resetRpc()
local grownBefore = GROWN.count
local ids = folHit(t1)
check(#RPC.foliage == 2, "foliage RPCs=" .. #RPC.foliage .. " expected 2")
local g1 = ids[1].Guid
check(g1.A == t1.props.InstanceId.Guid.A, "foliage Guid not restored")
check(GROWN.count == grownBefore, "TArray must not grow on valid read")
check(t2.dead and t3.dead, "server sim should fell t2,t3")
check(#VIOLATIONS == 0, "violations: " .. #VIOLATIONS)

print("== H. empty InstanceIds must no-op WITHOUT growing the array ==")
resetRpc()
local emptyIds = makeTArray({})
local infoH = { Attacker = wrap(pawnRec), AttackStaticItemID = "Stone_Axe_T1",
    HitLocation = { X = 1, Y = 1, Z = 1 }, WeaponType = 7 }
local nBefore = emptyIds:GetArrayNum()
local okH, errH = pcall(HOOKS[HOOK_FOL], makeParam(wrap(netRec)), makeParam({}),
    makeParam(fname("M")), makeParam(emptyIds), makeParam(infoH))
check(okH, "foliage hook raised on empty ids: " .. tostring(errH))
check(#RPC.foliage == 0, "empty ids must send nothing, sent " .. #RPC.foliage)
check(emptyIds:GetArrayNum() == nBefore, "empty TArray was grown/corrupted!")
check(#VIOLATIONS == 0, "violations: " .. #VIOLATIONS)

print("== I. chat !aoeoff / !aoeon ==")
local function chat(text, asString)
    local msgVal = asString and text or { ToString = function() return text end }
    local okC, errC = pcall(HOOKS[HOOK_CHT], makeParam({}), makeParam({ Message = msgVal }))
    check(okC, "chat hook raised: " .. tostring(errC))
end
chat("!aoeoff")
check(mod.State.enabled == false, "mod should be disabled")
check(#(gsRec.toasts or {}) >= 1, "disable toast missing")
resetRpc()
mapHit(r1)
check(#RPC.map == 0, "disabled mod must not send")
chat("!aoeon", true) -- plain-string Message variant
check(mod.State.enabled == true, "mod should be enabled")
if not STRICT and not mod.State.enabled then
    -- Old revisions get stuck disabled here (chat-hook crash cascade);
    -- force-enable so later scenarios still diagnose the old code paths.
    print("   (non-strict: force re-enabling mod after chat cascade)")
    mod.State.enabled = true
end
check(#VIOLATIONS == 0, "violations: " .. #VIOLATIONS)

print("== J. autoloot ==")
mod.Config.EnableAutoLoot = true
local function makeDrop(x, y, z, canPickup)
    local concRec = newRec("conc", {})
    if not canPickup then concRec.noSuchFunc = true end
    local modelRec = newRec("model", {})
    modelRec.conc = wrap(concRec)
    local dropRec = newRec("drop", {})
    dropRec.loc = { X = x, Y = y, Z = z }
    dropRec.model = wrap(modelRec)
    return wrap(dropRec), concRec
end
local nearDrop, nearConc = makeDrop(1500, 1000, 100, true)
local okD1, errD1 = pcall(HOOKS[HOOK_DRP], makeParam(nearDrop))
check(okD1, "drop hook raised (near): " .. tostring(errD1))
check(nearConc.pickups == 1 and nearConc.lastPickupArg == true, "near drop must be picked up")
local farDrop, farConc = makeDrop(1000000, 1000, 100, true)
pcall(HOOKS[HOOK_DRP], makeParam(farDrop))
check((farConc.pickups or 0) == 0, "far drop must NOT be picked up")
local badDrop, badConc = makeDrop(1500, 1000, 100, false)
local okD3, errD3 = pcall(HOOKS[HOOK_DRP], makeParam(badDrop))
check(okD3, "drop hook raised (no-RequestPickup conc): " .. tostring(errD3))
check((badConc.pickups or 0) == 0, "conc without RequestPickup must not pick up")
check(#VIOLATIONS == 0, "violations: " .. #VIOLATIONS)
mod.Config.EnableAutoLoot = false

print("== K0. fresh rocks + mid-rescan hit (dup detection) ==")
local r10 = makeRock(1100, 1000, 100, 200)
local r11 = makeRock(1000, 1200, 100, 100000) -- tanky: survives several 500-hits
FINDALL["PalMapObjectModel"] = { wrap(r1), wrap(r6), wrap(r10), wrap(r11) }
mod.Scans.rocks.nextFind = 0
runTicks(1) -- scan starts (gen++)
runTicks(1) -- slices processed (all objects, budgets are huge)
resetRpc()
mapHit(r1) -- r8,r9 corpses pruned; r10,r11 live
check(#RPC.map == 2, "mid-rescan RPCs=" .. #RPC.map .. " expected 2 (r10,r11)")
local _, dupK = rpcGuidSet(RPC.map)
check(dupK == 0, "duplicate RPC Guids mid-rescan")
check(r10.dead and not r11.dead, "r10 dead, r11 alive expected")
check(runUntilIdle(), "K0 sweep did not finish")
check(mod.Scans.rocks.grid.count == 4, "rocks=" .. mod.Scans.rocks.grid.count .. " expected 4 (r1,r6,r10-corpse,r11)")
checkGridInvariants(mod.Scans.rocks.grid, "rocks-K0")
check(#VIOLATIONS == 0, "violations: " .. #VIOLATIONS)

print("== K1..K5 weapon detection ==")
resetRpc()
mapHit(r1, { itemId = "Stone_Axe_T1" })
check(#RPC.map == 0, "axe must NOT trigger ore AoE")
resetRpc()
mapHit(r1, { itemId = "", weaponType = 20 }) -- laser, empty id
check(#RPC.map == 1, "laser must trigger ore AoE (r11), got " .. #RPC.map)
shooterRec.weapon = wrap(weaponRec) -- BP_Pickaxe in hands
resetRpc()
mapHit(r1, { itemId = "", weaponType = 7 }) -- GetHasWeapon fallback
check(#RPC.map == 1, "GetHasWeapon fallback must trigger (r11), got " .. #RPC.map)
local axeWeaponRec = newRec("BP_Axe_C_0", {})
axeWeaponRec.fullname = "/Game/Weapons/BP_Axe.BP_Axe_C"
shooterRec.weapon = wrap(axeWeaponRec)
resetRpc()
mapHit(r1, { itemId = "None", weaponType = 7 })
check(#RPC.map == 0, "axe in hands must NOT trigger ore AoE, got " .. #RPC.map)
shooterRec.weapon = nil
resetRpc()
mapHit(r1, { itemId = "", weaponType = 7 })
check(#RPC.map == 0, "empty weapon info must not trigger")
check(#VIOLATIONS == 0, "violations: " .. #VIOLATIONS)
shooterRec.weapon = wrap(weaponRec)

print("== L. attacker variants ==")
local palRec = newRec("Pal_0", {})
palRec.isA = {}
resetRpc()
mapHit(r1, { attacker = wrap(palRec), hitLoc = { X = 99999, Y = 99999, Z = 0 } })
check(#RPC.map == 0, "far pal attacker must not trigger")
resetRpc()
mapHit(r1, { attacker = false, hitLoc = { X = PLAYER_LOC.X + 10, Y = PLAYER_LOC.Y, Z = PLAYER_LOC.Z } })
check(#RPC.map == 1, "nil attacker near player must trigger via fallback (r11), got " .. #RPC.map)
check(#VIOLATIONS == 0, "violations: " .. #VIOLATIONS)

print("== M. pawn respawn safety ==")
pawnRec.dead = true
local newPawnRec = newRec("PalPlayerChar_1", {})
newPawnRec.isA = { ["/Script/Pal.PalPlayerCharacter"] = true }
newPawnRec.loc = PLAYER_LOC
newPawnRec.props.ShooterComponent = wrap(shooterRec)
pcRec.props.Pawn = wrap(newPawnRec)
resetRpc()
mapHit(r1, { attacker = wrap(newPawnRec) })
check(#VIOLATIONS == 0, "violations after respawn: " .. #VIOLATIONS)

print("----------------------------------------")
print("VIOLATIONS: " .. #VIOLATIONS)
for i, v in ipairs(VIOLATIONS) do if i <= 15 then print("  " .. i .. ". " .. v) end end
if #VIOLATIONS > 15 then print("  ...") end
print("TArray auto-grows: " .. GROWN.count)
if STRICT then
    if #failures > 0 then
        print("FAILURES: " .. #failures)
        for _, f in ipairs(failures) do print("  FAIL: " .. f) end
        os.exit(1)
    else
        print("ALL CHECKS PASSED")
    end
else
    print("(non-strict report mode)")
end
