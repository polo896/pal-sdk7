-- ============================================================================
-- AutoIncubatorManager + Hatch Report UI - By Wol4ara896
-- ============================================================================
local VERSION = "2.3.0-autobreed"

local CONFIG = {
    CommandIn  = "!eggin",
    CommandOut = "!eggout",
    CommandAuto = "!autobreed",
    MaxMovesPerRun = 200,
    AutoBreedMaxMoves = 100,
    AutoBreedInterval = 5.0,
    CommandDedupSeconds = 0.35,
    LogPrefix = "[PalEggAutoFiller] ",
    EnableUI  = true,  -- true = GUI on, false = GUI off
}

local CLASS = {
    Utility = "/Script/Pal.Default__PalUtility",
    Hatching = "/Script/Pal.PalMapObjectHatchingEggModel",
    HatchingBase = "/Script/Pal.PalMapObjectHatchingEggModelBase",
    MultiHatching = "/Script/Pal.PalMapObjectMultiHatchingEggModel",
    MultiHatchingBreed = "/Script/Pal.PalMapObjectMultiHatchingEggWithBreedModel",
    BreedFarm = "/Script/Pal.PalMapObjectBreedFarmModel",
}

local INDICATOR_PICKUP = 14

local reportUI = nil
if CONFIG.EnableUI then
    pcall(function() reportUI = require("egg_report_ui") end)
end

local function call(fn, ...)
    local ok, r = pcall(fn, ...)
    if ok then return r end
    return nil
end

local function isUObject(o)
    if not o or type(o) ~= "userdata" then return false end
    local ok, isval = pcall(function() return o:IsValid() end)
    return ok and isval == true
end

local function unwrap(o)
    if not o then return nil end
    local ok, res = pcall(function() return o:get() end)
    if ok and res ~= nil then return res end
    return o
end

local function asString(v)
    if v == nil then return nil end
    if type(v) == "string" then return v end
    local s = call(function() return v:ToString() end)
    if type(s) == "string" then return s end
    return call(function() return tostring(v) end)
end

local function isA(o, cls)
    return isUObject(o) and call(function() return o:IsA(cls) end) == true
end

local function guidToTable(g)
    if not g then return nil end
    local function p(n, f) return tonumber(call(function() return g[n] end)) or call(function() return g[f] end) end
    local a, b, c, d = p("A", "X"), p("B", "Y"), p("C", "Z"), p("D", "W")
    if a and b and c and d then return { A = a, B = b, C = c, D = d } end
    return nil
end

local function guidString(g)
    local t = guidToTable(g)
    if not t then return nil end
    return string.format("%08X-%08X-%08X-%08X", t.A, t.B, t.C, t.D)
end

local function guidEquals(a, b)
    return a and b and a.A == b.A and a.B == b.B and a.C == b.C and a.D == b.D
end

