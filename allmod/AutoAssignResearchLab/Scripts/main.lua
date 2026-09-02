-- ======================================================================
-- Mod: Auto Research Assign
-- By Wol4ara896
-- ======================================================================

local Config = {
    ChatCommand = "!lab"
}

local SavedPalAssignments = {}
local ActiveLabAssignments = {}

local function GuidToString(Guid)
    if not Guid then return "None" end
    local str = "None"
    pcall(function() str = Guid:ToString() end)
    if (str == "None" or not str) and Guid.A then
        str = string.format("%08X%08X%08X%08X", Guid.A, Guid.B, Guid.C, Guid.D)
    end
    return str
end

local function GetPalKey(IndividualId)
    if not IndividualId then return nil end
    local key = nil
    pcall(function()
        if IndividualId.InstanceId then
            key = GuidToString(IndividualId.InstanceId)
        elseif IndividualId.PlayerUId then
            key = GuidToString(IndividualId.PlayerUId)
        end
    end)
    if not key or key == "None" then
        pcall(function() key = IndividualId:ToString() end)
    end
    return key
end

local function GetLabKey(LabModel)
    if not LabModel or not LabModel:IsValid() then return nil end
    local key = nil
    pcall(function() key = LabModel:GetAddress() end)
    if not key then key = tostring(LabModel) end
    return key
end

local function GetLiveNetworkComponent()
    local NetComp = FindFirstOf("PalNetworkBaseCampComponent")
    if NetComp and NetComp:IsValid() then
        return NetComp
    end

    local Player = FindFirstOf("PalPlayerCharacter")
    if Player and Player:IsValid() and Player.GetComponentByClass then
        local NetClass = StaticFindObject("/Script/Pal.PalNetworkBaseCampComponent")
        if NetClass and NetClass:IsValid() then
            local Comp = Player:GetComponentByClass(NetClass)
            if Comp and Comp:IsValid() then
                return Comp
            end
        end
    end

    return nil
end

local function GetSuitabilityIntFromResearchId(ResearchIdStr)
    if not ResearchIdStr then return nil end
    local str = string.lower(ResearchIdStr)

    if string.find(str, "flame") or string.find(str, "fire") then return 1 end
    if string.find(str, "water") then return 2 end
    if string.find(str, "seed") or string.find(str, "plant") then return 3 end
    if string.find(str, "electric") or string.find(str, "energy") or string.find(str, "generate") then return 4 end
    if string.find(str, "handcraft") or string.find(str, "hand") then return 5 end
    if string.find(str, "collect") then return 6 end
    if string.find(str, "deforest") or string.find(str, "wood") or string.find(str, "lumber") then return 7 end
    if string.find(str, "mine") or string.find(str, "mining") then return 8 end
    if string.find(str, "oil") then return 9 end
    if string.find(str, "medicine") or string.find(str, "pharm") then return 10 end
    if string.find(str, "cool") or string.find(str, "ice") then return 11 end

    return nil
end

