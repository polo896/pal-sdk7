-- =======================================================================
-- Relic Collector Mod By Wol4ara896
-- =======================================================================

local MOD_TAG = "[RelicCollector]"
local relicUI = require("relic_ui")

local CONFIG = {
    CollectRadius   = 0,
    ChatCommand     = "!collect",
    ChatCommandNoExp= "!collectnoexp",
    ChatCommandGUI  = "!scollect",
    RestoreDelayMs  = 3000,
    MaxPerType      = 0,

    Relics = {
        ["BP_LevelObject_Relic_C"]               = true,  -- Lifmunk
        ["BP_LevelObject_Relic_FlameBambi_C"]    = true,  -- Rooby
        ["BP_LevelObject_Relic_GuardianDog_C"]   = true,  -- Yakumo
        ["BP_LevelObject_Relic_IceCrocodile_C"]  = true,  -- Munchill
        ["BP_LevelObject_Relic_LazyDragon_C"]    = true,  -- Relaxaurus
        ["BP_LevelObject_Relic_LeafMomonga_C"]   = true,  -- Bristla
        ["BP_LevelObject_Relic_Monkey_C"]        = true,  -- Tanzee
        ["BP_LevelObject_Relic_Mutant_C"]        = true,  -- Lunaris
        ["BP_LevelObject_Relic_NegativeKoala_C"] = true,  -- Depresso
        ["BP_LevelObject_Relic_Penguin_C"]       = true,  -- Pengullet
        ["BP_LevelObject_Relic_PinkCat_C"]       = true,  -- Cattiva
        ["BP_LevelObject_Relic_SheepBall_C"]     = true,  -- Lamball
    },

    RelicNames = {
        ["BP_LevelObject_Relic_C"]               = "Lifmunk",
        ["BP_LevelObject_Relic_FlameBambi_C"]    = "Rooby",
        ["BP_LevelObject_Relic_GuardianDog_C"]   = "Yakumo",
        ["BP_LevelObject_Relic_IceCrocodile_C"]  = "Munchill",
        ["BP_LevelObject_Relic_LazyDragon_C"]    = "Relaxaurus",
        ["BP_LevelObject_Relic_LeafMomonga_C"]   = "Bristla",
        ["BP_LevelObject_Relic_Monkey_C"]        = "Tanzee",
        ["BP_LevelObject_Relic_Mutant_C"]        = "Lunaris",
        ["BP_LevelObject_Relic_NegativeKoala_C"] = "Depresso",
        ["BP_LevelObject_Relic_Penguin_C"]       = "Pengullet",
        ["BP_LevelObject_Relic_PinkCat_C"]       = "Cattiva",
        ["BP_LevelObject_Relic_SheepBall_C"]     = "Lamball",
    }
}

local FriendlyToClass = {
    ["lifmunk"]    = "BP_LevelObject_Relic_C",
    ["rooby"]      = "BP_LevelObject_Relic_FlameBambi_C",
    ["yakumo"]     = "BP_LevelObject_Relic_GuardianDog_C",
    ["munchill"]   = "BP_LevelObject_Relic_IceCrocodile_C",
    ["relaxaurus"] = "BP_LevelObject_Relic_LazyDragon_C",
    ["bristla"]    = "BP_LevelObject_Relic_LeafMomonga_C",
    ["tanzee"]     = "BP_LevelObject_Relic_Monkey_C",
    ["lunaris"]    = "BP_LevelObject_Relic_Mutant_C",
    ["depresso"]   = "BP_LevelObject_Relic_NegativeKoala_C",
    ["pengullet"]  = "BP_LevelObject_Relic_Penguin_C",
    ["cattiva"]    = "BP_LevelObject_Relic_PinkCat_C",
    ["lamball"]    = "BP_LevelObject_Relic_SheepBall_C",
}

local pendingRestoreRate = nil

local function GetUtility()
    return StaticFindObject("/Script/Pal.Default__PalUtility")
end

