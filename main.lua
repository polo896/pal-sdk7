-- ================= By Wol4ara896 =================
--          STATION SWITCH
-- ===================================================

local UEHelpers = require("UEHelpers")
local stationUI = require("station_ui")

local Config = {
    HotkeyToggle = Key.F6,
    HotkeyGUI    = Key.F7,
    SaveFileName = "station_switch_data.txt",
    EnableChatToast = true,
    SenderName = "StationSwitch",
    RaycastDistance = 5000.0,
    Debug = false
}

local PausedStations = {}

local function DebugPrint(text)
    if Config.Debug then
        pcall(function() print("[StationSwitch][Debug] " .. tostring(text) .. "\n") end)
    end
end

local function SafeIsValid(obj)
    if not obj then return false end
    if type(obj) == "userdata" or type(obj) == "table" then
        if obj.IsValid and type(obj.IsValid) == "function" then
            local ok, valid = pcall(function() return obj:IsValid() end)
            return ok and valid
        end
        return true
    end
    return false
end

local function GetLocalPlayerController()
    return UEHelpers:GetPlayerController()
end

local function GetLocalPlayerCharacter()
    local pc = GetLocalPlayerController()
    if SafeIsValid(pc) then return pc.Pawn or pc.Character end
    return nil
end

local function ShowToast(text)
    if not Config.EnableChatToast then return end
    pcall(function()
        ExecuteInGameThread(function()
            local util = StaticFindObject("/Script/Pal.Default__PalUtility")
            local pc = GetLocalPlayerController()
            local ctx = (pc and pc.Pawn) and pc.Pawn or pc
            if util and SafeIsValid(util) and SafeIsValid(ctx) then
                util:SendSystemAnnounce(ctx, text)
            end
        end)
    end)
end

local function GuidToKey(guid)
    if not guid then return "" end
    local a = guid.A or 0
    local b = guid.B or 0
    local c = guid.C or 0
    local d = guid.D or 0
    if a == 0 and b == 0 and c == 0 and d == 0 then return "" end
    return string.format("%d,%d,%d,%d", a, b, c, d)
end

local function SavePausedStationsToDisk()
    pcall(function()
        local file = io.open(Config.SaveFileName, "w")
        if not file then return end

        for _, data in pairs(PausedStations) do
            local name = data.Name or "Workstation"
            local origId = data.OrigDefineId or "None"
            file:write(string.format("%d,%d,%d,%d=%s|%s\n", data.A or 0, data.B or 0, data.C or 0, data.D or 0, name, origId))
        end
        file:close()
        DebugPrint("Saved paused stations to file: " .. tostring(Config.SaveFileName))
    end)
end

local function LoadPausedStationsFromDisk()
    local file = io.open(Config.SaveFileName, "r")
    if not file then return end

    PausedStations = {}
    local count = 0
    for rawLine in file:lines() do
        local line = rawLine:gsub("\r", ""):gsub("%s+", "")
        local a, b, c, d, rest = line:match("^(%-?%d+),(%-?%d+),(%-?%d+),(%-?%d+)=(.*)$")
        if a and b and c and d and rest then
            local name, origId = rest:match("^(.-)|(.*)$")
            if not name then name = rest; origId = "None" end
            local key = string.format("%d,%d,%d,%d", tonumber(a), tonumber(b), tonumber(c), tonumber(d))
            PausedStations[key] = {
                A = tonumber(a),
                B = tonumber(b),
                C = tonumber(c),
                D = tonumber(d),
                Name = (name and name ~= "") and name or "Workstation",
                OrigDefineId = (origId and origId ~= "") and origId or "None"
            }
            count = count + 1
        end
    end
    file:close()
    print("[StationSwitch] Loaded paused stations from disk: " .. tostring(count))
end

