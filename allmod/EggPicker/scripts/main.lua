-- ====================================================================
--                  Palworld Egg Picker
--                     By Wol4ara896
-- ====================================================================
local UEHelpers = require("UEHelpers")

local Config = {
    -- Manual pickup keybind and chat command
    Hotkey = Key.F8,
    ChatCommand = "!egg",

    -- Auto-collector settings
    AutoHotkey = Key.H,
    AutoHotkeyModifiers = {ModifierKey.ALT},
    AutoIntervalMs = 10000,   -- Interval between auto-pickups (milliseconds)
    AutoStartCollect = false, -- Start auto-collect automatically on game load

    -- Notifications
    EnableChatToast = true,   -- Show in-game chat notifications

    -- Save file for assigned chests
    SaveFileName = "egg_picker_chests.txt",

    -- ================= RADIUS SETTINGS =================
    EnableRadiusFilter = false, -- true = collect only within radius, false = map-wide
    CollectionRadius = 150000,  -- Pickup radius in Unreal units (cm)
    -- ===================================================

    Debug = false, -- Print verbose diagnostics to the UE4SS console

    -- ================= FILTER SETTINGS =================
    EnableEggFilter = false, -- Master switch: true = filter by type & rarity, false = collect all eggs

    -- Special Egg Overrides (Always collected if true, regardless of filters)
    AlwaysCollectMutated = true,
    AlwaysCollectOminous = true,

    -- Egg Type / Element Filter (Active when EnableEggFilter = true)
    AllowedEggTypes = {
        Normal      = true,  -- Common Egg / Neutral Pals (Normal / Nomal)
        Fire        = true,  -- Scorching Egg / Fire Pals
        Water       = true,  -- Damp Egg / Water Pals
        Grass       = true,  -- Verdant Egg / Grass Pals (Leaf)
        Electric    = true,  -- Electric Egg / Lightning Pals (Electricity)
        Ice         = true,  -- Frozen Egg / Ice Pals
        Earth       = true,  -- Rocky Egg / Ground Pals (Earth)
        Dark        = true,  -- Dark Egg / Dark Pals
        Dragon      = true,  -- Dragon Egg / Dragon Pals
        Mutation    = true,  -- Mutated Egg (MutationPal)
        WorldTree   = true,  -- Ominous Egg (WorldTree)
    },

    -- Standard Egg Rarity Filter (Active when EnableEggFilter = true)
    AllowedEggLevels = {
        [1] = true,  -- Level 1: Common (Regular)
        [2] = true,  -- Level 2: Uncommon
        [3] = true,  -- Level 3: Rare (Large)
        [4] = true,  -- Level 4: Epic (Huge)
        [5] = true   -- Level 5: Legendary (Huge / Raid / Special)
    }
    -- ===================================================
}

local autoEnabled = false
local BoundChests = {}

local function DebugPrint(text)
    if Config.Debug then
        pcall(function() print("[EggPicker][Debug] " .. tostring(text) .. "\n") end)
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
    if SafeIsValid(pc) then
        return pc.Pawn or pc.Character
    end
    return nil
end

local function GetLocalPlayerUId()
    local pc = GetLocalPlayerController()
    if not SafeIsValid(pc) then return nil end

    local ps = pc.PlayerState
    if SafeIsValid(ps) then
        local ok, uid = pcall(function() return ps:GetPlayerUId() end)
        if ok and uid then return uid end
    end

    local ok2, uid2 = pcall(function() return pc:GetPlayerUId() end)
    if ok2 and uid2 then return uid2 end

    return nil
end

local function ShowToast(text)
    if not Config.EnableChatToast then return end
    pcall(function()
        ExecuteInGameThread(function()
            local gameState = FindFirstOf("PalGameStateInGame")
            local playerUId = GetLocalPlayerUId()
            if SafeIsValid(gameState) then
                gameState:BroadcastChatMessage({
                    Category = 1,
                    Sender = "EggPicker",
                    SenderPlayerUId = {},
                    Message = text,
                    ReceiverPlayerUIds = playerUId and {playerUId} or {},
                    MessageId = "",
                    MessageArgKeys = {},
                    MessageArgValues = {},
                })
            end
        end)
    end)
