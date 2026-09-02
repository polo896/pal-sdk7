-- ============================================================================
-- FAST TRAVEL UNLOCKER By Wol4ara896
-- ============================================================================

local CONFIG = {
    ChatCommand          = "!collecteagle",
    ChatCommandNoExp     = "!collecteaglenoexp",
    ChatCommandMap       = "!collecteaglemapclear",
    ChatCommandStatues   = "!eagle statues",
    ChatCommandPillars   = "!eagle pillars",

    RestoreDelayMs       = 3000,
    MapClearPaintSize    = 99999.0,
    MapClearDurationMs   = 10000,
    MapClearIntervalMs   = 250,
}

local pendingRestoreRate = nil
local mapClearState = {
    active = false,
    originalPaintSize = nil
}

local function IsValid(obj)
    return obj and pcall(function() return obj:IsValid() end) and obj:IsValid()
end

local function GuidToHexStr(guid)
    if not guid then return nil end
    local function u32(val) return (val < 0) and (val + 4294967296) or val end
    return string.format("%08X%08X%08X%08X", u32(guid.A), u32(guid.B), u32(guid.C), u32(guid.D))
end

local function GetOptionSubsystem()
    local instances = FindAllOf("PalOptionSubsystem")
    if instances then
        for _, inst in ipairs(instances) do
            if IsValid(inst) then return inst end
        end
    end
    return nil
end

local function SetExpRate(rate)
    local subsystem = GetOptionSubsystem()
    if not subsystem then return false end
    return pcall(function() subsystem.OptionWorldSettings.ExpRate = rate end)
end

local function GetExpRate()
    local subsystem = GetOptionSubsystem()
    if not subsystem then return nil end
    local ok, val = pcall(function() return subsystem.OptionWorldSettings.ExpRate end)
    return ok and val or nil
end

local function GetLocalPlayerController()
    local controllers = FindAllOf("BP_PalPlayerController_C")
    if controllers then
        for _, c in ipairs(controllers) do
            if IsValid(c) and c.IsLocalPlayerController and c:IsLocalPlayerController() then
                return c
            end
        end
        if #controllers > 0 and IsValid(controllers[1]) then
            return controllers[1]
        end
    end
    return nil
end

local function GetLocalPlayerCharacter()
    local pc = GetLocalPlayerController()
    if not IsValid(pc) then return nil end
    if IsValid(pc.Pawn) then return pc.Pawn end
    if IsValid(pc.Character) then return pc.Character end

    local players = FindAllOf("BP_PalPlayerCharacter_C")
    if players then
        for _, p in ipairs(players) do
            if IsValid(p) then return p end
        end
    end
    return nil
end

local function GetBPWorldMapUIData()
    local objects = FindAllOf("BP_PalWorldMapUIData_C")
    if objects then
        for _, obj in ipairs(objects) do
            if IsValid(obj) then return obj end
        end
    end
    return nil
end

local function TriggerCloudRemoval()
    local triggerClass = StaticFindObject("/Script/Pal.PalUnlockFastTravelTriggerEvent_RemoveSkyIslandCloud")
    local outer = GetOptionSubsystem()
    if not IsValid(triggerClass) or not IsValid(outer) then return end

    local ok, triggerObj = pcall(function() return StaticConstructObject(triggerClass, outer) end)
    if ok and IsValid(triggerObj) then
        pcall(function() triggerObj:TriggerEvent() end)
    end
end