local function SetStationState(Workee, Work, Concrete, bPaused, StationKey)
    if not SafeIsValid(Work) then return end

    if bPaused then
        pcall(function()
            if Work.AssignDefineDataId then
                local currentId = Work.AssignDefineDataId:ToString()
                if currentId and currentId ~= "" and currentId ~= "None" then
                    if StationKey and PausedStations[StationKey] then
                        PausedStations[StationKey].OrigDefineId = currentId
                    end
                end
                Work.AssignDefineDataId = FName("None")
            end
        end)

        Work.AssignableFixedType = 3
        Work.CurrentState = 2
        Work.bAssignableOtomo = false
        Work.bCanStealAssign = false
        Work.bCanTriggerWorkerEvent = false
        pcall(function() Work:OnRep_CurrentState() end)

        if SafeIsValid(Workee) then
            pcall(function()
                Workee.bCannotApproachByWork = true
                Workee:OnRep_CannotApproachByWork()
            end)
        end

        if SafeIsValid(Concrete) then
            pcall(function()
                local switchMod = Concrete:GetSwitchModule()
                if SafeIsValid(switchMod) then
                    switchMod.SwitchState = 1
                    switchMod:OnRep_SwitchState()
                end
            end)
        end
    else
        pcall(function()
            local origId = nil
            if StationKey and PausedStations[StationKey] and PausedStations[StationKey].OrigDefineId then
                origId = PausedStations[StationKey].OrigDefineId
            end

            if origId and origId ~= "" and origId ~= "None" then
                Work.AssignDefineDataId = FName(origId)
            end
        end)

        Work.AssignableFixedType = 0
        Work.CurrentState = 1
        Work.bAssignableOtomo = true
        Work.bCanStealAssign = true
        Work.bCanTriggerWorkerEvent = true
        pcall(function() Work:OnRep_CurrentState() end)

        if SafeIsValid(Workee) then
            pcall(function()
                Workee.bCannotApproachByWork = false
                Workee:OnRep_CannotApproachByWork()
            end)
        end

        if SafeIsValid(Concrete) then
            pcall(function()
                local switchMod = Concrete:GetSwitchModule()
                if SafeIsValid(switchMod) then
                    switchMod.SwitchState = 0
                    switchMod:OnRep_SwitchState()
                end
            end)
        end
    end
end

local function CategorizeWorkstation(name, modelId)
    local s = (tostring(name) .. " " .. tostring(modelId)):lower()
    if s:find("stone") or s:find("rock") or s:find("ore") or s:find("mine") or s:find("mining") then return "mining" end
    if s:find("wood") or s:find("log") or s:find("tree") or s:find("lumber") then return "logging" end
    if s:find("farm") or s:find("plant") or s:find("berry") or s:find("wheat") or s:find("tomato") or s:find("lettuce") then return "farm" end
    if s:find("craft") or s:find("bench") or s:find("forge") or s:find("furnace") or s:find("sphere") or s:find("assembly") or s:find("weapon") or s:find("medicine") or s:find("cook") or s:find("kitchen") then return "crafting" end
    if s:find("ranch") or s:find("breed") or s:find("pasture") then return "ranch" end
    return "other"
end

local function FormatCleanName(rawName)
    local s = tostring(rawName or "Workstation"):gsub(".*::", ""):gsub("^PalMapObject_", ""):gsub("^MapObject_", ""):gsub("_C$", "")
    s = s:gsub("(%a)([%w]*)", function(f, r) return f:upper() .. r:lower() end)
    return s
end

