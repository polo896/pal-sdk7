-- ======================================================================
-- PalBaseManager - By Wol4ara896
-- ======================================================================

local MOD_NAME = "PalBaseManager"

-- ================= CONFIGURATION =================
local Config = {
    CmdFeed          = "!paleat",
    CmdStrong        = "!spbase",
    CmdHungry        = "!phungry",
    CmdSave          = "!spsave",
    CmdReset         = "!spreset",
    CmdList          = "!splist",
    HungerThreshold  = 0.45,
    PagesToSave      = 1,
    SlotsPerPage     = 30,
    MaxPresetsToScan = 10,
    FilePrefix       = "PalBaseFavorites_Slot_"
}

local Presets = {}
local LastActivePreset = 1

local function call(fn, ...)
    local ok, result = pcall(fn, ...)
    if ok then return result end
    return nil
end

local function valid(o)
    if not o or type(o) ~= "userdata" then return false end
    local ok, result = pcall(function() return o:IsValid() end)
    return ok and result == true
end

local function GetUtility()
    return StaticFindObject("/Script/Pal.Default__PalUtility")
end

local function GetWorldContext()
    local UEHelpers = nil
    pcall(function() UEHelpers = require("UEHelpers") end)
    
    if type(UEHelpers) == "table" then
        local w = call(function() return UEHelpers.GetWorld() end)
        if valid(w) then return w end
    end

    local controller = FindFirstOf("PalPlayerController")
    if valid(controller) then
        local w = call(function() return controller:GetWorld() end)
        if valid(w) then return w end
        return controller
    end

    return FindFirstOf("PalPlayerCharacter")
end

local function SendPlayerMessage(ctx, msg)
    local util = GetUtility()
    if valid(util) and valid(ctx) then
        pcall(function() util:SendSystemAnnounce(ctx, msg) end)
    end
    print(string.format("[%s] %s", MOD_NAME, msg))
end

local function GetPresetFilePath(presetId)
    return string.format("%s%d.txt", Config.FilePrefix, presetId)
end

local function LoadPresetFromFile(presetId)
    local path = GetPresetFilePath(presetId)
    local file = io.open(path, "r")

    if not file and presetId == 1 then
        file = io.open("PalRaidFavorites_Slot_1.txt", "r") or io.open("PalRaidFavorites.txt", "r")
    end

    if not file then return nil end

    local presetData = { map = {}, order = {} }
    for line in file:lines() do
        local cleanId = line:match("^%s*(.-)%s*$")
        if cleanId and cleanId ~= "" and not presetData.map[cleanId] then
            presetData.map[cleanId] = true
            table.insert(presetData.order, cleanId)
        end
    end
    file:close()
    return presetData
end

local function SavePresetToFile(presetId, presetData)
    local path = GetPresetFilePath(presetId)
    local file = io.open(path, "w+")
    if not file then
        print(string.format("[%s] Error: Failed to open %s for writing.", MOD_NAME, path))
        return false
    end

    if presetData and presetData.order then
        for _, guidStr in ipairs(presetData.order) do
            file:write(guidStr .. "\n")
        end
    end
    file:close()
    return true
end

