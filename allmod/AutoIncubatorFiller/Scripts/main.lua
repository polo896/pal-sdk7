-- ============================================================================
-- AutoIncubatorManager + Hatch Report UI - By Wol4ara896
-- ============================================================================
local VERSION = "2.2.2"

local CONFIG = {
    CommandIn  = "!eggin",
    CommandOut = "!eggout",
    MaxMovesPerRun = 200,
    CommandDedupSeconds = 0.35,
    LogPrefix = "[PalEggAutoFiller] ",
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

local reportUI = require("egg_report_ui")

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
                local infos = readMultiIncubatorInfos(inc)
                for _, info in ipairs(infos) do
                    collectedInfos[#collectedInfos + 1] = info
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
                local info = readSingleIncubatorInfo(inc)
                if info then
                    collectedInfos[#collectedInfos + 1] = info
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

    if #collectedInfos > 0 then
        print(CONFIG.LogPrefix .. "Showing report with " .. #collectedInfos .. " pal(s)")
        reportUI.show(collectedInfos, ctx)
    else
        print(CONFIG.LogPrefix .. "No hatched pals found to report")
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

    local isEggIn  = (line == cmdIn or line:sub(1, #cmdIn + 1) == cmdIn .. " ")
    local isEggOut = (line == cmdOut or line:sub(1, #cmdOut + 1) == cmdOut .. " ")

    if not isEggIn and not isEggOut then return end

    local now = os.clock()
    if now - lastCommandAt < CONFIG.CommandDedupSeconds then return end
    lastCommandAt = now

    if not busy then
        busy = true
        local UEHelpers = call(function() return require("UEHelpers") end)
        local controller = (type(UEHelpers) == "table" and call(function() return UEHelpers.GetPlayerController() end)) or call(function() return FindFirstOf("PalPlayerController") end)
        local world = isUObject(controller) and (type(UEHelpers) == "table" and call(function() return UEHelpers.GetWorld() end) or call(function() return controller:GetWorld() end))
        local playerState = isUObject(controller) and call(function() return controller:GetPalPlayerState() end)
        local playerUId = isUObject(controller) and guidToTable(call(function() return controller:GetPlayerUId() end))

        if isUObject(controller) and isUObject(world) and isUObject(playerState) then
            local ctx = { world = world, playerState = playerState, playerUId = playerUId, utility = getUtility() }
            local ok, err
            if isEggIn then
                ok, err = pcall(function() runEggFillerInternal(controller, world, playerState, playerUId, ctx) end)
            elseif isEggOut then
                ok, err = pcall(function() runEggHarvestInternal(controller, world, playerState, playerUId, ctx) end)
            end

            if not ok then
                call(function() playerState:EnterChat(FText("Error: " .. tostring(err)), 1) end)
            end
        end
        busy = false
    end
end

local function registerEscClose()
    local ok, err = pcall(function()
        RegisterKeyBind(Key.ESCAPE, function()
            pcall(function()
                if reportUI.is_visible() then
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
    print(CONFIG.LogPrefix .. "v" .. VERSION .. " loaded. Commands: '" .. CONFIG.CommandIn .. "' and '" .. CONFIG.CommandOut .. "'")
end

registerEscClose()