local function ScanBaseWorkstations()
    local results = {}
    local seenKeys = {}
    local seenModels = {}

    local mapObjects = FindAllOf("PalMapObjectModel") or {}
    for _, model in ipairs(mapObjects) do
        if SafeIsValid(model) then
            local modelGuid = model.InstanceId
            local kModel = GuidToKey(modelGuid)
            local modelAddr = tostring(model)

            if kModel ~= "" and not seenModels[kModel] and not seenModels[modelAddr] then
                seenModels[kModel] = true
                seenModels[modelAddr] = true

                local concrete = model:GetConcreteModel(false)
                if SafeIsValid(concrete) then
                    local workee = concrete:GetWorkeeModule()
                    local work = SafeIsValid(workee) and workee:GetWork() or nil
                    if SafeIsValid(work) then
                        local k1 = kModel
                        local k2 = GuidToKey(concrete.InstanceId or model.ConcreteModelInstanceId)
                        local k3 = GuidToKey(work.ID)
                        local primaryKey = (k1 ~= "") and k1 or ((k2 ~= "") and k2 or k3)

                        if primaryKey ~= "" then
                            if k1 ~= "" then seenKeys[k1] = true end
                            if k2 ~= "" then seenKeys[k2] = true end
                            if k3 ~= "" then seenKeys[k3] = true end
                            seenKeys[primaryKey] = true

                            local stName = "Workstation"
                            local modelId = "Station"
                            local defineId = "None"

                            pcall(function()
                                if work.GetWorkName then
                                    local wn = work:GetWorkName():ToString()
                                    if wn and wn ~= "" and wn ~= "None" then stName = wn end
                                end
                                if model.MapObjectMasterDataId then
                                    modelId = model.MapObjectMasterDataId:ToString()
                                    if stName == "Workstation" then stName = modelId end
                                end
                                if work.AssignDefineDataId then
                                    local did = work.AssignDefineDataId:ToString()
                                    if did and did ~= "" and did ~= "None" then
                                        defineId = did
                                    end
                                end
                            end)

                            if defineId == "None" then
                                local saved = PausedStations[k1] or PausedStations[k2] or PausedStations[k3] or PausedStations[primaryKey]
                                if saved and saved.OrigDefineId and saved.OrigDefineId ~= "None" then
                                    defineId = saved.OrigDefineId
                                end
                            end

                            local isPaused = (PausedStations[k1] ~= nil) or (PausedStations[k2] ~= nil) or (PausedStations[k3] ~= nil) or (PausedStations[primaryKey] ~= nil)

                            table.insert(results, {
                                key         = primaryKey,
                                key1        = k1,
                                key2        = k2,
                                key3        = k3,
                                guid        = modelGuid,
                                name        = FormatCleanName(stName),
                                modelId     = modelId,
                                origDefineId= defineId,
                                category    = CategorizeWorkstation(stName, modelId),
                                isPaused    = isPaused,
                                model       = model,
                                concrete    = concrete,
                                workee      = workee,
                                work        = work,
                            })
                        end
                    end
                end
            end
        end
    end

    local seenOfflineGuids = {}
    for k, data in pairs(PausedStations) do
        if not seenKeys[k] then
            seenKeys[k] = true
            local guidKey = string.format("%d,%d,%d,%d", data.A or 0, data.B or 0, data.C or 0, data.D or 0)
            if guidKey == "0,0,0,0" or not seenOfflineGuids[guidKey] then
                if guidKey ~= "0,0,0,0" then seenOfflineGuids[guidKey] = true end

                table.insert(results, {
                    key         = k,
                    key1        = k,
                    name        = FormatCleanName(data.Name or "Offline Workstation"),
                    modelId     = "Saved",
                    origDefineId= data.OrigDefineId or "None",
                    category    = CategorizeWorkstation(data.Name, ""),
                    isPaused    = true,
                    model       = nil,
                })
            end
        end
    end

    return results
end

local function ExtractActorFromHitResult(HitResult)
    if not HitResult then return nil end
    local Actor = nil
    pcall(function()
        if HitResult.Actor then
            Actor = (type(HitResult.Actor.get) == "function" and HitResult.Actor:get()) or HitResult.Actor
        end
    end)
    return SafeIsValid(Actor) and Actor or nil
end