local function GetBreedFarmWorkIds()
    local breedWorkIds = {}
    local breedFarms = nil
    pcall(function() breedFarms = FindAllOf("PalMapObjectBreedFarmModel") end)
    if breedFarms then
        for _, farm in ipairs(breedFarms) do
            if farm and farm:IsValid() then
                pcall(function()
                    local workee = farm:GetWorkeeModule() or farm.WorkeeModuleCache
                    if workee and workee:IsValid() then
                        local work = nil
                        if workee.GetWork then work = workee:GetWork() end
                        if not (work and work:IsValid()) and workee.TargetWork then work = workee.TargetWork end
                        if work and work:IsValid() then
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
    if not Handle or not Handle:IsValid() then return false end

    local actor = nil
    pcall(function() actor = Handle:TryGetIndividualActor() end)
    if not actor or not actor:IsValid() then return false end

    local paramComp = nil
    pcall(function() paramComp = actor.CharacterParameterComponent end)
    if not paramComp or not paramComp:IsValid() then
        local compClass = StaticFindObject("/Script/Pal.PalCharacterParameterComponent")
        if compClass and compClass:IsValid() and actor.GetComponentByClass then
            pcall(function() paramComp = actor:GetComponentByClass(compClass) end)
        end
    end

    if not paramComp or not paramComp:IsValid() then return false end

    local isBreed = false
    pcall(function()
        local work = paramComp:GetWork()
        if work and work:IsValid() then
            local wt = work.OverrideWorkType
            if wt == 25 or (wt and string.find(tostring(wt), "BreedFarm")) then
                isBreed = true
                return
            end
            local ownerModel = work.CachedOwnerMapObjectConcreteModel
            if ownerModel and ownerModel:IsValid() then
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

local function GetPalCurrentAssignmentInfo(Handle)
    if not Handle or not Handle:IsValid() then return false, nil end

    local Actor = nil
    pcall(function() Actor = Handle:TryGetIndividualActor() end)
    if not Actor or not Actor:IsValid() then
        return false, nil
    end

    local ParamComp = nil
    pcall(function() ParamComp = Actor.CharacterParameterComponent end)
    if not ParamComp or not ParamComp:IsValid() then
        local CompClass = StaticFindObject("/Script/Pal.PalCharacterParameterComponent")
        if CompClass and CompClass:IsValid() and Actor.GetComponentByClass then
            pcall(function() ParamComp = Actor:GetComponentByClass(CompClass) end)
        end
    end

    if not ParamComp or not ParamComp:IsValid() then
        return false, nil
    end

    local bIsFixed = false
    local CurrentWorkId = nil

    pcall(function() bIsFixed = ParamComp:IsAssignedFixed() end)
    pcall(function() CurrentWorkId = ParamComp:GetWorkId() end)

    return bIsFixed, CurrentWorkId
end

local function RestorePalAssignment(LabKey)
    if not LabKey or not ActiveLabAssignments[LabKey] then return end

    local LabData = ActiveLabAssignments[LabKey]
    ActiveLabAssignments[LabKey] = nil

    local PalKey = LabData.PalKey
    local SavedState = SavedPalAssignments[PalKey]
    SavedPalAssignments[PalKey] = nil

    local NetComp = GetLiveNetworkComponent()
    if not NetComp or not NetComp:IsValid() then
        print("[AutoLab] Error: NetworkComponent not found during Pal restoration.")
        return
    end

    local BaseCampId = LabData.BaseCampId
    local LabWorkId = LabData.LabWorkId
    local PalId = LabData.PalIndividualId

    if SavedState and SavedState.bWasFixed and SavedState.WorkId then
        print(string.format("[AutoLab] Restoring Pal %s back to previous Fixed Assign WorkId: %s", tostring(PalKey), GuidToString(SavedState.WorkId)))
        pcall(function()
            NetComp:RequestFixedAssignWorkInBaseCamp_ToServer(BaseCampId, SavedState.WorkId, PalId)
        end)
    else
        print(string.format("[AutoLab] Pal %s was free-roaming before. Removing Lab lock (Unassign)...", tostring(PalKey)))
        pcall(function()
            NetComp:RequestUnassignWorkInBaseCamp_ToServer(BaseCampId, LabWorkId, PalId)
        end)
    end
end

local function AutoAssignBestPalForResearch(LabModel)
    if not LabModel or not LabModel:IsValid() then return end

    local LabKey = GetLabKey(LabModel)
    local ResearchId = LabModel.CurrentResearchId

    if not ResearchId or ResearchId:ToString() == "None" or ResearchId:ToString() == "" then
        print("[AutoLab] Research idle or cancelled. Releasing assigned Pal...")
        RestorePalAssignment(LabKey)
        return
    end

    local ResearchStr = ResearchId:ToString()
    print("[AutoLab] Found research: " .. ResearchStr)

    local BaseCampId = nil
    pcall(function() BaseCampId = LabModel:GetBaseCampIdBelongTo() end)
    if not BaseCampId then return end

    local WorkeeModule = nil
    pcall(function() WorkeeModule = LabModel:GetWorkeeModule() end)
    if not WorkeeModule or not WorkeeModule:IsValid() then
        WorkeeModule = LabModel.WorkeeModuleCache
    end
    if not WorkeeModule or not WorkeeModule:IsValid() then return end

    local WorkBase = nil
    pcall(function()
        if WorkeeModule.GetWork then WorkBase = WorkeeModule:GetWork() end
        if not WorkBase and WorkeeModule.GetWorkBase then WorkBase = WorkeeModule:GetWorkBase() end
        if not WorkBase and WorkeeModule.Work then WorkBase = WorkeeModule.Work end
    end)

    local LabWorkId = nil
    if WorkBase and WorkBase:IsValid() then
        pcall(function() LabWorkId = WorkBase:GetWorkId() end)
        if not LabWorkId and WorkBase.WorkId then LabWorkId = WorkBase.WorkId end
    end
    if not LabWorkId and WorkeeModule.GetWorkId then
        pcall(function() LabWorkId = WorkeeModule:GetWorkId() end)
    end

    if not LabWorkId then
        print("[AutoLab] Error: Failed to get LabWorkId.")
        return
    end

    local SuitabilityInt = GetSuitabilityIntFromResearchId(ResearchStr)
    if not SuitabilityInt then
        print("[AutoLab] Warning: Could not map research ID '" .. ResearchStr .. "' to suitability.")
        return
    end

    local BaseCamp = nil
    pcall(function() BaseCamp = LabModel:GetBaseCampModelBelongTo() end)
    if not BaseCamp or not BaseCamp:IsValid() then return end

    local WorkerDirector = BaseCamp.WorkerDirector
    if not WorkerDirector or not WorkerDirector:IsValid() then return end

    local RawSlots = {}
    pcall(function() WorkerDirector:GetCharacterHandleSlots(RawSlots) end)
    if not RawSlots or #RawSlots == 0 then return end

    local BestIndividualId = nil
    local BestHandle = nil
    local BestRank = 0

    local breedWorkIds = GetBreedFarmWorkIds()

    for i = 1, #RawSlots do
        local SlotWrapper = RawSlots[i]
        local Slot = SlotWrapper
        if SlotWrapper and SlotWrapper.get then
            pcall(function() Slot = SlotWrapper:get() end)
        end

        if Slot and Slot:IsValid() then
            local isSlotEmpty = true
            pcall(function() isSlotEmpty = Slot:IsEmpty() end)

            if not isSlotEmpty then
                local Handle = nil
                pcall(function()
                    if Slot.GetHandle then Handle = Slot:GetHandle() end
                    if not Handle and Slot.Handle then Handle = Slot.Handle end
                end)
                if Handle and Handle.get then
                    pcall(function() Handle = Handle:get() end)
                end

                local isBreeding = false
                if Handle and Handle:IsValid() then
                    isBreeding = IsPalInBreedFarm(Handle, breedWorkIds)
                end

                if not isBreeding then
                    local IndivId = nil
                    local Param = nil

                    if Handle and Handle:IsValid() then
                        pcall(function() IndivId = Handle:GetIndividualID() end)
                        if not IndivId then IndivId = Handle.ID end
                        pcall(function() Param = Handle:TryGetIndividualParameter() end)
                    end

                    if not IndivId then IndivId = Slot.ReplicateHandleID end
                    if not Param then Param = Slot.ReplicateIndividualParameter end

                    if IndivId and Param and Param:IsValid() then
                        local PalRank = 0
                        pcall(function()
                            PalRank = Param:GetWorkSuitabilityRank(SuitabilityInt)
                        end)

                        if PalRank > BestRank then
                            BestRank = PalRank
                            BestIndividualId = IndivId
                            BestHandle = Handle
                        end
                    end
                end
            end
        end
    end

    if BestIndividualId then
        local PalKey = GetPalKey(BestIndividualId)

        if ActiveLabAssignments[LabKey] and ActiveLabAssignments[LabKey].PalKey ~= PalKey then
            RestorePalAssignment(LabKey)
        end

        local bWasFixed, PrevWorkId = false, nil
        if BestHandle and BestHandle:IsValid() then
            bWasFixed, PrevWorkId = GetPalCurrentAssignmentInfo(BestHandle)
        end

        if not SavedPalAssignments[PalKey] then
            SavedPalAssignments[PalKey] = {
                BaseCampId = BaseCampId,
                WorkId = PrevWorkId,
                bWasFixed = bWasFixed
            }
            print(string.format("[AutoLab] Saved Pal state: Fixed=%s, PrevWorkId=%s", tostring(bWasFixed), GuidToString(PrevWorkId)))
        end

        ActiveLabAssignments[LabKey] = {
            PalIndividualId = BestIndividualId,
            LabWorkId = LabWorkId,
            BaseCampId = BaseCampId,
            PalKey = PalKey
        }

        local NetComp = GetLiveNetworkComponent()
        if NetComp and NetComp:IsValid() then
            local okNet = pcall(function()
                NetComp:RequestFixedAssignWorkInBaseCamp_ToServer(BaseCampId, LabWorkId, BestIndividualId)
            end)
            if okNet then
                print(string.format("[AutoLab] Assigned Pal (Suitability Lvl %d) to Research Lab!", BestRank))
            end
        end
    end
end

local isWaitingForPals = false

local function ProcessAllLabsOnLoad()
    local LabModels = FindAllOf("PalMapObjectLabModel")
    if not LabModels or #LabModels == 0 then return end

    for _, LabModel in ipairs(LabModels) do
        if LabModel and LabModel:IsValid() then
            local ResearchId = LabModel.CurrentResearchId
            if ResearchId and ResearchId:ToString() ~= "None" and ResearchId:ToString() ~= "" then
                AutoAssignBestPalForResearch(LabModel)
            end
        end
    end
end

local function OnPlayerWorldLoad()
    if isWaitingForPals then return end
    isWaitingForPals = true

    ExecuteWithDelay(15000, function()
        ExecuteInGameThread(function()
            ProcessAllLabsOnLoad()
        end)
    end)

    ExecuteWithDelay(30000, function()
        isWaitingForPals = false
        ExecuteInGameThread(function()
            ProcessAllLabsOnLoad()
        end)
    end)
end

RegisterHook("/Script/Engine.PlayerController:ClientRestart", function(self, NewPawn)
    OnPlayerWorldLoad()
end)

RegisterHook("/Script/Pal.PalMapObjectLabModel:OnRep_CurrentResearchId", function(self)
    local labModel = self:get()
    if labModel and labModel:IsValid() then
        ExecuteInGameThread(function()
            AutoAssignBestPalForResearch(labModel)
        end)
    end
end)

RegisterHook("/Script/Pal.PalMapObjectLabModel:OnUpdateCurrentResearch_ServerInternal", function(self)
    local labModel = self:get()
    if labModel and labModel:IsValid() then
        ExecuteInGameThread(function()
            AutoAssignBestPalForResearch(labModel)
        end)
    end
end)

RegisterHook("/Script/Pal.PalMapObjectLabModel:OnFinishResearchWork_ServerInternal", function(self, Work)
    local labModel = self:get()
    if labModel and labModel:IsValid() then
        local LabKey = GetLabKey(labModel)
        ExecuteInGameThread(function()
            print("[AutoLab] Research completed on server! Returning Pal...")
            RestorePalAssignment(LabKey)
        end)
    end
end)

RegisterHook("/Script/Pal.PalUIChat:OnReceivedChat", function(context, message)
    local received = message:get()
    if received and received.Message then
        local msgText = received.Message:ToString()
        if string.lower(msgText) == Config.ChatCommand then
            print("[AutoLab] Manual trigger requested via chat command (" .. Config.ChatCommand .. ")")
            ExecuteInGameThread(function()
                ProcessAllLabsOnLoad()
            end)
        end
    end
end)

print("[AutoLabAssign] Mod loaded successfully with Smart Return & Breed Protection! Command: !lab")