local function GetLocalPlayerController()
    local controllers = FindAllOf("BP_PalPlayerController_C") or FindAllOf("PalPlayerController")
    if controllers then
        for _, c in ipairs(controllers) do
            if c:IsValid() and c.IsLocalPlayerController and c:IsLocalPlayerController() then
                return c
            end
        end
    end
    return nil
end

local function GetWorldContext()
    local localPC = GetLocalPlayerController()
    if localPC and localPC:IsValid() then return localPC end
    return nil
end

local function IsSameGuid(g1, g2)
    if not g1 or not g2 then return false end
    if g1.A and g2.A then
        return g1.A == g2.A and g1.B == g2.B and g1.C == g2.C and g1.D == g2.D
    end
    return false
end

local function Notify(message)
    print(string.format("%s %s", MOD_TAG, message))
    local util = GetUtility()
    local ctx  = GetWorldContext()
    if util and ctx then
        pcall(function() util:SendSystemAnnounce(ctx, message) end)
    end
end

local function NotifySequence(lines)
    local combined = table.concat(lines, "\n")
    Notify(combined)
end

local function GetOptionSubsystem()
    local instances = FindAllOf("PalOptionSubsystem")
    if instances and #instances > 0 then
        for _, inst in ipairs(instances) do
            if inst and inst:IsValid() then return inst end
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
    local ok, value = pcall(function() return subsystem.OptionWorldSettings.ExpRate end)
    if ok then return value end
    return nil
end

local function CollectRelics()
    local PlayerController = GetLocalPlayerController()
    if not PlayerController or not PlayerController:IsValid() then
        Notify("[RC] Error: Local Player Controller not found.")
        return
    end

    local Transmitter = PlayerController.Transmitter
    if not Transmitter or not Transmitter:IsValid() then
        Notify("[RC] Error: Transmitter not found.")
        return
    end

    local PlayerNetwork = Transmitter.Player
    if not PlayerNetwork or not PlayerNetwork:IsValid() then
        Notify("[RC] Error: PlayerNetwork component not found.")
        return
    end

    local PlayerPawn = PlayerController.Character
    if not PlayerPawn or not PlayerPawn:IsValid() then
        Notify("[RC] Error: Player pawn not found.")
        return
    end

    local PlayerLoc = PlayerPawn:K2_GetActorLocation()
    local collectedCount = 0
    local stats = {}

    for k, _ in pairs(CONFIG.Relics) do stats[k] = 0 end

    local relics = FindAllOf("PalLevelObjectRelic")
    if not relics or #relics == 0 then
        Notify("[RC] No relics found in world.")
        return
    end

    for _, relic in ipairs(relics) do
        if relic:IsValid() and relic.bPickedInClient == false then
            local class = relic:GetClass()
            local className = class and class:GetFName():ToString() or ""

            local isEnabled = CONFIG.Relics[className]
            if isEnabled == nil then isEnabled = true end

            local currentCount = stats[className] or 0
            local limit = CONFIG.MaxPerType or 0

            if isEnabled and (limit == 0 or currentCount < limit) then
                local shouldCollect = true
                if CONFIG.CollectRadius > 0 then
                    local RelicLoc = relic:K2_GetActorLocation()
                    local dist = math.sqrt((PlayerLoc.X - RelicLoc.X)^2 + (PlayerLoc.Y - RelicLoc.Y)^2 + (PlayerLoc.Z - RelicLoc.Z)^2)
                    if dist > CONFIG.CollectRadius then
                        shouldCollect = false
                    end
                end

                if shouldCollect then
                    PlayerNetwork:RequestObtainLevelObject_ToServer(relic)
                    collectedCount = collectedCount + 1
                    stats[className] = currentCount + 1
                end
            end
        end
    end

    if collectedCount > 0 then
        local details = {}
        for class, count in pairs(stats) do
            if count > 0 then
                local friendlyName = CONFIG.RelicNames[class] or class
                table.insert(details, string.format("%s: %d", friendlyName, count))
            end
        end
        Notify(string.format("[RC] Collected %d statues!\n(%s)", collectedCount, table.concat(details, ", ")))
    else
        Notify("[RC] Nothing collected! (Already gathered, disabled, or outside radius)")
    end