local function GetTargetStationObjects()
    local character = GetLocalPlayerCharacter()
    if not SafeIsValid(character) then return nil, nil, nil, nil, nil end

    local mapObj = nil
    local interactComp = character.InteractComponent
    if SafeIsValid(interactComp) then
        local targetInteractive = interactComp.TargetInteractiveObject
        if SafeIsValid(targetInteractive) then
            local owner = targetInteractive:GetOwner()
            if SafeIsValid(owner) and owner:IsA("/Script/Pal.PalMapObject") then mapObj = owner end
        end
    end

    if not SafeIsValid(mapObj) then
        local pc = GetLocalPlayerController()
        if SafeIsValid(pc) and SafeIsValid(pc.PlayerCameraManager) then
            local camLoc = pc.PlayerCameraManager:GetCameraLocation()
            local camRot = pc.PlayerCameraManager:GetCameraRotation()
            local mathLib = StaticFindObject("/Script/Engine.Default__KismetMathLibrary")
            local sysLib = StaticFindObject("/Script/Engine.Default__KismetSystemLibrary")

            if SafeIsValid(mathLib) and SafeIsValid(sysLib) then
                local forward = mathLib:GetForwardVector(camRot)
                local endLoc = {
                    X = camLoc.X + (forward.X * Config.RaycastDistance),
                    Y = camLoc.Y + (forward.Y * Config.RaycastDistance),
                    Z = camLoc.Z + (forward.Z * Config.RaycastDistance)
                }

                local hitResult = {}
                local ignoreActors = { character }
                local bHit = sysLib:LineTraceSingle(pc, camLoc, endLoc, 0, false, ignoreActors, 0, hitResult, true, {R=1,G=0,B=0,A=1}, {R=0,G=1,B=0,A=1}, 0.0)
                local hitActor = ExtractActorFromHitResult(hitResult)
                if bHit and SafeIsValid(hitActor) then
                    if hitActor:IsA("/Script/Pal.PalMapObject") then mapObj = hitActor
                    else
                        local owner = hitActor:GetOwner()
                        if SafeIsValid(owner) and owner:IsA("/Script/Pal.PalMapObject") then mapObj = owner end
                    end
                end
            end
        end
    end

    if not SafeIsValid(mapObj) then return nil, nil, nil, nil, nil end
    local model = mapObj:GetModel()
    if not SafeIsValid(model) then return nil, nil, nil, nil, nil end
    local concrete = model:GetConcreteModel(true)
    if not SafeIsValid(concrete) then return nil, nil, nil, nil, nil end
    local workee = concrete:GetWorkeeModule()
    local work = SafeIsValid(workee) and workee:GetWork() or nil

    return mapObj, model, concrete, workee, work
end

local function ToggleStation()
    local mapObj, model, concrete, workee, work = GetTargetStationObjects()
    if not SafeIsValid(mapObj) or not SafeIsValid(model) then ShowToast("Look directly at a workstation!"); return end
    if not SafeIsValid(work) then ShowToast("This building is not a workstation."); return end

    local g1 = model.InstanceId
    local g2 = concrete.InstanceId or model.ConcreteModelInstanceId
    local g3 = work.ID

    local k1 = GuidToKey(g1)
    local k2 = GuidToKey(g2)
    local k3 = GuidToKey(g3)
    if k1 == "" and k2 == "" and k3 == "" then ShowToast("Error: Failed to get GUID."); return end

    local stationName = "Workstation"
    local defineId = "None"
    pcall(function()
        local wName = work:GetWorkName():ToString()
        if wName and wName ~= "" and wName ~= "None" then stationName = wName
        elseif model.MapObjectMasterDataId then stationName = model.MapObjectMasterDataId:ToString() end
        if work.AssignDefineDataId then defineId = work.AssignDefineDataId:ToString() end
    end)

    local isPaused = (PausedStations[k1] ~= nil) or (PausedStations[k2] ~= nil) or (PausedStations[k3] ~= nil)
    local willPause = not isPaused
    local primaryKey = (k1 ~= "") and k1 or ((k2 ~= "") and k2 or k3)

    if willPause then
        local entry = { A = g1.A or 0, B = g1.B or 0, C = g1.C or 0, D = g1.D or 0, Name = stationName, OrigDefineId = defineId }
        if k1 ~= "" then PausedStations[k1] = entry end
        if k2 ~= "" then PausedStations[k2] = entry end
        if k3 ~= "" then PausedStations[k3] = entry end
        SetStationState(workee, work, concrete, true, primaryKey)
        SavePausedStationsToDisk()
        ShowToast(string.format("%s: PAUSED [Offline]", stationName))
    else
        SetStationState(workee, work, concrete, false, primaryKey)
        if k1 ~= "" then PausedStations[k1] = nil end
        if k2 ~= "" then PausedStations[k2] = nil end
        if k3 ~= "" then PausedStations[k3] = nil end
        SavePausedStationsToDisk()
        ShowToast(string.format("%s: ACTIVE [Online]", stationName))
    end
