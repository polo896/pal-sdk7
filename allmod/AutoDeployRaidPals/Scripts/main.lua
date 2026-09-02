-- =======================================================================
-- Auto Deploy Raid Pals Mod
-- Author: Wol4ara896
-- =======================================================================

local MOD_NAME = "AutoDeployRaidPals"

-- ================= CONFIGURATION =================
local CONFIG = {
    PagesToSave = 1,
    SlotsPerPage = 30,
    MaxPresetsToScan = 10,
    FilePrefix = "PalRaidFavorites_Slot_"
}

-- ================= COMMANDS ======================
local CMD_DEPLOY = "!raid"
local CMD_SWAP   = "!swap"
local CMD_SAVE   = "!rsave"
local CMD_RESET  = "!rreset"
local CMD_LIST   = "!rlist"

local Presets = {}
local LastActivePreset = 1

local function GetPresetFilePath(presetId)
    return string.format("%s%d.txt", CONFIG.FilePrefix, presetId)
end

local function LoadPresetFromFile(presetId)
    local path = GetPresetFilePath(presetId)
    local file = io.open(path, "r")

    if not file and presetId == 1 then
        file = io.open("PalRaidFavorites.txt", "r")
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
    for i = 1, CONFIG.MaxPresetsToScan do
        local data = LoadPresetFromFile(i)
        if data and #data.order > 0 then
            Presets[i] = data
            print(string.format("[%s] Loaded Preset #%d with %d Pals.", MOD_NAME, i, #data.order))
        end
    end
end

local function GetUtility()
    return StaticFindObject("/Script/Pal.Default__PalUtility")
end

local function GetWorldContext()
    local character = FindFirstOf("PalPlayerCharacter")
    if character and character:IsValid() then return character end
    
    local controller = FindFirstOf("PalPlayerController")
    if controller and controller:IsValid() then return controller end
    
    return nil
end

local function GetPalParamFromSlot(slot)
    if not slot or not slot:IsValid() or slot:IsEmpty() then return nil end
    
    local handle = slot:GetHandle()
    if handle and handle:IsValid() then
        local param = handle:TryGetIndividualParameter()
        if param and param:IsValid() then return param end
    end
    
    local repParam = slot.ReplicateIndividualParameter
    if repParam and repParam:IsValid() then return repParam end
    
    return nil
end

local function GetPalGuidString(slot)
    if not slot or not slot:IsValid() or slot:IsEmpty() then return nil end

    local handle = slot:GetHandle()
    if handle and handle:IsValid() then
        local instId = handle:GetIndividualID()
        if instId and instId.InstanceId then
            local g = instId.InstanceId
            return string.format("%08X%08X%08X%08X", g.A, g.B, g.C, g.D)
        end
    end

    local param = GetPalParamFromSlot(slot)
    if param and param:IsValid() then
        local save = param.SaveParameter
        if save and save.IndividualId and save.IndividualId.InstanceId then
            local g = save.IndividualId.InstanceId
            return string.format("%08X%08X%08X%08X", g.A, g.B, g.C, g.D)
        end
    end

    return nil
end

local function CalculatePalScore(param)
    if not param or not param:IsValid() then return -1 end
    
    if param:IsDead() then return -1 end
    if param:IsAssignedToExpedition() then return -1 end

    local level = param:GetLevel() or 1
    local rank = param:GetRank() or 0
    local save = param.SaveParameter

    local talentHP   = (save and save.Talent_HP) or 0
    local talentShot = (save and save.Talent_Shot) or 0
    local talentDef  = (save and save.Talent_Defense) or 0

    local score = (level * 10000) + (rank * 1000) + talentHP + talentShot + talentDef
    return score
end

local function GetPalStorageContainer(ps, util, ctx)
    local storage = ps:GetPalStorage()
    if not storage or not storage:IsValid() then
        storage = util:GetLocalPalStorageData(ctx)
    end
    if not storage or not storage:IsValid() then return nil end

    local palBoxContainer = storage.TargetContainer
    if not palBoxContainer or not palBoxContainer:IsValid() then return nil end

    return palBoxContainer
end

local function GetRaidArenaContext(util, ctx, ps)
    if not ps:IsInStateByStageType(5) then
        util:SendSystemAnnounce(ctx, "[Raid] You must be in the Raid Boss Arena to use this command!")
        return nil
    end

    local playerChar = util:GetPalmi(ctx)
    if not playerChar or not playerChar:IsValid() then return nil end

    local campModel = nil
    if playerChar.InsideBaseCampCheckComponent and playerChar.InsideBaseCampCheckComponent:IsValid() then
        campModel = playerChar.InsideBaseCampCheckComponent:GetInsideBaseCampModel()
    end

    if not campModel or not campModel:IsValid() then
        local campMgr = util:GetBaseCampManager(ctx)
        if campMgr and campMgr:IsValid() then
            campModel = campMgr:GetNearestBaseCamp(playerChar:K2_GetActorLocation())
        end
    end

    if not campModel or not campModel:IsValid() then
        util:SendSystemAnnounce(ctx, "[Raid] Error: Raid Base Camp not found.")
        return nil
    end

    local workerDirector = campModel.WorkerDirector
    if not workerDirector or not workerDirector:IsValid() then return nil end
    
    local workerContainer = workerDirector.CharacterContainer
    if not workerContainer or not workerContainer:IsValid() then return nil end

    local transmitter = util:GetNetworkTransmitter(ctx)
    if not transmitter or not transmitter:IsValid() then return nil end
    
    local netBaseCamp = transmitter:GetBaseCamp()
    if not netBaseCamp or not netBaseCamp:IsValid() then return nil end

    return {
        campId = campModel:GetId(),
        raidPalBoxId = campModel:GetOwnerMapObjectInstanceId(),
        workerContainer = workerContainer,
        netBaseCamp = netBaseCamp
    }
end

local function GetDeployCandidates(ps, util, ctx, arenaWorkerContainer, presetId)
    local palBoxContainer = GetPalStorageContainer(ps, util, ctx)
    if not palBoxContainer then return {}, 0 end

    local preset = Presets[presetId]
    local presetMap = (preset and preset.map) or {}

    local currentlyDeployedGuids = {}
    if arenaWorkerContainer and arenaWorkerContainer:IsValid() then
        for i = 0, arenaWorkerContainer:Num() - 1 do
            local wSlot = arenaWorkerContainer:Get(i)
            if wSlot and wSlot:IsValid() and not wSlot:IsEmpty() then
                local wGuid = GetPalGuidString(wSlot)
                if wGuid then
                    currentlyDeployedGuids[wGuid] = true
                end
            end
        end
    end

    local totalPalBoxSlots = palBoxContainer:Num()
    local favoriteCandidates = {}
    local regularCandidates = {}

    for i = 0, totalPalBoxSlots - 1 do
        local slot = palBoxContainer:Get(i)
        if slot and slot:IsValid() and not slot:IsEmpty() then
            local param = GetPalParamFromSlot(slot)
            if param and not param:IsDead() and not param:IsAssignedToExpedition() then
                local guidStr = GetPalGuidString(slot)
                
                if guidStr and not currentlyDeployedGuids[guidStr] then
                    local score = CalculatePalScore(param)

                    if presetMap[guidStr] then
                        table.insert(favoriteCandidates, {
                            slot = slot,
                            guid = guidStr,
                            score = score,
                            level = param:GetLevel(),
                            name = param:GetCharacterID():ToString(),
                            isFavorite = true
                        })
                    elseif score > 0 then
                        table.insert(regularCandidates, {
                            slot = slot,
                            guid = guidStr,
                            score = score,
                            level = param:GetLevel(),
                            name = param:GetCharacterID():ToString(),
                            isFavorite = false
                        })
                    end
                end
            end
        end
    end

    table.sort(regularCandidates, function(a, b)
        return a.score > b.score
    end)

    local finalCandidates = {}
    for _, cand in ipairs(favoriteCandidates) do
        table.insert(finalCandidates, cand)
    end
    for _, cand in ipairs(regularCandidates) do
        table.insert(finalCandidates, cand)
    end

    return finalCandidates, #favoriteCandidates
end


local function ExecuteSaveCommand(argPreset, argPages)
    local util = GetUtility()
    local ctx = GetWorldContext()
    if not util or not ctx then return end

    local ps = util:GetLocalPlayerState(ctx)
    if not ps or not ps:IsValid() then return end

    local palBoxContainer = GetPalStorageContainer(ps, util, ctx)
    if not palBoxContainer then
        util:SendSystemAnnounce(ctx, "[Raid] Error: Could not access Palbox.")
        return
    end

    local presetId = tonumber(argPreset) or 1
    if presetId < 1 then presetId = 1 end

    local pages = tonumber(argPages) or CONFIG.PagesToSave
    if pages < 1 then pages = 1 end

    local maxSlotsToScan = math.min(pages * CONFIG.SlotsPerPage, palBoxContainer:Num())

    local newPresetData = { map = {}, order = {} }
    local savedCount = 0

    for i = 0, maxSlotsToScan - 1 do
        local slot = palBoxContainer:Get(i)
        if slot and slot:IsValid() and not slot:IsEmpty() then
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
        local msg = string.format("[Raid] Saved %d Pals from %d page(s) to Preset #%d!", savedCount, pages, presetId)
        util:SendSystemAnnounce(ctx, msg)
        print(string.format("[%s] %s", MOD_NAME, msg))
    else
        util:SendSystemAnnounce(ctx, string.format("[Raid] Error saving Preset #%d to file.", presetId))
    end
end

local function ExecuteResetCommand(argPreset)
    local util = GetUtility()
    local ctx = GetWorldContext()
    if not util or not ctx then return end

    if argPreset == "all" then
        for i = 1, CONFIG.MaxPresetsToScan do
            if Presets[i] then
                Presets[i] = nil
                SavePresetToFile(i, { map = {}, order = {} })
            end
        end
        local msg = "[Raid] All Presets have been reset!"
        util:SendSystemAnnounce(ctx, msg)
        print(string.format("[%s] %s", MOD_NAME, msg))
        return
    end

    local presetId = tonumber(argPreset) or 1
    Presets[presetId] = nil
    SavePresetToFile(presetId, { map = {}, order = {} })

    local msg = string.format("[Raid] Preset #%d has been reset.", presetId)
    util:SendSystemAnnounce(ctx, msg)
    print(string.format("[%s] %s", MOD_NAME, msg))
end

local function ExecuteListCommand()
    local util = GetUtility()
    local ctx = GetWorldContext()
    if not util or not ctx then return end

    local listStr = ""
    local count = 0
    for i = 1, CONFIG.MaxPresetsToScan do
        if Presets[i] and #Presets[i].order > 0 then
            listStr = listStr .. string.format("[#%d: %d Pals] ", i, #Presets[i].order)
            count = count + 1
        end
    end

    if count == 0 then
        util:SendSystemAnnounce(ctx, "[Raid Presets] No saved presets found. Use !rsave to save.")
    else
        util:SendSystemAnnounce(ctx, "[Raid Presets] " .. listStr)
    end
end

local function ExecuteDeployCommand(argPreset)
    local util = GetUtility()
    local ctx = GetWorldContext()
    if not util or not ctx then return end

    local ps = util:GetLocalPlayerState(ctx)
    if not ps or not ps:IsValid() then return end

    local arena = GetRaidArenaContext(util, ctx, ps)
    if not arena then return end

    local presetId = tonumber(argPreset) or 1
    if presetId < 1 then presetId = 1 end
    LastActivePreset = presetId

    local freeSlotsCount = 0
    local totalCapacity = arena.workerContainer:Num()
    for i = 0, totalCapacity - 1 do
        local wSlot = arena.workerContainer:Get(i)
        if wSlot and wSlot:IsValid() and wSlot:IsEmpty() then
            freeSlotsCount = freeSlotsCount + 1
        end
    end

    if freeSlotsCount <= 0 then
        util:SendSystemAnnounce(ctx, "[Raid] All Arena worker slots are already full!")
        return
    end

    local candidates, favCount = GetDeployCandidates(ps, util, ctx, arena.workerContainer, presetId)
    if #candidates == 0 then
        util:SendSystemAnnounce(ctx, "[Raid] No suitable alive Pals found in your Palbox.")
        return
    end

    local deployCount = math.min(#candidates, freeSlotsCount)
    local toContainerId = arena.workerContainer:GetId()
    local deployedFavs = 0

    for i = 1, deployCount do
        local targetCand = candidates[i]
        if targetCand.isFavorite then
            deployedFavs = deployedFavs + 1
        end
        arena.netBaseCamp:RequestMoveCharacterToWorker_ToServer(
            arena.campId,
            targetCand.slot:GetSlotId(),
            toContainerId,
            arena.raidPalBoxId
        )
    end

    local resultMsg = string.format("[Raid] [Preset #%d] Deployed %d Pals (%d from Preset + %d Strongest)!", 
        presetId, deployCount, deployedFavs, deployCount - deployedFavs)
    util:SendSystemAnnounce(ctx, resultMsg)
    print(string.format("[%s] %s", MOD_NAME, resultMsg))
end

local function ExecuteSwapCommand(argPreset)
    local util = GetUtility()
    local ctx = GetWorldContext()
    if not util or not ctx then return end

    local ps = util:GetLocalPlayerState(ctx)
    if not ps or not ps:IsValid() then return end

    local arena = GetRaidArenaContext(util, ctx, ps)
    if not arena then return end

    local presetId = tonumber(argPreset) or LastActivePreset
    if presetId < 1 then presetId = 1 end

    local totalCapacity = arena.workerContainer:Num()
    local deadPalsEvacuated = 0
    local initialEmptySlots = 0

    for i = 0, totalCapacity - 1 do
        local wSlot = arena.workerContainer:Get(i)
        if wSlot and wSlot:IsValid() then
            if wSlot:IsEmpty() then
                initialEmptySlots = initialEmptySlots + 1
            else
                local param = GetPalParamFromSlot(wSlot)
                if param and param:IsDead() then
                    arena.netBaseCamp:RequestMoveWorkerToPalBox_ToServer(
                        arena.campId,
                        wSlot:GetSlotId(),
                        0,
                        arena.raidPalBoxId
                    )
                    deadPalsEvacuated = deadPalsEvacuated + 1
                end
            end
        end
    end

    local totalSlotsToFill = deadPalsEvacuated + initialEmptySlots
    if totalSlotsToFill <= 0 then
        util:SendSystemAnnounce(ctx, "[Raid Swap] All Pals on the Arena are alive and healthy!")
        return
    end

    local candidates, _ = GetDeployCandidates(ps, util, ctx, arena.workerContainer, presetId)
    if #candidates == 0 then
        local msg = string.format("[Raid Swap] Retrieved %d dead Pals. No alive replacements left in Palbox!", deadPalsEvacuated)
        util:SendSystemAnnounce(ctx, msg)
        return
    end

    local deployCount = math.min(#candidates, totalSlotsToFill)
    local toContainerId = arena.workerContainer:GetId()

    for i = 1, deployCount do
        local targetCand = candidates[i]
        arena.netBaseCamp:RequestMoveCharacterToWorker_ToServer(
            arena.campId,
            targetCand.slot:GetSlotId(),
            toContainerId,
            arena.raidPalBoxId
        )
    end

    local summaryMsg = string.format("[Raid Swap] [Preset #%d] Cleared %d dead Pals and deployed %d fresh Pals!", 
        presetId, deadPalsEvacuated, deployCount)
    util:SendSystemAnnounce(ctx, summaryMsg)
    print(string.format("[%s] %s", MOD_NAME, summaryMsg))
end

RegisterHook("/Script/Pal.PalUIChat:OnReceivedChat", function(self, Message)
    if not Message then return end
    
    local chatData = Message:get()
    if not chatData then return end
    
    local text = chatData.Message:ToString()
    if not text then return end

    if text == CMD_LIST then
        ExecuteListCommand()

    elseif text:sub(1, #CMD_DEPLOY) == CMD_DEPLOY and (text:len() == #CMD_DEPLOY or text:sub(#CMD_DEPLOY+1, #CMD_DEPLOY+1) == " ") then
        local arg = text:sub(#CMD_DEPLOY + 1):match("^%s*(%d*)%s*$")
        ExecuteDeployCommand(arg)

    elseif text:sub(1, #CMD_SWAP) == CMD_SWAP and (text:len() == #CMD_SWAP or text:sub(#CMD_SWAP+1, #CMD_SWAP+1) == " ") then
        local arg = text:sub(#CMD_SWAP + 1):match("^%s*(%d*)%s*$")
        ExecuteSwapCommand(arg)

    elseif text:sub(1, #CMD_RESET) == CMD_RESET and (text:len() == #CMD_RESET or text:sub(#CMD_RESET+1, #CMD_RESET+1) == " ") then
        local arg = text:sub(#CMD_RESET + 1):match("^%s*(%S*)%s*$")
        ExecuteResetCommand(arg)

    elseif text:sub(1, #CMD_SAVE) == CMD_SAVE and (text:len() == #CMD_SAVE or text:sub(#CMD_SAVE+1, #CMD_SAVE+1) == " ") then
        local p1, p2 = text:sub(#CMD_SAVE + 1):match("^%s*(%d*)%s*(%d*)%s*$")
        ExecuteSaveCommand(p1, p2)
    end
end)

InitAllPresets()

print(string.format("[%s] Loaded successfully with Multi-Preset support.", MOD_NAME))