end

local function CollectRelicsNoExp()
    local originalRate = GetExpRate()
    if originalRate == nil then
        Notify("[RC] EXP read failed, collecting with normal EXP...")
        CollectRelics()
        return
    end

    local setOk = SetExpRate(0.0)
    if not setOk then
        Notify("[RC] Failed to disable EXP, collecting normally...")
        CollectRelics()
        return
    end

    Notify(string.format("[RC] Collecting without EXP (Rate: 0.0, was: %.1f)...", originalRate))
    pendingRestoreRate = originalRate

    CollectRelics()

    ExecuteWithDelay(CONFIG.RestoreDelayMs, function()
        if pendingRestoreRate ~= nil then
            local restoreOk = SetExpRate(pendingRestoreRate)
            if restoreOk then
                Notify(string.format("[RC] EXP restored back to %.1f", pendingRestoreRate))
            else
                Notify("[RC] Failed to restore EXP! Type: !restore")
            end
            pendingRestoreRate = nil
        end
    end)
end

local function RestoreExpManually()
    local rate = pendingRestoreRate or 1.0
    SetExpRate(rate)
    Notify(string.format("[RC] EXP manually restored to %.1f", rate))
    pendingRestoreRate = nil
end

local function OpenControlGUI()
    if relicUI.is_visible() then
        relicUI.close()
        return
    end

    local uiContext = {
        config          = CONFIG,
        onCollect       = function() CollectRelics() end,
        onCollectNoExp  = function() CollectRelicsNoExp() end,
        onRestoreExp    = function() RestoreExpManually() end,
        onHelp          = function()
            NotifySequence({
                "=== [Relic Collector Quick Help] ===",
                "• Click statue cards to toggle Pal collection ON/OFF",
                "• Use radius buttons to set map distance",
                "• Use limit buttons to restrict max statues per Pal"
            })
        end
    }
    relicUI.show(uiContext)
end

local function SplitArgs(input)
    local args = {}
    for word in string.gmatch(input, "%S+") do table.insert(args, word) end
    return args
end