end

local function ToggleItemFromUI(item, onDone)
    if not item then return end
    local willPause = not item.isPaused
    local pk = item.key

    local model = item.model
    local concrete = item.concrete
    local workee = item.workee
    local work = item.work

    if SafeIsValid(model) and (not SafeIsValid(concrete) or not SafeIsValid(work)) then
        concrete = model:GetConcreteModel(true)
        if SafeIsValid(concrete) then
            workee = concrete:GetWorkeeModule()
            work = SafeIsValid(workee) and workee:GetWork() or nil
        end
    end

    local defId = "None"
    if SafeIsValid(work) and work.AssignDefineDataId then
        local cid = work.AssignDefineDataId:ToString()
        if cid and cid ~= "" and cid ~= "None" then defId = cid end
    end
    if defId == "None" and item.origDefineId and item.origDefineId ~= "None" then
        defId = item.origDefineId
    end

    if willPause then
        local entry = {
            A = (item.guid and item.guid.A) or 0,
            B = (item.guid and item.guid.B) or 0,
            C = (item.guid and item.guid.C) or 0,
            D = (item.guid and item.guid.D) or 0,
            Name = item.name,
            OrigDefineId = defId
        }
        if pk ~= "" then PausedStations[pk] = entry end
        if item.key1 and item.key1 ~= "" then PausedStations[item.key1] = entry end
        if item.key2 and item.key2 ~= "" then PausedStations[item.key2] = entry end
        if item.key3 and item.key3 ~= "" then PausedStations[item.key3] = entry end
        item.isPaused = true
    else
        item.isPaused = false
    end

    ExecuteInGameThread(function()
        if willPause then
            if SafeIsValid(work) then
                SetStationState(workee, work, concrete, true, pk)
            end
            SavePausedStationsToDisk()
            ShowToast(string.format("%s: PAUSED [Offline]", item.name))
        else
            if SafeIsValid(work) then
                SetStationState(workee, work, concrete, false, pk)
            end

            if item.key1 and item.key1 ~= "" then PausedStations[item.key1] = nil end
            if item.key2 and item.key2 ~= "" then PausedStations[item.key2] = nil end
            if item.key3 and item.key3 ~= "" then PausedStations[item.key3] = nil end
            if pk ~= "" then PausedStations[pk] = nil end

            if item.guid and (item.guid.A ~= 0 or item.guid.B ~= 0) then
                for k, v in pairs(PausedStations) do
                    if v.A == item.guid.A and v.B == item.guid.B and v.C == item.guid.C and v.D == item.guid.D then
                        PausedStations[k] = nil
                    end
                end
            end

            SavePausedStationsToDisk()
            ShowToast(string.format("%s: ACTIVE [Online]", item.name))
        end

        if onDone then pcall(onDone) end
    end)
end

local function ResumeAllStations(onDone)
    local all = ScanBaseWorkstations()
    local count = 0

    ExecuteInGameThread(function()
        for _, s in ipairs(all) do
            if s.isPaused then
                local model = s.model
                local concrete = s.concrete
                local workee = s.workee
                local work = s.work
                if SafeIsValid(model) and (not SafeIsValid(concrete) or not SafeIsValid(work)) then
                    concrete = model:GetConcreteModel(true)
                    if SafeIsValid(concrete) then
                        workee = concrete:GetWorkeeModule()
                        work = SafeIsValid(workee) and workee:GetWork() or nil
                    end
                end
                if SafeIsValid(work) then
                    SetStationState(workee, work, concrete, false, s.key)
                end
                count = count + 1
            end
        end
        PausedStations = {}
        SavePausedStationsToDisk()
        ShowToast(string.format("Resumed all %d workstations!", count))
        if onDone then pcall(onDone) end
    end)
end