local function InitAllPresets()
    Presets = {}
    for i = 1, Config.MaxPresetsToScan do
        local data = LoadPresetFromFile(i)
        if data and #data.order > 0 then
            Presets[i] = data
            print(string.format("[%s] Loaded Preset #%d with %d Pals.", MOD_NAME, i, #data.order))
        end
    end
end

local function GuidToString(Guid)
    if not Guid then return "None" end
    local str = "None"
    pcall(function() str = Guid:ToString() end)
    if (str == "None" or not str) and Guid.A then
        str = string.format("%08X%08X%08X%08X", Guid.A, Guid.B, Guid.C, Guid.D)
    end
    return str
end

local function InstanceIdToString(instanceId)
    if not instanceId then return "None" end
    local s = GuidToString(instanceId.Id)
    if s == "None" and instanceId.A then
        s = GuidToString(instanceId)
    end
    return s
end

local function GetPalParamFromSlot(slot)
    if not valid(slot) then return nil end

    local isEmpty = call(function() return slot:IsEmpty() end)
    if isEmpty == true then return nil end

    local handle = call(function() return slot:GetHandle() end) or slot.Handle
    if valid(handle) then
        local param = call(function() return handle:TryGetIndividualParameter() end)
        if valid(param) then return param end
    end

    local repParam = slot.ReplicateIndividualParameter
    if valid(repParam) then return repParam end

    return nil
end

local function GetPalGuidString(slot)
    if not valid(slot) or slot:IsEmpty() then return nil end

    local handle = call(function() return slot:GetHandle() end) or slot.Handle
    if valid(handle) then
        local instId = call(function() return handle:GetIndividualID() end) or handle.ID
        if instId then
            if instId.InstanceId then
                local g = instId.InstanceId
                return string.format("%08X%08X%08X%08X", g.A, g.B, g.C, g.D)
            end
            local str = GuidToString(instId)
            if str and str ~= "None" then return str end
        end
    end

    local param = GetPalParamFromSlot(slot)
    if valid(param) and param.SaveParameter and param.SaveParameter.IndividualId then
        local g = param.SaveParameter.IndividualId.InstanceId
        if g then
            return string.format("%08X%08X%08X%08X", g.A, g.B, g.C, g.D)
        end
    end

    if slot.ReplicateHandleID then
        return InstanceIdToString(slot.ReplicateHandleID)
    end

    return nil
end

local function GetCurrentBaseWorkerGuids(workerContainer)
    local workerGuids = {}
    if not valid(workerContainer) then return workerGuids end

    local total = call(function() return workerContainer:Num() end) or 0
    for i = 0, total - 1 do
        local slot = call(function() return workerContainer:Get(i) end)
        if valid(slot) and not slot:IsEmpty() then
            local guidStr = GetPalGuidString(slot)
            if guidStr and guidStr ~= "None" then
                workerGuids[guidStr] = true
            end
        end
    end
    return workerGuids
end

local function GetPalStorageContainer(ps, util, ctx)
    local storage = nil
    if valid(ps) then
        storage = call(function() return ps:GetPalStorage() end)
    end
    if not valid(storage) and valid(util) then
        storage = call(function() return util:GetLocalPalStorageData(ctx) end)
    end
    if not valid(storage) then return nil end

    return storage.TargetContainer
end

local function CalculatePalScore(param)
    if not valid(param) then return -1 end

    local isDead = call(function() return param:IsDead() end)
    if isDead == true then return -1 end

    if param.IsAssignedToExpedition then
        local isExp = call(function() return param:IsAssignedToExpedition() end)
        if isExp == true then return -1 end
    end

    local save = param.SaveParameter
    local level = call(function() return param:GetLevel() end)
    if (not level or level <= 1) and save and save.Level and save.Level > 1 then
        level = save.Level
    end
    level = level or 1

    local rank = call(function() return param:GetRank() end)
    if (not rank or rank <= 0) and save and save.Rank and save.Rank > 0 then
        rank = save.Rank
    end
    rank = rank or 0

    local talentHP   = (save and save.Talent_HP) or 0
    local talentShot = (save and save.Talent_Shot) or 0
    local talentDef  = (save and save.Talent_Defense) or 0

    return (level * 10000) + (rank * 1000) + talentHP + talentShot + talentDef, level
end

local function GetPalHungerRatio(param)
    if not valid(param) then return 1.0, 0, 0 end

    local cur = nil
    local max = nil

    local save = param.SaveParameter
    if save then
        cur = tonumber(save.FullStomach)
        max = tonumber(save.MaxFullStomach)
    end

    if (not cur or not max or max <= 0) and valid(param.IndividualActor) then
        local comp = param.IndividualActor.CharacterParameterComponent
        if valid(comp) then
            cur = tonumber(call(function() return comp:GetFullStomach() end))
            max = tonumber(call(function() return comp:GetMaxFullStomach() end))
        end
    end

    if max and max > 0 and cur then
        return (cur / max), cur, max
    end

    return 1.0, 0, 0
end

local function IsPalHungry(param)
    if not valid(param) then return false end

    local save = param.SaveParameter
    if save and save.HungerType and save.HungerType > 0 then
        return true
    end

    local ratio = GetPalHungerRatio(param)
    return ratio < Config.HungerThreshold
end

local function GetInsideBaseCampModel(controller, world)
    local components = call(function() return FindAllOf("PalInsideBaseCampCheckComponent") end)
    if components then
        for _, comp in ipairs(components) do
            if valid(comp) then
                local inside = call(function() return comp:IsInsideBaseCamp() end)
                if inside == true then
                    local model = call(function() return comp:GetInsideBaseCampModel() end)
                    if valid(model) then return model end
                end
            end
        end
    end

    local pawn = nil
    if valid(controller) then
        pawn = call(function() return controller:GetPawn() end) or call(function() return controller.Pawn end)
    end
    if not valid(pawn) then
        pawn = FindFirstOf("PalPlayerCharacter")
    end

    local loc = nil
    if valid(pawn) then
        loc = call(function() return pawn:K2_GetActorLocation() end)
            or call(function() return pawn:GetActorLocation() end)
    end

    local utility = GetUtility()
    if loc and valid(utility) and valid(world) then
        local manager = call(function() return utility:GetBaseCampManager(world) end)
        if valid(manager) then
            local model = call(function() return manager:GetInRangedBaseCamp(loc, 3000.0) end)
            if valid(model) then return model end
        end
    end

    if loc then
        local baseCamps = call(function() return FindAllOf("PalBaseCampModel") end)
        if baseCamps then
            local bestBase = nil
            local bestDistance = math.huge
            for _, base in ipairs(baseCamps) do
                if valid(base) then
                    local transform = call(function() return base:GetTransform() end)
                    local basePos = transform and transform.Translation
                    if basePos then
                        local dx = loc.X - basePos.X
                        local dy = loc.Y - basePos.Y
                        local dz = loc.Z - basePos.Z
                        local distance = math.sqrt(dx * dx + dy * dy + dz * dz)
                        local range = tonumber(call(function() return base:GetRange() end)) or 2500
                        if distance < bestDistance and distance <= range + 1500 then
                            bestBase = base
                            bestDistance = distance
                        end
                    end
                end
            end
            if valid(bestBase) then return bestBase end
        end
    end

    return nil
end

local function GetBreedFarmWorkIds()
    local breedWorkIds = {}
    local breedFarms = call(function() return FindAllOf("PalMapObjectBreedFarmModel") end)
    if breedFarms then
        for _, farm in ipairs(breedFarms) do
            if valid(farm) then
                pcall(function()
                    local workee = farm:GetWorkeeModule() or farm.WorkeeModuleCache
                    if valid(workee) then
                        local work = nil
                        if workee.GetWork then work = workee:GetWork() end
                        if not valid(work) and workee.TargetWork then work = workee.TargetWork end
                        if valid(work) then
                            local workId = work:GetWorkId()
                            local key = GuidToString(workId)
                            if key and key ~= "None" and key ~= "00000000000000000000000000000000" then
                                breedWorkIds[key] = true
                            end
                        end
                    end
                end)
            end
        end
    end
    return breedWorkIds
end

local function IsPalInBreedFarm(Handle, breedWorkIds)
    if not valid(Handle) then return false end

    local actor = call(function() return Handle:TryGetIndividualActor() end)
    if not valid(actor) then return false end

    local paramComp = actor.CharacterParameterComponent
    if not valid(paramComp) and actor.GetComponentByClass then
        local compClass = StaticFindObject("/Script/Pal.PalCharacterParameterComponent")
        if valid(compClass) then
            paramComp = call(function() return actor:GetComponentByClass(compClass) end)
        end
    end

    if not valid(paramComp) then return false end

    local isBreed = false
    pcall(function()
        local work = paramComp:GetWork()
        if valid(work) then
            local wt = work.OverrideWorkType
            if wt == 25 or (wt and string.find(tostring(wt), "BreedFarm")) then
                isBreed = true
                return
            end
            local ownerModel = work.CachedOwnerMapObjectConcreteModel
            if valid(ownerModel) then
                local fullName = ownerModel:GetFullName()
                if string.find(fullName, "BreedFarm") then
                    isBreed = true
                    return
                end
            end
        end
    end)

    if isBreed then return true end

    if breedWorkIds and next(breedWorkIds) ~= nil then
        pcall(function()
            local workId = paramComp:GetWorkId()
            local key = GuidToString(workId)
            if key and breedWorkIds[key] then
                isBreed = true
            end
        end)
    end

    return isBreed
end

local function CollectContainerSlots(container)
    local slotsList = {}
    if not valid(container) then return slotsList end

    local slotsTArray = call(function() return container:GetSlots() end)
    if slotsTArray then
        if type(slotsTArray) == "userdata" and slotsTArray.Num then
            local count = slotsTArray:Num()
            for i = 1, count do
                local s = slotsTArray[i]
                if valid(s) and not s:IsEmpty() then
                    table.insert(slotsList, s)
                end
            end
        elseif type(slotsTArray) == "table" and #slotsTArray > 0 then
            for _, s in ipairs(slotsTArray) do
                if valid(s) and not s:IsEmpty() then
                    table.insert(slotsList, s)
                end
            end
        end
    end

    if #slotsList == 0 then
        local total = call(function() return container:Num() end) or 0
        for i = 0, total - 1 do
            local s = call(function() return container:Get(i) end)
            if valid(s) and not s:IsEmpty() then
                table.insert(slotsList, s)
            end
        end
    end

    return slotsList
end

local function ExecuteFeedCurrentBase()
    local controller = FindFirstOf("PalPlayerController")
    local world = GetWorldContext()

    local baseCamp = GetInsideBaseCampModel(controller, world)
    if not valid(baseCamp) then
        SendPlayerMessage(world, "[Base Feed] Could not detect current base. Stand inside the base perimeter!")
        return
    end

    local workerDirector = baseCamp.WorkerDirector
    if not valid(workerDirector) then
        SendPlayerMessage(world, "[Base Feed] Base has no valid WorkerDirector.")
        return
    end

    local workerContainer = workerDirector.CharacterContainer
    if not valid(workerContainer) then
        SendPlayerMessage(world, "[Base Feed] Base has no valid CharacterContainer.")
        return
    end

    local rawSlots = CollectContainerSlots(workerContainer)
    local breedWorkIds = GetBreedFarmWorkIds()
    local fedCount = 0
    local ignoredBreedCount = 0

    for _, slot in ipairs(rawSlots) do
        if valid(slot) and not slot:IsEmpty() then
            local handle = call(function() return slot:GetHandle() end) or slot.Handle
            if valid(handle) then
                if IsPalInBreedFarm(handle, breedWorkIds) then
                    ignoredBreedCount = ignoredBreedCount + 1
                else
                    local param = call(function() return handle:TryGetIndividualParameter() end)
                        or slot.ReplicateIndividualParameter

                    if valid(param) and not call(function() return param:IsDead() end) then
                        local maxStomach = 0
                        local save = param.SaveParameter
                        if save and save.MaxFullStomach then
                            maxStomach = tonumber(save.MaxFullStomach) or 0
                        end

                        if maxStomach <= 0 then
                            local actor = call(function() return handle:TryGetIndividualActor() end)
                            if valid(actor) and valid(actor.CharacterParameterComponent) then
                                maxStomach = tonumber(call(function() return actor.CharacterParameterComponent:GetMaxFullStomach() end)) or 0
                            end
                        end

                        if maxStomach <= 0 then maxStomach = 100.0 end

                        local targetVal = maxStomach * Config.HungerThreshold
                        local setSuccess = false

                        if param.SetFullStomach then
                            pcall(function()
                                param:SetFullStomach(targetVal)
                                setSuccess = true
                            end)
                        end

                        if setSuccess then
                            fedCount = fedCount + 1
                        end
                    end
                end
            end
        end
    end

    SendPlayerMessage(world, string.format("[Base Feed] Fed %d Base Pals! (Ignored %d Breeding Pals)", fedCount, ignoredBreedCount))
end

local function ExecuteDeployStrongPals(argPreset)
    local ctx = GetWorldContext()
    local util = GetUtility()
    local controller = FindFirstOf("PalPlayerController")
    if not valid(ctx) or not valid(util) then return end

    local baseCamp = GetInsideBaseCampModel(controller, ctx)
    if not valid(baseCamp) then
        SendPlayerMessage(ctx, "[Strong Pals] You must be standing inside your Base Camp!")
        return
    end

    local workerDirector = baseCamp.WorkerDirector
    local workerContainer = workerDirector and workerDirector.CharacterContainer
    if not valid(workerContainer) then
        SendPlayerMessage(ctx, "[Strong Pals] Could not access Base worker container.")
        return
    end

    local transmitter = call(function() return util:GetNetworkTransmitter(ctx) end)
    local netBaseCamp = transmitter and (call(function() return transmitter:GetBaseCamp() end) or transmitter.BaseCamp)
    if not valid(netBaseCamp) then
        SendPlayerMessage(ctx, "[Strong Pals] Network transmitter not found.")
        return
    end

    local campId = call(function() return baseCamp:GetId() end) or baseCamp.ID
    local boxId = call(function() return baseCamp:GetOwnerMapObjectInstanceId() end) or baseCamp.OwnerMapObjectInstanceId
    local toContainerId = call(function() return workerContainer:GetId() end) or workerContainer.ContainerId

    local totalCapacity = call(function() return workerContainer:Num() end) or 0
    local freeSlotsCount = 0

    for i = 0, totalCapacity - 1 do
        local wSlot = call(function() return workerContainer:Get(i) end)
        if valid(wSlot) and wSlot:IsEmpty() then
            freeSlotsCount = freeSlotsCount + 1
        end
    end

    if freeSlotsCount <= 0 then
        SendPlayerMessage(ctx, "[Strong Pals] Base worker slots are already full!")
        return
    end

    local ps = call(function() return util:GetLocalPlayerState(ctx) end)
    local palBox = GetPalStorageContainer(ps, util, ctx)
    if not valid(palBox) then
        SendPlayerMessage(ctx, "[Strong Pals] Error: Could not access Pal Box storage.")
        return
    end

    local presetId = tonumber(argPreset) or 1
    if presetId < 1 then presetId = 1 end
    LastActivePreset = presetId

    local preset = Presets[presetId]
    local presetMap = (preset and preset.map) or {}

    local totalBoxSlots = call(function() return palBox:Num() end) or 0
    local currentBaseWorkers = GetCurrentBaseWorkerGuids(workerContainer)

    local favoriteCandidates = {}
    local regularCandidates = {}

    for i = 0, totalBoxSlots - 1 do
        local slot = call(function() return palBox:Get(i) end)
        if valid(slot) and not slot:IsEmpty() then
            local param = GetPalParamFromSlot(slot)
            local guidStr = GetPalGuidString(slot)

            if valid(param) and (not guidStr or not currentBaseWorkers[guidStr]) then
                local score, palLvl = CalculatePalScore(param)
                if score > 0 then
                    local candData = {
                        slot = slot,
                        guid = guidStr,
                        score = score,
                        level = palLvl,
                        isFavorite = (guidStr and presetMap[guidStr]) and true or false
                    }

                    if candData.isFavorite then
                        table.insert(favoriteCandidates, candData)
                    else
                        table.insert(regularCandidates, candData)
                    end
                end
            end
        end
    end

    table.sort(regularCandidates, function(a, b) return a.score > b.score end)

    local finalCandidates = {}
    for _, cand in ipairs(favoriteCandidates) do
        table.insert(finalCandidates, cand)
    end
    for _, cand in ipairs(regularCandidates) do
        table.insert(finalCandidates, cand)
    end

    if #finalCandidates == 0 then
        SendPlayerMessage(ctx, "[Strong Pals] No eligible alive Pals found in your Pal Box.")
        return
    end

    local deployCount = math.min(#finalCandidates, freeSlotsCount)
    local deployedFavs = 0

    for i = 1, deployCount do
        local cand = finalCandidates[i]
        if cand.isFavorite then
            deployedFavs = deployedFavs + 1
        end

        pcall(function()
            netBaseCamp:RequestMoveCharacterToWorker_ToServer(
                campId,
                cand.slot:GetSlotId(),
                toContainerId,
                boxId
            )
        end)
    end

    local msg = string.format("[Strong Pals] [Preset #%d] Deployed %d Pals (%d from Preset + %d Strongest)!", 
        presetId, deployCount, deployedFavs, deployCount - deployedFavs)
    SendPlayerMessage(ctx, msg)
end

local function ExecuteDeployHungryPals()
    local ctx = GetWorldContext()
    local util = GetUtility()
    local controller = FindFirstOf("PalPlayerController")
    if not valid(ctx) or not valid(util) then return end

    local baseCamp = GetInsideBaseCampModel(controller, ctx)
    if not valid(baseCamp) then
        SendPlayerMessage(ctx, "[Hungry Pals] You must be standing inside your Base Camp!")
        return
    end

    local workerDirector = baseCamp.WorkerDirector
    local workerContainer = workerDirector and workerDirector.CharacterContainer
    if not valid(workerContainer) then
        SendPlayerMessage(ctx, "[Hungry Pals] Could not access Base worker container.")
        return
    end

    local transmitter = call(function() return util:GetNetworkTransmitter(ctx) end)
    local netBaseCamp = transmitter and (call(function() return transmitter:GetBaseCamp() end) or transmitter.BaseCamp)
    if not valid(netBaseCamp) then
        SendPlayerMessage(ctx, "[Hungry Pals] Network transmitter not found.")
        return
    end

    local campId = call(function() return baseCamp:GetId() end) or baseCamp.ID
    local boxId = call(function() return baseCamp:GetOwnerMapObjectInstanceId() end) or baseCamp.OwnerMapObjectInstanceId
    local toContainerId = call(function() return workerContainer:GetId() end) or workerContainer.ContainerId

    local totalCapacity = call(function() return workerContainer:Num() end) or 0
    local freeSlotsCount = 0

    for i = 0, totalCapacity - 1 do
        local wSlot = call(function() return workerContainer:Get(i) end)
        if valid(wSlot) and wSlot:IsEmpty() then
            freeSlotsCount = freeSlotsCount + 1
        end
    end

    if freeSlotsCount <= 0 then
        SendPlayerMessage(ctx, "[Hungry Pals] Base worker slots are full! Free up some slots first.")
        return
    end

    local ps = call(function() return util:GetLocalPlayerState(ctx) end)
    local palBox = GetPalStorageContainer(ps, util, ctx)
    if not valid(palBox) then
        SendPlayerMessage(ctx, "[Hungry Pals] Error: Could not access Pal Box storage.")
        return
    end

    local totalBoxSlots = call(function() return palBox:Num() end) or 0
    local currentBaseWorkers = GetCurrentBaseWorkerGuids(workerContainer)
    local hungryCandidates = {}

    for i = 0, totalBoxSlots - 1 do
        local slot = call(function() return palBox:Get(i) end)
        if valid(slot) and not slot:IsEmpty() then
            local param = GetPalParamFromSlot(slot)
            local guidStr = GetPalGuidString(slot)

            if valid(param) and (not guidStr or not currentBaseWorkers[guidStr]) then
                local isDead = call(function() return param:IsDead() end)
                local isExpedition = false
                if param.IsAssignedToExpedition then
                    isExpedition = (call(function() return param:IsAssignedToExpedition() end) == true)
                end

                if isDead ~= true and not isExpedition then
                    if IsPalHungry(param) then
                        local ratio = GetPalHungerRatio(param)
                        table.insert(hungryCandidates, {
                            slot = slot,
                            ratio = ratio
                        })
                    end
                end
            end
        end
    end

    if #hungryCandidates == 0 then
        SendPlayerMessage(ctx, "[Hungry Pals] No hungry Pals (<45% stomach) found in your Pal Box!")
        return
    end

    table.sort(hungryCandidates, function(a, b) return a.ratio < b.ratio end)

    local deployCount = math.min(#hungryCandidates, freeSlotsCount)

    for i = 1, deployCount do
        local cand = hungryCandidates[i]
        pcall(function()
            netBaseCamp:RequestMoveCharacterToWorker_ToServer(
                campId,
                cand.slot:GetSlotId(),
                toContainerId,
                boxId
            )
        end)
    end

    SendPlayerMessage(ctx, string.format("[Hungry Pals] Deployed %d hungry Pals to base! (Remaining in Box: %d)", deployCount, #hungryCandidates - deployCount))
end

local function ExecuteSaveCommand(argPreset, argPages)
    local util = GetUtility()
    local ctx = GetWorldContext()
    if not valid(util) or not valid(ctx) then return end

    local ps = call(function() return util:GetLocalPlayerState(ctx) end)
    local palBoxContainer = GetPalStorageContainer(ps, util, ctx)
    if not valid(palBoxContainer) then
        SendPlayerMessage(ctx, "[Base Presets] Error: Could not access Palbox.")
        return
    end

    local presetId = tonumber(argPreset) or 1
    if presetId < 1 then presetId = 1 end

    local pages = tonumber(argPages) or Config.PagesToSave
    if pages < 1 then pages = 1 end

    local maxSlotsToScan = math.min(pages * Config.SlotsPerPage, palBoxContainer:Num())

    local newPresetData = { map = {}, order = {} }
    local savedCount = 0

    for i = 0, maxSlotsToScan - 1 do
        local slot = call(function() return palBoxContainer:Get(i) end)
        if valid(slot) and not slot:IsEmpty() then
            local guidStr = GetPalGuidString(slot)
            if guidStr and not newPresetData.map[guidStr] then
                newPresetData.map[guidStr] = true
                table.insert(newPresetData.order, guidStr)
                savedCount = savedCount + 1
            end
        end
    end

    Presets[presetId] = newPresetData
    if SavePresetToFile(presetId, newPresetData) then
        local msg = string.format("[Base Presets] Saved %d Pals from %d page(s) to Preset #%d!", savedCount, pages, presetId)
        SendPlayerMessage(ctx, msg)
    else
        SendPlayerMessage(ctx, string.format("[Base Presets] Error saving Preset #%d to file.", presetId))
    end
end

local function ExecuteResetCommand(argPreset)
    local ctx = GetWorldContext()
    if not valid(ctx) then return end

    if argPreset == "all" then
        for i = 1, Config.MaxPresetsToScan do
            if Presets[i] then
                Presets[i] = nil
                SavePresetToFile(i, { map = {}, order = {} })
            end
        end
        SendPlayerMessage(ctx, "[Base Presets] All Presets have been reset!")
        return
    end

    local presetId = tonumber(argPreset) or 1
    Presets[presetId] = nil
    SavePresetToFile(presetId, { map = {}, order = {} })

    SendPlayerMessage(ctx, string.format("[Base Presets] Preset #%d has been reset.", presetId))
end

local function ExecuteListCommand()
    local ctx = GetWorldContext()
    if not valid(ctx) then return end

    local listStr = ""
    local count = 0
    for i = 1, Config.MaxPresetsToScan do
        if Presets[i] and #Presets[i].order > 0 then
            listStr = listStr .. string.format("[#%d: %d Pals] ", i, #Presets[i].order)
            count = count + 1
        end
    end

    if count == 0 then
        SendPlayerMessage(ctx, "[Base Presets] No saved presets found. Use !spsave to save.")
    else
        SendPlayerMessage(ctx, "[Base Presets] " .. listStr)
    end
end

local lastCommandTime = 0

local function ProcessChatText(msgText)
    if not msgText then return end

    local rawText = tostring(msgText):match("^%s*(.-)%s*$")
    if not rawText or rawText == "" then return end

    local lowerText = string.lower(rawText)
    local now = os.clock()
    if (now - lastCommandTime) < 0.5 then return end

    if lowerText == string.lower(Config.CmdFeed) or lowerText == "!feed" then
        lastCommandTime = now
        ExecuteInGameThread(function()
            ExecuteFeedCurrentBase()
        end)

    elseif lowerText == string.lower(Config.CmdHungry) then
        lastCommandTime = now
        ExecuteInGameThread(function()
            ExecuteDeployHungryPals()
        end)

    elseif lowerText == string.lower(Config.CmdList) then
        lastCommandTime = now
        ExecuteInGameThread(function()
            ExecuteListCommand()
        end)

    elseif lowerText:sub(1, #Config.CmdStrong) == string.lower(Config.CmdStrong) and 
          (lowerText:len() == #Config.CmdStrong or lowerText:sub(#Config.CmdStrong+1, #Config.CmdStrong+1) == " ") then
        lastCommandTime = now
        local arg = rawText:sub(#Config.CmdStrong + 1):match("^%s*(%d*)%s*$")
        ExecuteInGameThread(function()
            ExecuteDeployStrongPals(arg)
        end)

    elseif lowerText:sub(1, #Config.CmdSave) == string.lower(Config.CmdSave) and 
          (lowerText:len() == #Config.CmdSave or lowerText:sub(#Config.CmdSave+1, #Config.CmdSave+1) == " ") then
        lastCommandTime = now
        local p1, p2 = rawText:sub(#Config.CmdSave + 1):match("^%s*(%d*)%s*(%d*)%s*$")
        ExecuteInGameThread(function()
            ExecuteSaveCommand(p1, p2)
        end)

    elseif lowerText:sub(1, #Config.CmdReset) == string.lower(Config.CmdReset) and 
          (lowerText:len() == #Config.CmdReset or lowerText:sub(#Config.CmdReset+1, #Config.CmdReset+1) == " ") then
        lastCommandTime = now
        local arg = rawText:sub(#Config.CmdReset + 1):match("^%s*(%S*)%s*$")
        ExecuteInGameThread(function()
            ExecuteResetCommand(arg)
        end)
    end
end

pcall(function()
    RegisterHook("/Script/Pal.PalGameStateInGame:BroadcastChatMessage", function(self, ChatMessage)
        if not ChatMessage then return end
        local msgText = nil
        pcall(function()
            local msgStruct = ChatMessage:get()
            if msgStruct and msgStruct.Message then
                msgText = msgStruct.Message:ToString()
            end
        end)
        if not msgText then
            pcall(function()
                if ChatMessage.Message then msgText = ChatMessage.Message:ToString() end
            end)
        end
        if msgText then ProcessChatText(msgText) end
    end)
end)

pcall(function()
    RegisterHook("/Script/Pal.PalUIChat:OnReceivedChat", function(self, Message)
        if not Message then return end
        local chatData = Message:get()
        if not chatData then return end
        local text = chatData.Message:ToString()
        if text then ProcessChatText(text) end
    end)
end)

InitAllPresets()

print(string.format("[%s] Successfully loaded! Commands: %s, %s, %s, %s, %s, %s", 
    MOD_NAME, Config.CmdStrong, Config.CmdSave, Config.CmdReset, Config.CmdList, Config.CmdHungry, Config.CmdFeed))