local function HandleChatMessage(rawText)
    local colonIdx = string.find(rawText, ":%s*!")
    if colonIdx then rawText = string.sub(rawText, colonIdx + 1) end
    rawText = string.gsub(rawText, "^%s*(.-)%s*$", "%1")

    if string.sub(rawText, 1, 1) ~= "!" then return end
    local args = SplitArgs(rawText)
    if #args == 0 then return end

    local mainCmd = string.lower(args[1])

    if mainCmd == "!scollect" or mainCmd == "!rcedit" or mainCmd == "!rcgui" then
        OpenControlGUI()
        return
    end

    if mainCmd == "!collect" then
        CollectRelics()
        return
    elseif mainCmd == "!collectnoexp" then
        CollectRelicsNoExp()
        return
    elseif mainCmd == "!restore" then
        RestoreExpManually()
        return
    end

    if mainCmd ~= "!rc" and mainCmd ~= "!relic" then return end

    local subCmd = args[2] and string.lower(args[2]) or "gui"

    if subCmd == "gui" or subCmd == "menu" or subCmd == "ui" then
        OpenControlGUI()
    elseif subCmd == "collect" then
        CollectRelics()
    elseif subCmd == "noexp" then
        CollectRelicsNoExp()
    elseif subCmd == "radius" then
        local val = tonumber(args[3])
        if val and val >= 0 then
            CONFIG.CollectRadius = val
            Notify(val == 0 and "[RC] Radius: Unlimited (Entire map)" or string.format("[RC] Radius set to: %d units (~%d meters)", val, math.floor(val / 100)))
        else
            Notify("[RC] Usage: !rc radius <number> (e.g. !rc radius 5000, 0 = all)")
        end
    elseif subCmd == "limit" or subCmd == "max" then
        local val = tonumber(args[3])
        if val and val >= 0 then
            CONFIG.MaxPerType = val
            Notify(val == 0 and "[RC] Statue limit: Unlimited" or string.format("[RC] Statue limit: %d per Pal type", val))
        else
            Notify("[RC] Usage: !rc limit <number> (e.g. !rc limit 5, 0 = all)")
        end
    elseif subCmd == "toggle" then
        local name = args[3] and string.lower(args[3])
        if name and FriendlyToClass[name] then
            local class = FriendlyToClass[name]
            local newState = not (CONFIG.Relics[class] == true)
            CONFIG.Relics[class] = newState
            Notify(string.format("[RC] %s %s is now %s", newState and "[+]" or "[-]", CONFIG.RelicNames[class], newState and "ENABLED" or "DISABLED"))
        else
            Notify("[RC] Unknown name! Use '!rc list' to view pals.")
        end
    elseif subCmd == "enable" then
        local name = args[3] and string.lower(args[3])
        if name == "all" then
            for class in pairs(CONFIG.Relics) do CONFIG.Relics[class] = true end
            Notify("[RC] [+] Enabled ALL 12 Pal statue types.")
        elseif name and FriendlyToClass[name] then
            local class = FriendlyToClass[name]
            CONFIG.Relics[class] = true
            Notify(string.format("[RC] [+] %s is now ENABLED", CONFIG.RelicNames[class]))
        end
    elseif subCmd == "disable" then
        local name = args[3] and string.lower(args[3])
        if name == "all" then
            for class in pairs(CONFIG.Relics) do CONFIG.Relics[class] = false end
            Notify("[RC] [-] Disabled ALL statue types.")
        elseif name and FriendlyToClass[name] then
            local class = FriendlyToClass[name]
            CONFIG.Relics[class] = false
            Notify(string.format("[RC] [-] %s is now DISABLED", CONFIG.RelicNames[class]))
        end
    elseif subCmd == "status" or subCmd == "cfg" then
        OpenControlGUI()
    elseif subCmd == "help" then
        NotifySequence({
            "=== [Relic Collector Help] ===",
            "!scollect - Open Control GUI Window",
            "!collect - Collect all statues (with EXP)",
            "!collectnoexp - Collect WITHOUT player EXP",
            "!rc gui - Open Control GUI Window",
            "!rc radius <num> - Set distance (0 = all)",
            "!rc limit <num> - Max statues per pal (0 = all)"
        })
    end
end

local function RegisterChatHook()
    pcall(function()
        RegisterHook("/Script/Pal.PalUIChat:OnReceivedChat", function(context, message)
            if not message then return end
            local received = message:get()
            if not received or not received.Message then return end

            local senderName = received.Sender and received.Sender:ToString() or ""
            if senderName == "SYSTEM" or senderName == "" then return end

            local localPC = GetLocalPlayerController()
            if not localPC or not localPC:IsValid() or not localPC.PlayerState then return end

            local localPS = localPC.PlayerState
            local localGuid = localPS.PlayerUId
            local senderGuid = received.SenderPlayerUId

            local isAuthor = false
            if senderGuid and localGuid and IsSameGuid(senderGuid, localGuid) then
                isAuthor = true
            elseif senderName ~= "" and localPS.PlayerNamePrivate then
                if senderName == localPS.PlayerNamePrivate:ToString() then isAuthor = true end
            end

            if not isAuthor then return end
            HandleChatMessage(received.Message:ToString())
        end)
    end)
end

local function RegisterEscClose()
    pcall(function()
        RegisterKeyBind(Key.ESCAPE, function()
            pcall(function()
                if relicUI.is_visible() then
                    relicUI.close()
                end
            end)
        end)
    end)
end

local function Init()
    print("[RelicCollector] Initializing...")
    RegisterChatHook()
    RegisterEscClose()
    print("[RelicCollector] Loaded. Type '!scollect' to open GUI.")
end

Init()