end

local function GetDistance(a, b)
    local dx = a.X - b.X
    local dy = a.Y - b.Y
    local dz = a.Z - b.Z
    return math.sqrt(dx * dx + dy * dy + dz * dz)
end

local function GetPlayerPawnLocation()
    local pawn = GetLocalPlayerCharacter()
    if SafeIsValid(pawn) then
        local ok, loc = pcall(function() return pawn:K2_GetActorLocation() end)
        if ok and loc then return loc end
    end
    return nil
end

local function SaveBoundChestsToDisk()
    pcall(function()
        local file = io.open(Config.SaveFileName, "w")
        if not file then return end

        for slotNum, cId in pairs(BoundChests) do
            if cId and cId.ID then
                local guid = cId.ID
                file:write(string.format("%d=%d,%d,%d,%d\n", slotNum, guid.A or 0, guid.B or 0, guid.C or 0, guid.D or 0))
            end
        end
        file:close()
    end)
end

local function LoadBoundChestsFromDisk()
    local file = io.open(Config.SaveFileName, "r")
    if not file then return end

    BoundChests = {}
    for rawLine in file:lines() do
        local line = rawLine:gsub("\r", ""):gsub("%s+", "")
        local slot, a, b, c, d = line:match("^(%d+)=(%-?%d+),(%-?%d+),(%-?%d+),(%-?%d+)")
        if slot and a and b and c and d then
            BoundChests[tonumber(slot)] = {
                ID = {
                    A = tonumber(a),
                    B = tonumber(b),
                    C = tonumber(c),
                    D = tonumber(d)
                }
            }
        end
    end
    file:close()
end

local function GetTargetChestModel()
    local character = GetLocalPlayerCharacter()
    if not SafeIsValid(character) then return nil end

    local ok, chestModel = pcall(function()
        local interactComp = character.InteractComponent
        if SafeIsValid(interactComp) then
            local targetInteractive = interactComp.TargetInteractiveObject
            if SafeIsValid(targetInteractive) then
                local ownerActor = targetInteractive:GetOwner()
                if SafeIsValid(ownerActor) then
                    local mapObjModel = ownerActor:GetModel()
                    if SafeIsValid(mapObjModel) then
                        local concreteModel = mapObjModel:GetConcreteModel(false)
                        if SafeIsValid(concreteModel) then
                            return concreteModel
                        end
                    end
                end
            end
        end
        return nil
    end)

    if ok and chestModel then
        return chestModel
    end

    local playerLoc = GetPlayerPawnLocation()
    if not playerLoc then return nil end

    local closestChest = nil
    local closestDist = 350.0

    local allChests = FindAllOf("PalMapObjectItemChestModel") or {}
    for _, chest in pairs(allChests) do
        if SafeIsValid(chest) then
            local actor = chest:GetActor()
            if SafeIsValid(actor) then
                local loc = actor:K2_GetActorLocation()
                if loc then
                    local d = GetDistance(playerLoc, loc)
                    if d < closestDist then
                        closestDist = d
                        closestChest = chest
                    end
                end
            end
        end
    end

    return closestChest
end

local function BindChestSlot(slotNumber)
    local chestModel = GetTargetChestModel()
    if not SafeIsValid(chestModel) then
        ShowToast("Error: No chest found! Stand close or look directly at the chest.")
        return
    end

    local mod = chestModel:GetItemContainerModule()
    if not SafeIsValid(mod) then
        ShowToast("Error: Target object has no valid item container.")
        return
    end

    local containerId = mod:GetContainerId()
    if not containerId then
        ShowToast("Error: Failed to retrieve chest ContainerId.")
        return
    end

    local guid = containerId.ID or containerId
    BoundChests[slotNumber] = {
        ID = {
            A = guid.A or 0,
            B = guid.B or 0,
            C = guid.C or 0,
            D = guid.D or 0
        }
    }

    SaveBoundChestsToDisk()
    ShowToast(string.format("Chest #%d successfully bound and saved to disk!", slotNumber))
