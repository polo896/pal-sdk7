-- By Wol4ara896
local COLLECT_RADIUS = 0
local RESTORE_DELAY_MS = 3000

local CMD_COLLECT_NORMAL = "!collectnotes"
local CMD_COLLECT_NOEXP  = "!collectnotesnoexp"
local CMD_RESTORE        = "!restore"

local pendingRestoreRate = nil

local function GetOptionSubsystem()
    local instances = FindAllOf("PalOptionSubsystem")
    if instances and #instances > 0 then
        for _, inst in ipairs(instances) do
            if inst and inst:IsValid() then
                return inst
            end
        end
    end
    return nil
end

local function SetExpRate(rate)
    local subsystem = GetOptionSubsystem()
    if not subsystem then
        return false
    end
    local ok = pcall(function()
        subsystem.OptionWorldSettings.ExpRate = rate
    end)
    return ok
end

local function GetExpRate()
    local subsystem = GetOptionSubsystem()
    if not subsystem then
        return nil
    end
    local ok, value = pcall(function()
        return subsystem.OptionWorldSettings.ExpRate
    end)
    if ok then
        return value
    end
    return nil
end

local function CollectNotes()
    local controllers = FindAllOf("BP_PalPlayerController_C")
    local PlayerController = nil
    
    if controllers then
        for _, c in ipairs(controllers) do
            if c.IsLocalPlayerController and c:IsLocalPlayerController() then
                PlayerController = c
                break
            end
        end
        if not PlayerController and #controllers > 0 then
            PlayerController = controllers[1]
        end
    end

    if not PlayerController or not PlayerController:IsValid() then
        print("[NoteCollector] Error: Player controller not found.")
        return 0
    end

    local Transmitter = PlayerController.Transmitter
    if not Transmitter or not Transmitter:IsValid() then
        print("[NoteCollector] Error: Transmitter not found.")
        return 0
    end

    local PlayerNetwork = Transmitter.Player
    if not PlayerNetwork or not PlayerNetwork:IsValid() then
        print("[NoteCollector] Error: Player network component not found.")
        return 0
    end

    local PlayerPawn = PlayerController.Character
    if not PlayerPawn or not PlayerPawn:IsValid() then
        print("[NoteCollector] Error: Player pawn not found.")
        return 0
    end

    local PlayerLoc = PlayerPawn:K2_GetActorLocation()
    local collectedCount = 0

    local notes = FindAllOf("PalLevelObjectNote")
    if not notes then 
        print("[NoteCollector] Error: No notes found.")
        return 0
    end

    for _, note in ipairs(notes) do
        if note and note:IsValid() then
            if note.bPickedInClient == false then
                local shouldCollect = true
                
                if COLLECT_RADIUS > 0 then
                    local NoteLoc = note:K2_GetActorLocation()
                    local dist = math.sqrt((PlayerLoc.X - NoteLoc.X)^2 + (PlayerLoc.Y - NoteLoc.Y)^2 + (PlayerLoc.Z - NoteLoc.Z)^2)
                    
                    if dist > COLLECT_RADIUS then
                        shouldCollect = false
                    end
                end

                if shouldCollect then
                    PlayerNetwork:RequestObtainLevelObject_ToServer(note)
                    collectedCount = collectedCount + 1
                end
            end
        end
    end

    print("[NoteCollector] Collection requests sent to server: " .. tostring(collectedCount))
    return collectedCount
end

local function CollectNotesNoExp()
    local originalRate = GetExpRate()

    if originalRate == nil then
        print("[NoteCollector] Warning: could not read current EXP rate, collecting with normal EXP gain.")
        CollectNotes()
        return
    end

    local setOk = SetExpRate(0.0)
    if not setOk then
        print("[NoteCollector] Warning: could not set EXP rate to 0, collecting with normal EXP gain.")
        CollectNotes()
        return
    end

    print(string.format("[NoteCollector] EXP rate temporarily set to 0 (was: %.3f)", originalRate))
    pendingRestoreRate = originalRate

    CollectNotes()

    ExecuteWithDelay(RESTORE_DELAY_MS, function()
        if pendingRestoreRate ~= nil then
            local restoreOk = SetExpRate(pendingRestoreRate)
            if restoreOk then
                print(string.format("[NoteCollector] EXP rate restored to %.3f", pendingRestoreRate))
            else
                print(string.format("[NoteCollector] ERROR: failed to restore EXP rate automatically! Use %s to fix manually.", CMD_RESTORE))
            end
            pendingRestoreRate = nil
        end
    end)
end

local function RegisterChatHook()
    local success, err = pcall(function()
        RegisterHook("/Script/Pal.PalUIChat:OnReceivedChat", function(context, message)
            local received = message:get()
            if received and received.Message then
                local text = received.Message:ToString()

                if text == CMD_COLLECT_NORMAL then
                    print("[NoteCollector] Chat command triggered (WITH EXP): " .. text)
                    CollectNotes()

                elseif text == CMD_COLLECT_NOEXP then
                    print("[NoteCollector] Chat command triggered (NO EXP): " .. text)
                    CollectNotesNoExp()

                elseif text == CMD_RESTORE then
                    local rateToRestore = pendingRestoreRate or 1.0
                    if SetExpRate(rateToRestore) then
                        print(string.format("[NoteCollector] EXP rate manually restored to %.3f", rateToRestore))
                    else
                        print("[NoteCollector] ERROR: manual restore failed.")
                    end
                    pendingRestoreRate = nil
                end
            end
        end)
    end)

    if success then
        print(string.format("[NoteCollector] Hook registered! Commands: '%s' (with EXP), '%s' (no EXP), '%s'", CMD_COLLECT_NORMAL, CMD_COLLECT_NOEXP, CMD_RESTORE))
    else
        print("[NoteCollector] Failed to register chat hook: " .. tostring(err))
    end
end

local function Init()
    print("[NoteCollector] Initializing NoteCollector (Unified)...")
    RegisterChatHook()
    print("[NoteCollector] Initialization completed.")
end

Init()