local function CollectEagles(filterMode)
    filterMode = filterMode or "all"

    local pc = GetLocalPlayerController()
    if not IsValid(pc) then
        print("[EagleCollector] Error: Local player controller not found.")
        return
    end

    local transmitter = pc.Transmitter
    local playerNetwork = IsValid(transmitter) and transmitter.Player or nil
    if not IsValid(playerNetwork) then
        print("[EagleCollector] Error: Player network component not found.")
        return
    end

    local totalUnlocked = 0
    local idToGuidStr = {}

    local locationPoints = FindAllOf("PalLocationPointFastTravel")
    if locationPoints then
        for _, loc in ipairs(locationPoints) do
            if IsValid(loc) then
                local isPillar = false
                if loc.IsUnlockMapPoint then
                    local ok, res = pcall(function() return loc:IsUnlockMapPoint() end)
                    isPillar = ok and (res == true) or (loc.bUnlockMapPoint == true)
                else
                    isPillar = (loc.bUnlockMapPoint == true)
                end

                local shouldProcess = false
                if filterMode == "all" then
                    shouldProcess = true
                elseif filterMode == "statues" and not isPillar then
                    shouldProcess = true
                elseif filterMode == "pillars" and isPillar then
                    shouldProcess = true
                end

                if shouldProcess then
                    local guidStr = GuidToHexStr(loc.LocationId)
                    local pointID = loc.FastTravelPointID

                    if guidStr and guidStr ~= "" then
                        if pointID then
                            local idStr = tostring(pointID:ToString())
                            if idStr ~= "" and idStr ~= "None" then
                                idToGuidStr[idStr] = guidStr
                            end
                        end

                        local okName, nameObj = pcall(function() return FName(guidStr) end)
                        local keyParam = okName and nameObj or guidStr

                        pcall(function() playerNetwork:RequestUnlockFastTravelPoint_ToServer(keyParam) end)
                        pcall(function()
                            loc.ShouldUnlockFlag = true
                        end)

                        totalUnlocked = totalUnlocked + 1
                    end
                end
            end
        end
    end

    local levelObjects = FindAllOf("PalLevelObjectUnlockableFastTravelPoint")
    if levelObjects then
        for _, statue in ipairs(levelObjects) do
            if IsValid(statue) then
                local pointID = statue.FastTravelPointID
                if pointID then
                    local idStr = tostring(pointID:ToString())
                    if idToGuidStr[idStr] then
                        pcall(function()
                            statue.bUnlocked = true
                            statue.EnableRequestUnlock = true
                        end)
                    end
                end
            end
        end
    end

    if filterMode == "all" or filterMode == "statues" then
        TriggerCloudRemoval()
    end

    print(string.format("[EagleCollector] Mode [%s]: Unlocked %d fast travel points.", filterMode, totalUnlocked))
end

local function CollectEaglesNoExp(filterMode)
    filterMode = filterMode or "all"

    local originalRate = GetExpRate()
    if originalRate == nil or not SetExpRate(0.0) then
        print("[EagleCollector] Warning: Could not zero EXP rate, collecting normally.")
        CollectEagles(filterMode)
        return
    end

    pendingRestoreRate = originalRate
    print(string.format("[EagleCollector] EXP rate set to 0.0 (Was: %.2f)", originalRate))

    CollectEagles(filterMode)

    ExecuteWithDelay(CONFIG.RestoreDelayMs, function()
        if pendingRestoreRate ~= nil then
            SetExpRate(pendingRestoreRate)
            print(string.format("[EagleCollector] EXP rate restored to %.2f", pendingRestoreRate))
            pendingRestoreRate = nil
        end
    end)
end

local function RemoveMaskAtPlayerPosition()
    local mapUIData = GetBPWorldMapUIData()
    local player = GetLocalPlayerCharacter()
    if not mapUIData or not IsValid(player) then return false end

    local okLoc, location = pcall(function() return player:K2_GetActorLocation() end)
    if not okLoc or not location then return false end

    return pcall(function() mapUIData:RemoveMaskByLocation(player, location) end)
end

local function RestoreMapPaintSize()
    if not mapClearState.active and mapClearState.originalPaintSize == nil then return end

    local original = mapClearState.originalPaintSize
    mapClearState.active = false
    mapClearState.originalPaintSize = nil

    ExecuteInGameThread(function()
        local mapUIData = GetBPWorldMapUIData()
        if mapUIData then
            pcall(function() mapUIData.MapMaskPaintSize = original end)
            print(string.format("[EagleCollector][MAP] Restored paint size to %.2f", original or 0))
        end
    end)