end

local function ShowChestsInfo()
    local text = "Bound Egg Chests:"
    local count = 0
    for i = 1, 5 do
        if BoundChests[i] and BoundChests[i].ID then
            count = count + 1
            text = text .. string.format("\n[Slot #%d] Active", i)
        end
    end
    if count == 0 then
        text = "No chests bound. Stand near a chest and type !c1, !c2, or !c3"
    end
    ShowToast(text)
end

local function GetSlotStaticIdName(slot)
    if not SafeIsValid(slot) or slot:IsEmpty() then return "" end

    local name = ""
    pcall(function()
        if slot.ItemId and slot.ItemId.StaticId then
            name = slot.ItemId.StaticId:ToString()
        end
    end)

    if name == "" or name == "None" then
        pcall(function()
            local itemId = slot:GetItemId()
            if itemId and itemId.StaticId then
                name = itemId.StaticId:ToString()
            end
        end)
    end

    return (name ~= "None") and name or ""
end

local function IsEggItemName(itemIdName)
    if not itemIdName or itemIdName == "" then return false end
    local lower = itemIdName:lower()
    return string.find(lower, "egg") ~= nil or string.find(lower, "palegg") ~= nil
end

local function MoveEggsFromInventoryToChests()
    local hasAnyChest = false
    for i = 1, 5 do
        if BoundChests[i] and BoundChests[i].ID then
            hasAnyChest = true
            break
        end
    end
    if not hasAnyChest then return end

    local pc = GetLocalPlayerController()
    if not SafeIsValid(pc) then return end

    local ps = pc.PlayerState
    if not SafeIsValid(ps) then return end

    local invData = ps.InventoryData
    if not SafeIsValid(invData) then return end

    local netItemComp = nil
    pcall(function()
        local netPalWorld = FindFirstOf("PalNetworkPalWorldComponent")
        if SafeIsValid(netPalWorld) then
            netItemComp = netPalWorld.Item or (netPalWorld.GetItem and netPalWorld:GetItem())
        end
    end)
    if not SafeIsValid(netItemComp) then
        pcall(function()
            if pc.NetworkPalWorldComponent and SafeIsValid(pc.NetworkPalWorldComponent) then
                netItemComp = pc.NetworkPalWorldComponent.Item or pc.NetworkPalWorldComponent:GetItem()
            end
        end)
    end
    if not SafeIsValid(netItemComp) then
        netItemComp = FindFirstOf("PalNetworkItemComponent")
    end

    if not SafeIsValid(netItemComp) then return end

    local helper = invData.InventoryMultiHelper
    if not SafeIsValid(helper) or not helper.Containers then return end

    local containers = helper.Containers
    local eggSlotMoves = {}

    for cIdx = 1, #containers do
        local cont = containers[cIdx]
        if SafeIsValid(cont) then
            local numSlots = cont:Num()
            if numSlots and numSlots > 0 then
                for sIdx = 0, numSlots - 1 do
                    local slot = cont:Get(sIdx)
                    if SafeIsValid(slot) and not slot:IsEmpty() then
                        local staticId = GetSlotStaticIdName(slot)
                        if IsEggItemName(staticId) then
                            local slotId = slot:GetSlotId()
                            local count = slot:GetStackCount()
                            table.insert(eggSlotMoves, {
                                SlotId = slotId,
                                Num = count
                            })
                        end
                    end
                end
            end
        end
    end

    if #eggSlotMoves == 0 then return end

    local dummyGuid = { A = 0, B = 0, C = 0, D = 0 }
    for chestIndex = 1, 5 do
        local targetContainerId = BoundChests[chestIndex]
        if targetContainerId then
            pcall(function()
                netItemComp:RequestMoveToContainer_ToServer(dummyGuid, targetContainerId, eggSlotMoves)
            end)
        end
    end
end

