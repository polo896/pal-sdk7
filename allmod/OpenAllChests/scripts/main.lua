-- ================= By Wol4ara896 =================
--                   OpenAllChests
-- ===================================================
local UEHelpers = require("UEHelpers")
local Config = require("config")

local processing = false

local function DebugPrint(text)
    if Config.Debug then
        pcall(function() print("[OpenAllChests][Debug] " .. tostring(text) .. "\n") end)
    end
end

local function Unwrap(obj)
    if not obj then return nil end
    local unwrapped = nil
    pcall(function()
        if type(obj.get) == "function" then
            unwrapped = obj:get()
        else
            unwrapped = obj
        end
    end)
    return unwrapped or obj
end

local function Notify(gameState, text)
    if not Config.EnableChatToast then return end
    pcall(function()
        ExecuteInGameThread(function()
            local gs = Unwrap(gameState)
            if not (gs and gs:IsValid()) then
                gs = FindFirstOf("PalGameStateInGame")
            end
            if gs and gs:IsValid() then
                gs:BroadcastChatMessage({
                    Category = 1,
                    Sender = "OpenAllChests",
                    SenderPlayerUId = {},
                    Message = text,
                    ReceiverPlayerUIds = {},
                    MessageId = "",
                    MessageArgKeys = {},
                    MessageArgValues = {},
                })
            end
        end)
    end)
end

local function IsServerAuthority(gameState)
    local gs = Unwrap(gameState)
    if not (gs and gs:IsValid()) then
        gs = FindFirstOf("PalGameStateInGame")
    end

    if gs and gs:IsValid() then
        local ok, hasAuth = pcall(function() return gs:HasAuthority() end)
        if ok and hasAuth ~= nil then
            return hasAuth
        end
    end

    local ok, isServer = pcall(function()
        local util = StaticFindObject("/Script/Pal.Default__PalUtility")
        if util and util:IsValid() then
            return util:IsServer(gs)
        end
        return nil
    end)
    if ok and isServer ~= nil then
        return isServer
    end

    return true
end

local function IsChestValidAndClosed(model)
    if not model or not model:IsValid() then return false end

    local isDisposed = false
    pcall(function() isDisposed = model.bDisposed end)
    if isDisposed then return false end

    local isOpened = false
    pcall(function() isOpened = model.bOpened end)
    if isOpened then return false end

    return true
end

local function GetChestLocation(model)
    if not IsChestValidAndClosed(model) then return nil end

    local ok, loc = pcall(function()
        local transform = model:GetTransform()
        if transform and transform.Translation then
            return {
                X = transform.Translation.X,
                Y = transform.Translation.Y,
                Z = transform.Translation.Z
            }
        end
        return nil
    end)
    if ok and loc then return loc end

    ok, loc = pcall(function()
        local actor = model:GetActor()
        if actor and actor:IsValid() then
            local actorLoc = actor:K2_GetActorLocation()
            if actorLoc then
                return { X = actorLoc.X, Y = actorLoc.Y, Z = actorLoc.Z }
            end
        end
        return nil
    end)
    if ok and loc then return loc end

    ok, loc = pcall(function()
        local outVec = { X = 0.0, Y = 0.0, Z = 0.0 }
        model:GetMapObjectLocation(outVec)
        return outVec
    end)
    if ok and loc and (loc.X ~= 0 or loc.Y ~= 0 or loc.Z ~= 0) then
        return loc
    end

    return nil
end

local function GetDistance(a, b)
    local dx = a.X - b.X
    local dy = a.Y - b.Y
    local dz = a.Z - b.Z
    return math.sqrt(dx * dx + dy * dy + dz * dz)
end

local function IsWithinRadius(model, playerLoc)
    if not Config.EnableRadiusFilter or not playerLoc then return true end

    local chestLoc = GetChestLocation(model)
    if not chestLoc then return false end

    local dist = GetDistance(playerLoc, chestLoc)
    return dist <= Config.CollectionRadius
end

local function AreGuidsEqual(guidA, guidB)
    if not guidA or not guidB then return false end
    local equal = false
    pcall(function()
        equal = (guidA.A == guidB.A and guidA.B == guidB.B and guidA.C == guidB.C and guidA.D == guidB.D)
    end)
    return equal
end