end

local function RunMapClearPulse(endTime)
    if not mapClearState.active then return end

    if os.clock() >= endTime then
        RestoreMapPaintSize()
        return
    end

    ExecuteInGameThread(function()
        if mapClearState.active then
            RemoveMaskAtPlayerPosition()
        end
    end)

    ExecuteWithDelay(CONFIG.MapClearIntervalMs, function()
        RunMapClearPulse(endTime)
    end)
end

local function CollectEaglesMapClear()
    if mapClearState.active then
        print("[EagleCollector][MAP] Map clear is already active.")
        return
    end

    mapClearState.active = true

    ExecuteInGameThread(function()
        local mapUIData = GetBPWorldMapUIData()
        if not mapUIData then
            mapClearState.active = false
            print("[EagleCollector][MAP] Error: BP_PalWorldMapUIData_C not found.")
            return
        end

        local okRead, oldVal = pcall(function() return mapUIData.MapMaskPaintSize end)
        if not okRead then
            mapClearState.active = false
            print("[EagleCollector][MAP] Error: Unable to read MapMaskPaintSize.")
            return
        end

        mapClearState.originalPaintSize = tonumber(oldVal)

        local okWrite = pcall(function() mapUIData.MapMaskPaintSize = CONFIG.MapClearPaintSize end)
        if not okWrite then
            mapClearState.active = false
            print("[EagleCollector][MAP] Error: Failed to set MapMaskPaintSize.")
            return
        end

        RemoveMaskAtPlayerPosition()
        print(string.format("[EagleCollector][MAP] Eraser active for %d ms.", CONFIG.MapClearDurationMs))

        local endTime = os.clock() + (CONFIG.MapClearDurationMs / 1000.0)
        ExecuteWithDelay(CONFIG.MapClearIntervalMs, function()
            RunMapClearPulse(endTime)
        end)
    end)
end

local function RegisterChatHook()
    local success, err = pcall(function()
        RegisterHook("/Script/Pal.PalUIChat:OnReceivedChat", function(context, message)
            local received = message:get()
            if not received or not received.Message then return end

            local text = received.Message:ToString()
            local textLower = string.lower(text)

            if textLower == CONFIG.ChatCommand or textLower == "!eagle all" then
                pcall(function() CollectEagles("all") end)

            elseif textLower == CONFIG.ChatCommandStatues then
                pcall(function() CollectEagles("statues") end)

            elseif textLower == CONFIG.ChatCommandPillars then
                pcall(function() CollectEagles("pillars") end)

            elseif textLower == CONFIG.ChatCommandNoExp or textLower == "!eagle all noexp" then
                pcall(function() CollectEaglesNoExp("all") end)

            elseif textLower == "!eagle statues noexp" then
                pcall(function() CollectEaglesNoExp("statues") end)

            elseif textLower == "!eagle pillars noexp" then
                pcall(function() CollectEaglesNoExp("pillars") end)

            elseif textLower == CONFIG.ChatCommandMap then
                pcall(CollectEaglesMapClear)

            elseif textLower == "!restore" then
                local rateToRestore = pendingRestoreRate or 1.0
                if SetExpRate(rateToRestore) then
                    print(string.format("[EagleCollector] EXP rate manually restored to %.2f", rateToRestore))
                end
                pendingRestoreRate = nil
            end
        end)
    end)

    if success then
        print(string.format("[EagleCollector] Mod initialized. Commands: %s, %s, %s, %s, %s",
            CONFIG.ChatCommand, CONFIG.ChatCommandStatues, CONFIG.ChatCommandPillars, CONFIG.ChatCommandNoExp, CONFIG.ChatCommandMap))
    else
        print("[EagleCollector] Failed to register chat hook: " .. tostring(err))
    end
end

RegisterChatHook()