local function PauseCategoryBatch(catList, onDone)
    local all = ScanBaseWorkstations()
    local count = 0

    for _, s in ipairs(all) do
        for _, cat in ipairs(catList) do
            if s.category == cat and not s.isPaused then
                local defId = s.origDefineId or "None"
                local entry = { Name = s.name, OrigDefineId = defId }
                if s.key ~= "" then PausedStations[s.key] = entry end
                if s.key1 and s.key1 ~= "" then PausedStations[s.key1] = entry end
                if s.key2 and s.key2 ~= "" then PausedStations[s.key2] = entry end
                if s.key3 and s.key3 ~= "" then PausedStations[s.key3] = entry end
                s.isPaused = true
                count = count + 1
                break
            end
        end
    end

    ExecuteInGameThread(function()
        for _, s in ipairs(all) do
            for _, cat in ipairs(catList) do
                if s.category == cat and s.isPaused then
                    local model = s.model
                    local concrete = s.concrete
                    local workee = s.workee
                    local work = s.work
                    if SafeIsValid(model) and (not SafeIsValid(concrete) or not SafeIsValid(work)) then
                        concrete = model:GetConcreteModel(true)
                        if SafeIsValid(concrete) then
                            workee = concrete:GetWorkeeModule()
                            work = SafeIsValid(workee) and workee:GetWork() or nil
                        end
                    end
                    if SafeIsValid(work) then
                        SetStationState(workee, work, concrete, true, s.key)
                    end
                    break
                end
            end
        end
        SavePausedStationsToDisk()
        ShowToast(string.format("Paused %d station(s) in category!", count))
        if onDone then pcall(onDone) end
    end)
end

local function OpenControlGUI()
    if stationUI.is_visible() then
        stationUI.close()
        return
    end

    local uiContext = {
        config            = Config,
        getStations       = ScanBaseWorkstations,
        onToggleItem      = ToggleItemFromUI,
        onResumeAll       = ResumeAllStations,
        onPauseMiningWood = function(cb) PauseCategoryBatch({"mining", "logging"}, cb) end,
        onPauseFarms      = function(cb) PauseCategoryBatch({"farm", "ranch"}, cb) end,
    }
    stationUI.show(uiContext)
end

local function CheckAndApplyStationPause(workee)
    if not SafeIsValid(workee) then return end
    local work = workee:GetWork()
    if not SafeIsValid(work) then return end

    local k1 = GuidToKey(work.OwnerMapObjectModelId)
    local k2 = GuidToKey(work.OwnerMapObjectConcreteModelId)
    local k3 = GuidToKey(work.ID)

    local targetKey = nil
    if k1 ~= "" and PausedStations[k1] then targetKey = k1
    elseif k2 ~= "" and PausedStations[k2] then targetKey = k2
    elseif k3 ~= "" and PausedStations[k3] then targetKey = k3
    end

    if targetKey then
        local concrete = work.CachedOwnerMapObjectConcreteModel
        SetStationState(workee, work, concrete, true, targetKey)
    end
end

RegisterHook("/Script/Pal.PalMapObjectWorkeeModule:OnRep_TargetWork", function(Context)
    pcall(function() CheckAndApplyStationPause(Context:get()) end)
end)

RegisterHook("/Script/Pal.PalMapObjectWorkeeModule:CallOrRegisterOnReadyWork", function(Context)
    pcall(function() CheckAndApplyStationPause(Context:get()) end)
end)

pcall(function()
    RegisterHook("/Script/Pal.PalUIChat:OnReceivedChat", function(context, message)
        if not message then return end
        local received = message:get()
        if not received or not received.Message then return end
        local text = received.Message:ToString():lower():gsub("^%s+", ""):gsub("%s+$", "")
        if text == "!station" or text == "!ss" or text == "!stations" or text == "!switch" then
            OpenControlGUI()
        end
    end)
end)

local function Init()
    LoadPausedStationsFromDisk()

    RegisterKeyBind(Config.HotkeyToggle, function()
        ExecuteInGameThread(function() pcall(ToggleStation) end)
    end)

    RegisterKeyBind(Config.HotkeyGUI, function()
        pcall(OpenControlGUI)
    end)

    RegisterKeyBind(Key.ESCAPE, function()
        pcall(function()
            if stationUI.is_visible() then stationUI.close() end
        end)
    end)

    print("[StationSwitch] Loaded! Press F6 to toggle looked-at station, F7 for Control Hub GUI.")
end

Init()