local function ResolvePlayerFromGuid(senderGuid)
    local foundPlayerId = nil
    local foundLocation = nil

    local playerStates = FindAllOf("PalPlayerState")
    if playerStates then
        for _, ps in ipairs(playerStates) do
            if ps and ps:IsValid() then
                local psGuid = nil
                pcall(function() psGuid = ps.PlayerUId end)

                if psGuid and AreGuidsEqual(psGuid, senderGuid) then
                    pcall(function() foundPlayerId = ps.PlayerId end)
                    if not foundPlayerId then
                        pcall(function() foundPlayerId = ps:GetPlayerId() end)
                    end

                    local pawn = nil
                    pcall(function() pawn = ps.PawnPrivate end)
                    if not (pawn and pawn:IsValid()) then
                        pcall(function() pawn = ps:GetPawn() end)
                    end

                    if pawn and pawn:IsValid() then
                        local pLoc = pawn:K2_GetActorLocation()
                        if pLoc then
                            foundLocation = { X = pLoc.X, Y = pLoc.Y, Z = pLoc.Z }
                        end
                    end
                    break
                end
            end
        end
    end

    if not foundPlayerId or not foundLocation then
        pcall(function()
            local controller = UEHelpers:GetPlayerController()
            if controller and controller:IsValid() then
                local ps = controller.PlayerState
                if ps and ps:IsValid() then
                    foundPlayerId = ps.PlayerId or ps:GetPlayerId()
                end
                local pawn = controller.Pawn
                if pawn and pawn:IsValid() then
                    local pLoc = pawn:K2_GetActorLocation()
                    if pLoc then
                        foundLocation = { X = pLoc.X, Y = pLoc.Y, Z = pLoc.Z }
                    end
                end
            end
        end)
    end

    return foundPlayerId, foundLocation
end

local function OpenEverything(gameState, playerId, playerLoc)
    local chestModels = FindAllOf("PalMapObjectTreasureBoxModel")
    if not chestModels or #chestModels == 0 then
        Notify(gameState, "!chest: No chests found on the map")
        processing = false
        return
    end

    local processed = 0
    local failed = 0
    local skippedRadius = 0
    local totalModels = #chestModels
    local currentIndex = 1

    local function ProcessBatch()
        ExecuteInGameThread(function()
            local batchEnd = math.min(currentIndex + Config.BatchSize - 1, totalModels)

            for i = currentIndex, batchEnd do
                local model = chestModels[i]
                if IsChestValidAndClosed(model) then
                    if IsWithinRadius(model, playerLoc) then
                        local ok = pcall(function()
                            model:RequestOpen_ServerInternal(playerId, Config.IgnoreOpenItem)
                        end)
                        if ok then
                            processed = processed + 1
                        else
                            failed = failed + 1
                        end
                    else
                        skippedRadius = skippedRadius + 1
                    end
                end
            end

            currentIndex = batchEnd + 1

            if currentIndex <= totalModels then
                ExecuteWithDelay(Config.BatchDelayMs, ProcessBatch)
            else
                processing = false
                Notify(gameState, string.format("!chest: Opened: %d, Failed: %d, Out of range: %d", processed, failed, skippedRadius))
            end
        end)
    end

    ProcessBatch()
end

local function StartOpenChests(senderGuid)
    local gameState = FindFirstOf("PalGameStateInGame")

    if processing then
        Notify(gameState, "!chest: Already processing, please wait")
        return
    end
    processing = true

    local playerId, playerLoc = ResolvePlayerFromGuid(senderGuid)

    if not playerId then
        Notify(gameState, "!chest: Could not resolve Player ID")
        processing = false
        return
    end

    DebugPrint(string.format("Opening chests for PlayerID: %s at Loc: %s", tostring(playerId), playerLoc and string.format("(%.1f, %.1f, %.1f)", playerLoc.X, playerLoc.Y, playerLoc.Z) or "nil"))
    OpenEverything(gameState, playerId, playerLoc)
end

local function RegisterChatHook()
    RegisterHook("/Script/Pal.PalGameStateInGame:BroadcastChatMessage", function(self, ChatMessage)
        local gameState = Unwrap(self)

        if not IsServerAuthority(gameState) then
            return
        end

        local chatStruct = nil
        pcall(function() chatStruct = ChatMessage:get() end)
        if not chatStruct then return end

        local text = ""
        pcall(function()
            if chatStruct.Message then
                text = chatStruct.Message:ToString()
            end
        end)

        if text == Config.ChatCommand then
            StartOpenChests(chatStruct.SenderPlayerUId)
        end
    end)
end

local function RegisterKeybindHook()
    if not Config.EnableKeybind then return end

    local key = Key[Config.KeybindKey] or Key.F7
    RegisterKeyBind(key, function()
        ExecuteInGameThread(function()
            StartOpenChests(nil)
        end)
    end)
end

RegisterChatHook()
RegisterKeybindHook()
DebugPrint("OpenAllChests loaded successfully")