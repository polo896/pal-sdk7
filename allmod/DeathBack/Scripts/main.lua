--[[
    Back To Death Point
    --------------------
         By Wol4ara896
]]

local ModName = "BackToDeath"

-- Set to true to print step-by-step debug info to the UE4SS console.
local DEBUG_MODE = false

-- Chat command that triggers the teleport.
local COMMAND = "!back"

-- Minimum seconds between two uses of the command per player.
local COMMAND_COOLDOWN = 5


local DeathPoints = {}
local LastCommandUse = {}


local function Log(msg)
    print(string.format("[%s] %s", ModName, msg))
end

local function Debug(msg)
    if DEBUG_MODE then
        Log("DEBUG: " .. msg)
    end
end

local function GuidToString(Guid)
    if not Guid then return nil end
    local A = Guid.A or 0
    local B = Guid.B or 0
    local C = Guid.C or 0
    local D = Guid.D or 0
    return string.format("%08X%08X%08X%08X", A, B, C, D)
end

local function GetPalUtility()
    return StaticFindObject("/Script/Pal.Default__PalUtility")
end

local function IsPlayerInDungeon(PlayerCharacter, PalUtility)
    if not PalUtility or not PalUtility:IsValid() then return false end
    local ok, result = pcall(function()
        return PalUtility:IsInsideStage(PlayerCharacter)
    end)
    return ok and result or false
end


RegisterHook("/Script/Pal.PalPlayerCharacter:OnDeadPlayer_Server", function(Context)
    local ok, err = pcall(function()
        local Player = Context:get()
        if not Player or not Player:IsValid() then
            Debug("Invalid player on death hook.")
            return
        end

        local PalUtility = GetPalUtility()

        if IsPlayerInDungeon(Player, PalUtility) then
            Debug("Player died inside a dungeon, skipping save.")
            return
        end

        local ok_gs, PlayerState = pcall(function() return Player:GetCachedPlayerState() end)
        if not ok_gs or not PlayerState or not PlayerState:IsValid() then
            Debug("Could not resolve PlayerState.")
            return
        end

        local uid = GuidToString(PlayerState.PlayerUId)
        if not uid then
            Debug("Could not resolve player UID.")
            return
        end

        local Loc = Player:K2_GetActorLocation()
        local Rot = Player:K2_GetActorRotation()

        DeathPoints[uid] = { X = Loc.X, Y = Loc.Y, Z = Loc.Z, Yaw = Rot.Yaw }

        Debug(string.format("Death point saved (%.1f, %.1f, %.1f)", Loc.X, Loc.Y, Loc.Z))
    end)

    if not ok then
        Log("Error in death hook: " .. tostring(err))
    end
end)


RegisterHook("/Script/Pal.PalPlayerState:EnterChat", function(Context, MsgParam, CategoryParam)
    local ok, err = pcall(function()
        local PlayerState = Context:get()
        if not PlayerState or not PlayerState:IsValid() then return end

        local Msg = MsgParam:get():ToString()
        if not Msg then return end

        local cleanMsg = Msg:gsub("^%s+", ""):gsub("%s+$", ""):lower()
        if cleanMsg ~= COMMAND then return end

        local uid = GuidToString(PlayerState.PlayerUId)
        if not uid then return end

        local now = os.clock()
        if LastCommandUse[uid] and (now - LastCommandUse[uid]) < COMMAND_COOLDOWN then
            return
        end
        LastCommandUse[uid] = now

        local point = DeathPoints[uid]
        if not point then
            Debug("No saved death point for this player.")
            return
        end

        local PalUtility = GetPalUtility()
        if not PalUtility or not PalUtility:IsValid() then return end

        local ok_pc, PlayerCharacter = pcall(function()
            return PalUtility:GetPlayerCharacterByPlayerUID(PlayerState, PlayerState.PlayerUId)
        end)
        if not ok_pc or not PlayerCharacter or not PlayerCharacter:IsValid() then
            Debug("Could not resolve player character.")
            return
        end

        if IsPlayerInDungeon(PlayerCharacter, PalUtility) then
            Debug("!back is disabled inside dungeons.")
            return
        end

        local TargetLocation = { X = point.X, Y = point.Y, Z = point.Z }
        local TargetRotation = { Pitch = 0, Yaw = point.Yaw, Roll = 0 }

        local ok_tp, teleported = pcall(function()
            return PalUtility:Teleport(PlayerCharacter, TargetLocation, TargetRotation, false, true)
        end)

        local success = false

        if not (ok_tp and teleported) then
            local ok_fallback = pcall(function()
                PalUtility:TeleportAroundLoccation(PlayerCharacter, TargetLocation, TargetRotation)
            end)
            success = ok_fallback
            Debug("Exact point unavailable, teleported nearby.")
        else
            success = true
            Debug("Teleported to death point.")
        end


        if success then
            DeathPoints[uid] = nil
        end
    end)

    if not ok then
        Log("Error handling command: " .. tostring(err))
    end
end)

Log("Mod loaded.")