local function GetItemIdName(item)
    local itemIdName = ""
    pcall(function()
        if item.GetVisualStaticItemId then
            local fName = item:GetVisualStaticItemId()
            if fName then itemIdName = fName:ToString() end
        end
        if itemIdName == "" and item.VisualStaticItemId then
            itemIdName = item.VisualStaticItemId:ToString()
        end
    end)
    return itemIdName
end

local function GetEggInfo(item)
    local itemIdName = GetItemIdName(item)
    local searchString = itemIdName:lower()

    pcall(function()
        local actor = item:GetActor()
        if SafeIsValid(actor) then
            local cls = actor:GetClass()
            if SafeIsValid(cls) then
                searchString = searchString .. " " .. cls:GetName():lower()
            end
        end
        local fullName = item:GetFullName()
        if fullName then
            searchString = searchString .. " " .. fullName:lower()
        end
    end)

    local eggType = "Normal"
    if string.find(searchString, "mutation") or string.find(searchString, "mutant") then
        eggType = "Mutation"
    elseif string.find(searchString, "worldtree") or string.find(searchString, "ominous") then
        eggType = "WorldTree"
    elseif string.find(searchString, "dragon") then
        eggType = "Dragon"
    elseif string.find(searchString, "dark") then
        eggType = "Dark"
    elseif string.find(searchString, "electricity") or string.find(searchString, "electric") then
        eggType = "Electric"
    elseif string.find(searchString, "fire") or string.find(searchString, "scorching") then
        eggType = "Fire"
    elseif string.find(searchString, "water") or string.find(searchString, "damp") then
        eggType = "Water"
    elseif string.find(searchString, "leaf") or string.find(searchString, "grass") or string.find(searchString, "verdant") then
        eggType = "Grass"
    elseif string.find(searchString, "earth") or string.find(searchString, "ground") or string.find(searchString, "rocky") then
        eggType = "Earth"
    elseif string.find(searchString, "ice") or string.find(searchString, "frozen") then
        eggType = "Ice"
    elseif string.find(searchString, "normal") or string.find(searchString, "nomal") then
        eggType = "Normal"
    end

    local rarityLevel = 1
    if eggType == "Mutation" or eggType == "WorldTree" then
        rarityLevel = 5
    else
        local num = itemIdName:match("(%d+)$") or searchString:match("grade_(%d+)") or searchString:match("level_(%d+)")
        if num then
            rarityLevel = tonumber(num) or 1
        end
    end

    return eggType, rarityLevel, itemIdName
end

local function IsEggAllowed(item)
    if not Config.EnableEggFilter then return true end

    local eggType, rarityLevel, itemIdName = GetEggInfo(item)

    if eggType == "Mutation" and Config.AlwaysCollectMutated then return true end
    if eggType == "WorldTree" and Config.AlwaysCollectOminous then return true end

    if Config.AllowedEggTypes[eggType] ~= nil and not Config.AllowedEggTypes[eggType] then
        DebugPrint("Filtered out (Type): " .. eggType .. " [" .. itemIdName .. "]")
        return false
    end

    if Config.AllowedEggLevels[rarityLevel] ~= nil and not Config.AllowedEggLevels[rarityLevel] then
        DebugPrint("Filtered out (Rarity): Level " .. tostring(rarityLevel) .. " [" .. itemIdName .. "]")
        return false
    end

    return true
end

local function GetEggValue(item)
    local eggType, rarityLevel = GetEggInfo(item)

    if eggType == "Mutation" then return 1000 end
    if eggType == "WorldTree" then return 900 end
    if eggType == "Dragon" then return 800 + rarityLevel end

    return rarityLevel or 0
end

local function GetEggLocation(item)
    if not SafeIsValid(item) then return nil end

    local ok, loc = pcall(function() return item:GetMapObjectLocation() end)
    if ok and loc then return loc end

    ok, loc = pcall(function()
        local t = item:GetTransform()
        return t and t.Translation
    end)
    if ok and loc then return loc end

    ok, loc = pcall(function()
        local actor = item:GetActor()
        if SafeIsValid(actor) then return actor:K2_GetActorLocation() end
        return nil
    end)
    if ok and loc then return loc end

    return nil