local function getArrayCount(arr)
    if not arr then return 0 end
    return tonumber(call(function() return #arr end))
        or tonumber(call(function() return arr:GetArrayNum() end))
        or tonumber(call(function() return arr:Num() end))
        or 0
end

local function getArrayElement(arr, i)
    if not arr then return nil end
    local elem = call(function() return arr[i] end)
    if elem == nil then
        elem = call(function() return arr:Get(i - 1) end)
    end
    return elem
end

local UtilityCDO = nil
local function getUtility()
    if not isUObject(UtilityCDO) then UtilityCDO = call(function() return StaticFindObject(CLASS.Utility) end) end
    return UtilityCDO
end

local function getMapObjectManager(world, utility)
    local mgr = nil
    if isUObject(utility) and isUObject(world) then
        mgr = call(function() return utility:GetMapObjectManager(world) end)
    end
    if not isUObject(mgr) then
        mgr = call(function() return FindFirstOf("PalMapObjectManager") end)
    end
    return mgr
end

local function isEggStaticId(id)
    if type(id) ~= "string" then return false end
    for _, p in ipairs({"Egg_", "LargeEgg_", "HugeEgg_", "SpecialEgg_", "PalEgg_"}) do
        if id:sub(1, #p) == p then return true end
    end
    return false
end

local function forEachSlot(container, fn)
    if not isUObject(container) then return end
    local slots = call(function() return container.ItemSlotArray end)
    if slots then
        local count = getArrayCount(slots)
        for i = 1, count do
            local slot = getArrayElement(slots, i)
            if isUObject(slot) then fn(slot) end
        end
    end
end

local function slotIsEmpty(slot)
    if not isUObject(slot) then return true end
    local count = tonumber(call(function() return slot.StackCount end))
    if count ~= nil then return count <= 0 end
    return call(function() return slot:IsEmpty() end) == true
end

local function slotStaticId(slot)
    local id
    pcall(function() id = asString(slot:GetItemId().StaticId) end)
    if id then return id end
    pcall(function() id = asString(slot.ItemId.StaticId) end)
    return id
end

local function slotIndex(slot)
    local idx = tonumber(call(function() return slot.SlotIndex end))
    if idx ~= nil then return idx end
    return tonumber(call(function() return slot:GetSlotId().SlotIndex end))
end

local function countEggsInContainer(container)
    if not isUObject(container) then return 0 end
    local total = 0
    forEachSlot(container, function(slot)
        local sid = slotStaticId(slot)
        if sid and isEggStaticId(sid) then
            local count = tonumber(call(function() return slot.StackCount end))
                or tonumber(call(function() return slot:GetStackCount() end))
                or 1
            if count <= 0 then count = 1 end
            total = total + count
        end
    end)
    return total
end

local function collectEggSlotsFromContainer(container, containerId, out)
    if not isUObject(container) or not containerId then return end
    forEachSlot(container, function(slot)
        local sid = slotStaticId(slot)
        if sid and isEggStaticId(sid) then
            local idx = slotIndex(slot)
            if idx then out[#out + 1] = { containerId = containerId, slotIndex = idx } end
        end
    end)
end

local function getInventoryContainer(playerState, utility, world)
    local inv = isUObject(playerState) and call(function() return playerState:GetInventoryData() end)
    local commonId = isUObject(inv) and call(function() return inv.MyInventoryInfo.CommonContainerId end)
    if not commonId or not isUObject(utility) or not isUObject(world) then return nil end
    local manager = call(function() return utility:GetItemContainerManager(world) end)
    return isUObject(manager) and call(function() return manager:GetContainer(commonId) end) or nil
end

local function getInventoryContainerAndId(playerState, utility, world)
    local inv = isUObject(playerState) and call(function() return playerState:GetInventoryData() end)
    local commonId = isUObject(inv) and call(function() return inv.MyInventoryInfo.CommonContainerId end)
    if not commonId or not isUObject(utility) or not isUObject(world) then return nil, nil end
    local manager = call(function() return utility:GetItemContainerManager(world) end)
    local container = isUObject(manager) and call(function() return manager:GetContainer(commonId) end) or nil
    local g = guidToTable(commonId.ID)
    local cId = g and { ID = g } or nil
    return container, cId
end

local function isIncubatorModel(o)
    if not isUObject(o) then return false end
    if isA(o, CLASS.Hatching) or isA(o, CLASS.MultiHatching) or isA(o, CLASS.MultiHatchingBreed) or isA(o, CLASS.HatchingBase) then
        return true
    end
    local cn = asString(call(function() return o:GetClass():GetFName() end)) or ""
    return cn:find("HatchingEgg", 1, true) ~= nil
end

local function isMultiIncubator(o)
    if not isUObject(o) then return false end
    if isA(o, CLASS.MultiHatching) or isA(o, CLASS.MultiHatchingBreed) or isA(o, CLASS.HatchingBase) then
        return true
    end
    local cn = asString(call(function() return o:GetClass():GetFName() end)) or ""
    return cn:find("MultiHatching", 1, true) ~= nil
end

local function isBreedFarmModel(o)
    if not isUObject(o) then return false end
    if isA(o, CLASS.BreedFarm) then return true end
    local cn = asString(call(function() return o:GetClass():GetFName() end)) or ""
    return cn:find("BreedFarm", 1, true) ~= nil
end

local function collectBaseObjects(baseModel, mapObjectManager)
    local incubators, breedFarms, chests = {}, {}, {}
    local seen = {}

    local function processConcrete(c)
        if not isUObject(c) then return end
        local addr = call(function() return c:GetAddress() end) or tostring(c)
        if seen[addr] then return end
        seen[addr] = true

        if isIncubatorModel(c) then
            incubators[#incubators + 1] = c
        elseif isBreedFarmModel(c) then
            breedFarms[#breedFarms + 1] = c
        elseif isUObject(call(function() return c:GetItemContainerModule() end)) then
            chests[#chests + 1] = c
        end
    end

    local collection = isUObject(baseModel) and call(function() return baseModel.MapObjectCollection end)
    local repArray = isUObject(collection) and call(function() return collection.MapObjectInstanceIdRepInfoArray end)
    local items = repArray and call(function() return repArray.Items end)
    local count = getArrayCount(items)

    if count > 0 and isUObject(mapObjectManager) then
        for i = 1, count do
            local item = getArrayElement(items, i)
            local instId = item and call(function() return item.InstanceId end)
            if instId then
                local model = call(function() return mapObjectManager:FindModel(instId) end)
                if isUObject(model) then
                    local c = call(function() return model:GetConcreteModel(false) end)
                    processConcrete(c)
                else
                    local c = call(function() return mapObjectManager:FindConcreteModel(instId) end)
                    processConcrete(c)
                end
            end
        end
    end

    if #incubators == 0 and #breedFarms == 0 and #chests == 0 then
        local baseId = guidToTable(call(function() return baseModel:GetId() end))
        for _, cls in ipairs({"PalMapObjectHatchingEggModel", "PalMapObjectMultiHatchingEggModel", "PalMapObjectMultiHatchingEggWithBreedModel", "PalMapObjectBreedFarmModel"}) do
            for _, m in ipairs(call(function() return FindAllOf(cls) end) or {}) do
                if isUObject(m) and guidEquals(guidToTable(call(function() return m:GetBaseCampIdBelongTo() end)), baseId) then
                    processConcrete(m)
                end
            end
        end
    end

    return incubators, breedFarms, chests
end

local function getInsideBaseCampModel(controller, world)
    local pawn = isUObject(controller) and (call(function() return controller:GetPawn() end) or call(function() return controller.Pawn end))
    local loc = isUObject(pawn) and (call(function() return pawn:K2_GetActorLocation() end) or call(function() return pawn:GetActorLocation() end))
    if loc then loc = { X = loc.X, Y = loc.Y, Z = loc.Z } end

    for _, comp in ipairs(call(function() return FindAllOf("PalInsideBaseCampCheckComponent") end) or {}) do
        if isUObject(comp) and call(function() return comp:IsInsideBaseCamp() end) == true then
            local model = call(function() return comp:GetInsideBaseCampModel() end)
            if isUObject(model) then return model end
        end
    end

    local utility = getUtility()
    if loc and isUObject(utility) and isUObject(world) then
        local manager = call(function() return utility:GetBaseCampManager(world) end)
        local model = isUObject(manager) and call(function() return manager:GetInRangedBaseCamp(loc, 3000.0) end)
        if isUObject(model) then return model end
    end

    local best, bestDist = nil, math.huge
    for _, m in ipairs(call(function() return FindAllOf("PalBaseCampModel") end) or {}) do
        if isUObject(m) and loc then
            local pos = call(function()
                local t = m:GetTransform()
                return t and t.Translation
            end)
            if pos then
                local dist = math.sqrt((loc.X - pos.X)^2 + (loc.Y - pos.Y)^2 + (loc.Z - pos.Z)^2)
                local range = tonumber(call(function() return m:GetRange() end)) or 2500
                if dist < bestDist and dist <= range + 1000 then best, bestDist = m, dist end
            end
        end
    end
    return best
end

local function getModelContainer(model)
    local module_ = isUObject(model) and call(function() return model:GetItemContainerModule() end)
    local container = isUObject(module_) and (call(function() return module_:GetContainer() end) or call(function() return module_.TargetContainer end))
    return container, module_
end

local function getModelContainerId(model, container, module_)
    if not module_ and isUObject(model) then container, module_ = getModelContainer(model) end
    local id = isUObject(module_) and call(function() return module_:GetContainerId() end)
    id = id or (isUObject(container) and (call(function() return container:GetId() end) or call(function() return container.ID end)))
    local g = id and guidToTable(id.ID)
    return g and { ID = g } or nil
end

local function sendNotice(text, ctx)
    print(CONFIG.LogPrefix .. text)
    local gs = call(function() return FindFirstOf("PalGameStateInGame") end)
    if isUObject(gs) and call(function() gs:BroadcastChatMessage({Category = 1, Sender = "EggManager", SenderPlayerUId = {}, Message = text, ReceiverPlayerUIds = ctx.playerUId and {ctx.playerUId} or {}, MessageId = "", MessageArgKeys = {}, MessageArgValues = {}}); return true end) then return end
    if isUObject(ctx.playerState) and isUObject(ctx.utility) and isUObject(ctx.world) and ctx.playerUId then
        if call(function() ctx.utility:SendSystemToPlayerChat(ctx.world, text, {ctx.playerUId}); return true end) then return end
        call(function() ctx.playerState:EnterChat(FText(text), 1) end)
    end
end

local function getInstanceId(inc)
    if not isUObject(inc) then return nil end
    local ok, id = pcall(function() return inc:GetInstanceId() end)
    if ok and id and type(id) == "userdata" then return id end
    ok, id = pcall(function() return inc.InstanceId end)
    if ok and id and type(id) == "userdata" then return id end
    return nil
end

local function extractPalInfo(saveParam)
    if not saveParam then return nil end
    local charId = nil
    pcall(function()
        local cid = saveParam.CharacterID
        if cid then charId = asString(cid) end
    end)
    if not charId or charId == "" or charId == "None" then
        pcall(function()
            local cid = saveParam.CharacterId
            if cid then charId = asString(cid) end
        end)
    end
    if not charId or charId == "" or charId == "None" then return nil end

    local info = {}
    info.characterId = charId
    info.level = tonumber(call(function() return saveParam.Level end)) or 1
    info.rank = tonumber(call(function() return saveParam.Rank end)) or 0
    info.isRarePal = (call(function() return saveParam.IsRarePal end) == true)
    info.gender = tonumber(call(function() return saveParam.Gender end)) or 0
    info.talentHP = tonumber(call(function() return saveParam.Talent_HP end)) or 0
    info.talentMelee = tonumber(call(function() return saveParam.Talent_Melee end)) or 0
    info.talentShot = tonumber(call(function() return saveParam.Talent_Shot end)) or 0
    info.talentDefense = tonumber(call(function() return saveParam.Talent_Defense end)) or 0
    info.rankHP = tonumber(call(function() return saveParam.Rank_HP end)) or 0
    info.rankAttack = tonumber(call(function() return saveParam.Rank_Attack end)) or 0
    info.rankDefence = tonumber(call(function() return saveParam.Rank_Defence end)) or 0
    info.rankCraftSpeed = tonumber(call(function() return saveParam.Rank_CraftSpeed end)) or 0

    info.passiveSkills = {}
    local skills = call(function() return saveParam.PassiveSkillList end)
    if skills then
        local skCount = getArrayCount(skills)
        for s = 1, skCount do
            local sName = getArrayElement(skills, s)
            local sStr = sName and asString(sName)
            if sStr and sStr ~= "" and sStr ~= "None" then
                info.passiveSkills[#info.passiveSkills + 1] = sStr
            end
        end
    end

    info.craftSpeed = tonumber(call(function() return saveParam.CraftSpeed end)) or 0

    info.workSuitability = {}
    local craftSpeeds = call(function() return saveParam.CraftSpeeds end)
    if craftSpeeds then
        local csCount = getArrayCount(craftSpeeds)
        for c = 1, csCount do
            local wsInfo = getArrayElement(craftSpeeds, c)
            if wsInfo then
                local workType = call(function() return wsInfo.WorkSuitability end)
                local rank = tonumber(call(function() return wsInfo.Rank end))
                if workType and rank and rank > 0 then
                    local typeStr = asString(workType)
                    if typeStr and typeStr ~= "" and typeStr ~= "None" then
                        info.workSuitability[#info.workSuitability + 1] = { type = typeStr, rank = rank }
                    end
                end
            end
        end
    end

    return info
end

local function readSingleIncubatorInfo(inc)
    if not isUObject(inc) then return nil end
    local sp = call(function() return inc.HatchedCharacterSaveParameter end)
    return extractPalInfo(sp)
end

local function readMultiIncubatorInfos(inc)
    if not isUObject(inc) then return {} end
    local infos = {}

    local repInfoArray = call(function() return inc.RepInfoArray end)
    local repItems = repInfoArray and call(function() return repInfoArray.Items end)
    if repItems then
        local repCount = getArrayCount(repItems)
        for i = 1, repCount do
            local item = getArrayElement(repItems, i)
            if item then
                local sp = call(function() return item.HatchedCharacterSaveParameter end)
                local info = extractPalInfo(sp)
                if info then infos[#infos + 1] = info end
            end
        end
    end

    if #infos == 0 then
        local saveInfoArray = call(function() return inc.TmpSaveInfoArray end)
        if saveInfoArray then
            local saveCount = getArrayCount(saveInfoArray)
            for i = 1, saveCount do
                local saveInfo = getArrayElement(saveInfoArray, i)
                if saveInfo then
                    local sp = call(function() return saveInfo.HatchedCharacterSaveParameter end)
                    local info = extractPalInfo(sp)
                    if info then infos[#infos + 1] = info end
                end
            end
        end
    end

    return infos
end

local function harvestBreedFarms(breedFarms, mapObjectManager, pawn)
    local interactedCount = 0

    for _, farm in ipairs(breedFarms) do
        if isUObject(farm) then
            local eggIds = call(function() return farm.SpawnedEggInstanceIds end)
            local eggCount = getArrayCount(eggIds)
            for i = 1, eggCount do
                local eggGuid = getArrayElement(eggIds, i)
                if eggGuid then
                    local eggModel = isUObject(mapObjectManager) and call(function() return mapObjectManager:FindModel(eggGuid) end)
                    local concreteEgg = isUObject(eggModel) and call(function() return eggModel:GetConcreteModel(false) end)
                    if not isUObject(concreteEgg) and isUObject(mapObjectManager) then
                        concreteEgg = call(function() return mapObjectManager:FindConcreteModel(eggGuid) end)
                    end

                    local interacted = false

                    if isUObject(concreteEgg) and isUObject(pawn) then
                        local ok = call(function()
                            concreteEgg:OnTriggerInteract(pawn, INDICATOR_PICKUP)
                            return true
                        end)
                        if ok then interacted = true end
                    end

                    if isUObject(eggModel) and isUObject(pawn) then
                        local ok = call(function()
                            eggModel:OnTriggerInteract(pawn, INDICATOR_PICKUP)
                            return true
                        end)
                        if ok then interacted = true end
                    end

                    if isUObject(concreteEgg) then
                        pcall(function() concreteEgg:RequestPickup(false) end)
                    end

                    if interacted then
                        interactedCount = interactedCount + 1
                    end
                end
            end
        end
    end
    return interactedCount
end

-- ============================================================================
-- !autobreed : ultra-light farm-only auto collector (no chest scan, no base full scan)
-- ============================================================================
local autoBreedEnabled = false
local autoBreedBusy = false
local autoBreedLastRun = -100
local autoBreedLoopStarted = false

local function getBaseModelLight(pawn, utility, world)
    if not isUObject(pawn) or not isUObject(utility) or not isUObject(world) then return nil end
    local loc = call(function() return pawn:K2_GetActorLocation() end) or call(function() return pawn:GetActorLocation() end)
    if not loc then return nil end
    local locTbl = { X = loc.X, Y = loc.Y, Z = loc.Z }
    local manager = call(function() return utility:GetBaseCampManager(world) end)
    if not isUObject(manager) then return nil end
    local model = call(function() return manager:GetInRangedBaseCamp(locTbl, 3000.0) end)
    return model
end

local function getBreedFarmsForBase(baseId)
    local farms = {}
    local list = call(function() return FindAllOf("PalMapObjectBreedFarmModel") end) or {}
    for i = 1, #list do
        local m = list[i]
        if isUObject(m) then
            local bid = guidToTable(call(function() return m:GetBaseCampIdBelongTo() end))
            if guidEquals(bid, baseId) then farms[#farms + 1] = m end
        end
    end
    return farms
end

local function getIncubatorsForBase(baseId)
    local incubators = {}
    local seen = {}
    local function addFrom(list)
        if not list then return end
        for i = 1, #list do
            local m = list[i]
            if isUObject(m) then
                local bid = guidToTable(call(function() return m:GetBaseCampIdBelongTo() end))
                if guidEquals(bid, baseId) then
                    local addr = call(function() return m:GetAddress() end) or tostring(m)
                    if not seen[addr] then
                        seen[addr] = true
                        incubators[#incubators + 1] = m
                    end
                end
            end
        end
    end
    -- PalMapObjectHatchingEggModelBase is parent for all incubators, single FindAllOf is cheapest
    local baseList = call(function() return FindAllOf("PalMapObjectHatchingEggModelBase") end)
    if baseList and #baseList > 0 then
        addFrom(baseList)
    else
        addFrom(call(function() return FindAllOf("PalMapObjectHatchingEggModel") end))
        addFrom(call(function() return FindAllOf("PalMapObjectMultiHatchingEggModel") end))
        addFrom(call(function() return FindAllOf("PalMapObjectMultiHatchingEggWithBreedModel") end))
    end
    return incubators
end

local function runAutoBreedInternal(controller, world, playerState, playerUId, ctx, silent)
    -- 1) light base detection via location + BaseCampManager (no FindAllOf)
    local pawn = isUObject(controller) and (call(function() return controller:GetPawn() end) or call(function() return controller.Pawn end))
    if not isUObject(pawn) then return 0, 0 end
    local baseModel = getBaseModelLight(pawn, ctx.utility, world)
    if not isUObject(baseModel) then return 0, 0 end
    local baseId = guidToTable(call(function() return baseModel:GetId() end))
    if not baseId then return 0, 0 end

    local mapObjectManager = getMapObjectManager(world, ctx.utility)
    local transmitter = isUObject(ctx.utility) and call(function() return ctx.utility:GetNetworkTransmitter(world) end)
    local networkItem = isUObject(transmitter) and call(function() return transmitter:GetItem() end)
    if not isUObject(networkItem) then return 0, 0 end

    -- 2) breed farms only for this base (single FindAllOf)
    local farms = getBreedFarmsForBase(baseId)
    if #farms == 0 then return 0, 0 end

    local hasFarmEggs = false
    for i = 1, #farms do
        if getArrayCount(call(function() return farms[i].SpawnedEggInstanceIds end)) > 0 then hasFarmEggs = true; break end
    end

    -- 3) inventory eggs only (no chests) - cheap slot scan
    local invCont, invContId = getInventoryContainerAndId(playerState, ctx.utility, world)
    local invEggSlots = {}
    if isUObject(invCont) and invContId then
        collectEggSlotsFromContainer(invCont, invContId, invEggSlots)
    end

    if not hasFarmEggs and #invEggSlots == 0 then return 0, 0 end

    local picked = 0
    if hasFarmEggs then
        picked = harvestBreedFarms(farms, mapObjectManager, pawn)
        if picked > 0 then
            -- re-fetch inventory after pickup (new eggs arrived)
            invCont, invContId = getInventoryContainerAndId(playerState, ctx.utility, world)
            invEggSlots = {}
            if isUObject(invCont) and invContId then
                collectEggSlotsFromContainer(invCont, invContId, invEggSlots)
            end
        end
    end

    if #invEggSlots == 0 then
        if not silent and picked > 0 then
            sendNotice(string.format("AutoBreed: picked %d egg(s) from farm (incubators full).", picked), ctx)
        end
        return picked, 0
    end

    -- 4) incubators only for this base (single FindAllOf, only when we have eggs)
    local incubators = getIncubatorsForBase(baseId)
    if #incubators == 0 then return picked, 0 end

    local targets, totalFree = {}, 0
    for i = 1, #incubators do
        local container, module_ = getModelContainer(incubators[i])
        local cId = getModelContainerId(incubators[i], container, module_)
        if cId and isUObject(container) then
            local free = 0
            forEachSlot(container, function(s) if slotIsEmpty(s) then free = free + 1 end end)
            if free > 0 then
                targets[#targets + 1] = { containerId = cId, free = free }
                totalFree = totalFree + free
            end
        end
    end
    if #targets == 0 then
        if not silent and picked > 0 then
            sendNotice(string.format("AutoBreed: picked %d egg(s), incubators full.", picked), ctx)
        end
        return picked, 0
    end

    local planned, loaded = 0, 0
    local cap = math.min(#invEggSlots, CONFIG.AutoBreedMaxMoves)
    local reqId = playerUId or { A = os.time(), B = 0, C = 0, D = 0 }
    for t = 1, #targets do
        local take = math.min(cap - planned, targets[t].free)
        if take > 0 then
            local froms = {}
            for k = 1, take do
                local egg = invEggSlots[planned + k]
                if egg then froms[#froms + 1] = { SlotId = { ContainerId = egg.containerId, SlotIndex = egg.slotIndex }, Num = 1 } end
            end
            if #froms > 0 then
                if call(function() networkItem:RequestMoveToContainer_ToServer(reqId, targets[t].containerId, froms); return true end) then
                    loaded = loaded + #froms
                end
                planned = planned + #froms
            end
        end
        if planned >= cap then break end
    end

    if not silent and (picked > 0 or loaded > 0) then
        sendNotice(string.format("AutoBreed: farm +%d, to incubator %d", picked, loaded), ctx)
    end
    return picked, loaded
end

local function runAutoBreedTick()
    if autoBreedBusy then return end
    local now = os.clock()
    if now - autoBreedLastRun < (CONFIG.AutoBreedInterval or 5.0) then return end
    autoBreedLastRun = now
    autoBreedBusy = true
    local ok, err = pcall(function()
        local UEHelpers = call(function() return require("UEHelpers") end)
        local controller = (type(UEHelpers) == "table" and call(function() return UEHelpers.GetPlayerController() end)) or call(function() return FindFirstOf("PalPlayerController") end)
        local world = isUObject(controller) and (type(UEHelpers) == "table" and call(function() return UEHelpers.GetWorld() end) or call(function() return controller:GetWorld() end))
        local playerState = isUObject(controller) and call(function() return controller:GetPalPlayerState() end)
        local playerUId = isUObject(controller) and guidToTable(call(function() return controller:GetPlayerUId() end))
        local utility = getUtility()
        if not isUObject(controller) or not isUObject(world) or not isUObject(playerState) or not isUObject(utility) then return end
        local ctx = { world = world, playerState = playerState, playerUId = playerUId, utility = utility }
        runAutoBreedInternal(controller, world, playerState, playerUId, ctx, true)
    end)
    if not ok then print(CONFIG.LogPrefix .. "AutoBreed tick error: " .. tostring(err)) end
    autoBreedBusy = false
end

local function ensureAutoBreedLoop()
    if autoBreedLoopStarted then return end
    autoBreedLoopStarted = true
    local loopMs = 1000 -- fixed 1s loop, real interval checked inside runAutoBreedTick via os.clock
    local intervalMs = math.floor((CONFIG.AutoBreedInterval or 5.0) * 1000)
    if type(LoopAsync) == "function" then
        pcall(function()
            LoopAsync(loopMs, function()
                if not autoBreedEnabled then return end
                if autoBreedBusy then return end
                pcall(function()
                    if type(ExecuteInGameThread) == "function" then
                        ExecuteInGameThread(function() pcall(function() runAutoBreedTick() end) end)
                    else
                        runAutoBreedTick()
                    end
                end)
            end)
        end)
    elseif type(ExecuteWithDelay) == "function" then
        local function chain()
            pcall(function()
                if autoBreedEnabled and not autoBreedBusy then
                    if type(ExecuteInGameThread) == "function" then
                        ExecuteInGameThread(function() pcall(function() runAutoBreedTick() end) end)
                    else
                        runAutoBreedTick()
                    end
                end
            end)
            local nextMs = math.floor((CONFIG.AutoBreedInterval or 5.0) * 1000)
            pcall(function() ExecuteWithDelay(nextMs, chain) end)
        end
        pcall(function() ExecuteWithDelay(intervalMs, chain) end)
    end
end

local function runEggFillerInternal(controller, world, playerState, playerUId, ctx)
    local baseModel = getInsideBaseCampModel(controller, world)
    local baseId = isUObject(baseModel) and guidToTable(call(function() return baseModel:GetId() end))
    if not baseId then return sendNotice("Could not detect the base camp. Make sure you are inside your base.", ctx) end

    local pawn = isUObject(controller) and (call(function() return controller:GetPawn() end) or call(function() return controller.Pawn end))
    local mapObjectManager = getMapObjectManager(world, ctx.utility)
    local transmitter = isUObject(ctx.utility) and call(function() return ctx.utility:GetNetworkTransmitter(world) end)
    local networkItem = isUObject(transmitter) and call(function() return transmitter:GetItem() end)
    if not isUObject(networkItem) then return sendNotice("Network component unavailable.", ctx) end

    local incubators, breedFarms, chests = collectBaseObjects(baseModel, mapObjectManager)
    if #incubators == 0 then return sendNotice("No incubators found on this base.", ctx) end

    local invCont = getInventoryContainer(playerState, ctx.utility, world)
    local eggsBefore = countEggsInContainer(invCont)

    local rawFarmObjects = 0
    if #breedFarms > 0 then
        rawFarmObjects = harvestBreedFarms(breedFarms, mapObjectManager, pawn)
    end

    local eggsAfter = countEggsInContainer(invCont)
    local farmEggsPicked = math.max(0, eggsAfter - eggsBefore)
    if farmEggsPicked == 0 and rawFarmObjects > 0 then
        farmEggsPicked = rawFarmObjects
    end

    local targets, totalFree = {}, 0
    for _, inc in ipairs(incubators) do
        local container, module_ = getModelContainer(inc)
        local cId = getModelContainerId(inc, container, module_)
        if cId then
            local free = 0
            forEachSlot(container, function(s) if slotIsEmpty(s) then free = free + 1 end end)
            if free > 0 then
                targets[#targets + 1] = { containerId = cId, free = free }
                totalFree = totalFree + free
            end
        end
    end
    if #targets == 0 then
        local msg = "All incubator slots are already occupied."
        if farmEggsPicked > 0 then msg = string.format("Harvested %d egg(s) from breeding farm. All incubators are full.", farmEggsPicked) end
        return sendNotice(msg, ctx)
    end

    local eggSlots = {}
    collectEggSlotsFromContainer(invCont, getModelContainerId(nil, invCont, nil), eggSlots)
    for _, chest in ipairs(chests) do
        local container, module_ = getModelContainer(chest)
        collectEggSlotsFromContainer(container, getModelContainerId(chest, container, module_), eggSlots)
    end
    if #eggSlots == 0 then return sendNotice("No eggs found in inventory or base chests.", ctx) end

    local planned, loaded, filledTargets = 0, 0, {}
    local cap = math.min(#eggSlots, CONFIG.MaxMovesPerRun)
    local reqId = playerUId or { A = os.time(), B = 0, C = 0, D = 0 }

    for t = 1, #targets do
        local take = math.min(cap - planned, targets[t].free)
        if take > 0 then
            local froms = {}
            for k = 1, take do
                local egg = eggSlots[planned + k]
                if egg then froms[#froms + 1] = { SlotId = { ContainerId = egg.containerId, SlotIndex = egg.slotIndex }, Num = 1 } end
            end
            if #froms > 0 then
                if call(function() networkItem:RequestMoveToContainer_ToServer(reqId, targets[t].containerId, froms); return true end) then
                    loaded = loaded + #froms
                    filledTargets[guidString(targets[t].containerId.ID) or tostring(t)] = true
                end
                planned = planned + #froms
            end
        end
        if planned >= cap then break end
    end

    local filledIncubators = 0; for _ in pairs(filledTargets) do filledIncubators = filledIncubators + 1 end
    local freeLeft = math.max(0, totalFree - loaded)
    local farmPart = farmEggsPicked > 0 and string.format("Harvested from farm: %d. ", farmEggsPicked) or ""
    local msg = string.format("%sLoaded eggs: %d. Filled incubators: %d.%s", farmPart, loaded, filledIncubators, freeLeft == 0 and " No free slots left." or (" Free slots left: " .. freeLeft))
    sendNotice(msg, ctx)
end

local function runEggHarvestInternal(controller, world, playerState, playerUId, ctx)
    local baseModel = getInsideBaseCampModel(controller, world)
    local baseId = isUObject(baseModel) and guidToTable(call(function() return baseModel:GetId() end))
    if not baseId then return sendNotice("Could not detect the base camp. Make sure you are inside your base.", ctx) end

    local mapObjectManager = getMapObjectManager(world, ctx.utility)
    local incubators, _, _ = collectBaseObjects(baseModel, mapObjectManager)
    if #incubators == 0 then return sendNotice("No incubators found on this base.", ctx) end

    local playerId = tonumber(call(function() return playerState:GetPlayerId() end))
                  or tonumber(call(function() return playerState.PlayerId end))
                  or 0

    local transmitter = isUObject(ctx.utility) and call(function() return ctx.utility:GetNetworkTransmitter(world) end)
    local networkMapObject = isUObject(transmitter) and call(function() return transmitter:GetMapObject() end)

    local collectedInfos = {}
    local processedCount = 0

    for _, inc in ipairs(incubators) do
        if isUObject(inc) then
            if isMultiIncubator(inc) then
                if CONFIG.EnableUI then
                    local infos = readMultiIncubatorInfos(inc)
                    for _, info in ipairs(infos) do
                        collectedInfos[#collectedInfos + 1] = info
                    end
                end

                local ok = call(function() inc:RequestObtainAllHatchedCharacter(); return true end)
                if not ok then
                    local slotNum = call(function() return inc:GetItemSlotNum() end) or 1
                    for s = 0, slotNum - 1 do
                        call(function() inc:RequestObtainSingleHatchedCharacter(s) end)
                    end
                end
                processedCount = processedCount + 1
            else
                if CONFIG.EnableUI then
                    local info = readSingleIncubatorInfo(inc)
                    if info then
                        collectedInfos[#collectedInfos + 1] = info
                    end
                end

                local instanceId = getInstanceId(inc)
                if isUObject(networkMapObject) and instanceId then
                    local funcName = call(function() return FName("ObtainHatchedCharacter_ServerInternal") end)
                    if funcName then
                        call(function()
                            networkMapObject:RequestConcreteModel_Server_int32(instanceId, funcName, math.floor(playerId))
                        end)
                        processedCount = processedCount + 1
                    end
                end
            end
        end
    end

    local msg = string.format("Sent harvest request for %d incubator(s)!", processedCount)
    sendNotice(msg, ctx)

    if CONFIG.EnableUI and reportUI then
        if #collectedInfos > 0 then
            print(CONFIG.LogPrefix .. "Showing report with " .. #collectedInfos .. " pal(s)")
            reportUI.show(collectedInfos, ctx)
        else
            print(CONFIG.LogPrefix .. "No hatched pals found to report")
        end
    end
end

local busy, lastCommandAt = false, -1

local function onReceivedChat(context, message)
    local r = unwrap(message)
    local text = r and call(function() return r.Message:ToString() end)
    if not text then return end

    local line = text:gsub("^%s+", ""):gsub("%s+$", ""):lower()
    local cmdIn  = CONFIG.CommandIn:lower()
    local cmdOut = CONFIG.CommandOut:lower()
    local cmdAuto = CONFIG.CommandAuto:lower()

    local isEggIn  = (line == cmdIn or line:sub(1, #cmdIn + 1) == cmdIn .. " ")
    local isEggOut = (line == cmdOut or line:sub(1, #cmdOut + 1) == cmdOut .. " ")
    local isAuto   = (line == cmdAuto or line:sub(1, #cmdAuto + 1) == cmdAuto .. " ")

    if not isEggIn and not isEggOut and not isAuto then return end

    local now = os.clock()
    if now - lastCommandAt < CONFIG.CommandDedupSeconds then return end
    lastCommandAt = now

    local UEHelpers = call(function() return require("UEHelpers") end)
    local controller = (type(UEHelpers) == "table" and call(function() return UEHelpers.GetPlayerController() end)) or call(function() return FindFirstOf("PalPlayerController") end)
    local world = isUObject(controller) and (type(UEHelpers) == "table" and call(function() return UEHelpers.GetWorld() end) or call(function() return controller:GetWorld() end))
    local playerState = isUObject(controller) and call(function() return controller:GetPalPlayerState() end)
    local playerUId = isUObject(controller) and guidToTable(call(function() return controller:GetPlayerUId() end))

    if not isUObject(controller) or not isUObject(world) or not isUObject(playerState) then return end
    local ctx = { world = world, playerState = playerState, playerUId = playerUId, utility = getUtility() }

    if isAuto then
        local args = line:sub(#cmdAuto + 1):gsub("^%s+", "")
        if args == "" or args == "toggle" then
            autoBreedEnabled = not autoBreedEnabled
            if autoBreedEnabled then ensureAutoBreedLoop() end
            sendNotice(string.format("AutoBreed %s (interval %.1fs) | Commands: on/off/status/run/interval <sec>", autoBreedEnabled and "ENABLED" or "DISABLED", CONFIG.AutoBreedInterval), ctx)
        elseif args == "on" or args == "enable" or args == "1" then
            autoBreedEnabled = true
            ensureAutoBreedLoop()
            sendNotice(string.format("AutoBreed ENABLED (interval %.1fs)", CONFIG.AutoBreedInterval), ctx)
        elseif args == "off" or args == "disable" or args == "0" then
            autoBreedEnabled = false
            sendNotice("AutoBreed DISABLED", ctx)
        elseif args == "status" then
            sendNotice(string.format("AutoBreed %s | interval %.1fs | lastRun %.1fs ago | busy %s", autoBreedEnabled and "ON" or "OFF", CONFIG.AutoBreedInterval, os.clock() - autoBreedLastRun, autoBreedBusy and "yes" or "no"), ctx)
        elseif args == "run" or args == "now" or args == "once" then
            if not autoBreedBusy then
                autoBreedBusy = true
                local ok, err = pcall(function() runAutoBreedInternal(controller, world, playerState, playerUId, ctx, false) end)
                autoBreedBusy = false
                if not ok then sendNotice("AutoBreed error: " .. tostring(err), ctx) end
            else
                sendNotice("AutoBreed busy, try again", ctx)
            end
        elseif args:sub(1, 8) == "interval" then
            local numStr = args:sub(9):gsub("^%s+", "")
            local num = tonumber(numStr)
            if num and num >= 1 and num <= 120 then
                CONFIG.AutoBreedInterval = num
                sendNotice(string.format("AutoBreed interval set to %.1fs (restart with !autobreed on to apply loop)", num), ctx)
            else
                sendNotice("Usage: !autobreed interval <1-120> (seconds)", ctx)
            end
        else
            sendNotice("AutoBreed usage: !autobreed [on/off/status/run/interval <sec>]", ctx)
        end
        return
    end

    if not busy then
        busy = true
        local ok, err
        if isEggIn then
            ok, err = pcall(function() runEggFillerInternal(controller, world, playerState, playerUId, ctx) end)
        elseif isEggOut then
            ok, err = pcall(function() runEggHarvestInternal(controller, world, playerState, playerUId, ctx) end)
        end
        if not ok then
            call(function() playerState:EnterChat(FText("Error: " .. tostring(err)), 1) end)
        end
        busy = false
    end
end

local function registerEscClose()
    if not CONFIG.EnableUI or not reportUI then return end
    local ok, err = pcall(function()
        RegisterKeyBind(Key.ESCAPE, function()
            pcall(function()
                if reportUI and reportUI.is_visible and reportUI.is_visible() then
                    reportUI.close()
                end
            end)
        end)
    end)
    if ok then
        print(CONFIG.LogPrefix .. "ESC close registered.")
    end
end

if call(function() RegisterHook("/Script/Pal.PalUIChat:OnReceivedChat", onReceivedChat); return true end) then
    print(CONFIG.LogPrefix .. "v" .. VERSION .. " loaded. Commands: '" .. CONFIG.CommandIn .. "' , '" .. CONFIG.CommandOut .. "' , '" .. CONFIG.CommandAuto .. " [on/off/status/run/interval]'")
end

if CONFIG.EnableUI then
    registerEscClose()
end

-- pre-warm autobreed loop structure (does not run until enabled)
-- ensureAutoBreedLoop will be called on !autobreed on, but we can init LoopAsync early to avoid hitch on first enable
pcall(function()
    if type(ExecuteWithDelay) == "function" then
        ExecuteWithDelay(3000, function()
            if autoBreedEnabled then ensureAutoBreedLoop() end
        end)
    end
end)