end

local function IsWithinRadius(item, playerLoc)
    if not Config.EnableRadiusFilter then return true end
    if not playerLoc then return true end

    local itemLoc = GetEggLocation(item)
    if not itemLoc then return false end

    return GetDistance(playerLoc, itemLoc) <= Config.CollectionRadius
end

local function ExecutePickup()
    local playerUId = GetLocalPlayerUId()
    if not playerUId then return end

    MoveEggsFromInventoryToChests()

    local playerLoc = nil
    if Config.EnableRadiusFilter then
        playerLoc = GetPlayerPawnLocation()
    end

    local candidates = {}
    local pickableItems = FindAllOf("PalMapObjectPickableItemModelBase")
    if pickableItems then
        for _, item in pairs(pickableItems) do
            if SafeIsValid(item) then
                local ok, fullName = pcall(function() return item:GetFullName() end)
                if ok and fullName and fullName:find("PalMapObjectPalEggModel") then
                    if IsEggAllowed(item) and IsWithinRadius(item, playerLoc) then
                        table.insert(candidates, item)
                    end
                end
            end
        end
    end

    table.sort(candidates, function(a, b)
        return GetEggValue(a) > GetEggValue(b)
    end)

    for _, item in ipairs(candidates) do
        pcall(function() item:RequestPickup(playerUId) end)
    end

    ExecuteWithDelay(350, function()
        ExecuteInGameThread(function()
            MoveEggsFromInventoryToChests()
        end)
    end)
end

local ScheduleAutoTick
ScheduleAutoTick = function()
    ExecuteWithDelay(Config.AutoIntervalMs, function()
        if not autoEnabled then return end

        ExecuteInGameThread(function()
            pcall(ExecutePickup)
        end)

        ScheduleAutoTick()
    end)
end

local function ToggleAutoCollect()
    autoEnabled = not autoEnabled
    if autoEnabled then
        local filterStatus = Config.EnableEggFilter and "ON" or "OFF"
        local radiusStatus = Config.EnableRadiusFilter and (Config.CollectionRadius .. "u") or "OFF"
        ShowToast("Auto-collect ENABLED (every " .. (Config.AutoIntervalMs / 1000) .. "s) | Filter: " .. filterStatus .. " | Radius: " .. radiusStatus)
        ScheduleAutoTick()
    else
        ShowToast("Auto-collect DISABLED")
    end
end

local function RegisterChatHook()
    RegisterHook("/Script/Pal.PalUIChat:OnReceivedChat", function(context, message)
        local received = message:get()
        if not received or not received.Message then return end

        local msg = received.Message:ToString()

        if msg == Config.ChatCommand then
            ExecuteInGameThread(ExecutePickup)
        elseif msg == "!eggc1" or msg == "!egg_c1" then
            ExecuteInGameThread(function() BindChestSlot(1) end)
        elseif msg == "!eggc2" or msg == "!egg_c2" then
            ExecuteInGameThread(function() BindChestSlot(2) end)
        elseif msg == "!eggc3" or msg == "!egg_c3" then
            ExecuteInGameThread(function() BindChestSlot(3) end)
        elseif msg == "!eggchests" or msg == "!egg_info" then
            ExecuteInGameThread(ShowChestsInfo)
        elseif msg == "!egg_clear" then
            BoundChests = {}
            SaveBoundChestsToDisk()
            ShowToast("All egg chest bindings cleared.")
        end
    end)
end

local function Init()
    LoadBoundChestsFromDisk()

    RegisterKeyBind(Config.Hotkey, function()
        ExecuteInGameThread(function() pcall(ExecutePickup) end)
    end)

    RegisterKeyBind(Config.AutoHotkey, Config.AutoHotkeyModifiers, function()
        ToggleAutoCollect()
    end)

    RegisterChatHook()

    if Config.AutoStartCollect then
        ExecuteWithDelay(3000, function()
            ExecuteInGameThread(function()
                if not autoEnabled then ToggleAutoCollect() end
            end)
        end)
    end
end

Init()
