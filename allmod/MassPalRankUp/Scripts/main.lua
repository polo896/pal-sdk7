-- ==========================================================
-- Mass Pal Rank Up Mod By Wol4ara896
-- ==========================================================
-- CONFIG
-- UpgradePalbox / UpgradeParty:
-- true, false = Palbox only
-- false, true = Party only
-- true, true  = Palbox + Party
-------------------------------
-- souls (absolute), any combination or all at once:
-- 1 HP / 2 Attack / 3 Defense / 4 Work Speed
-- ==========================================================

local Config = {
    UpgradePalbox = false,
    UpgradeParty = true,
    Hotkey = Key.F6,
    UpgradeHP = false,
    UpgradeAttack = false,
    UpgradeDefense = false,
    UpgradeWorkSpeed = false,
}

local isProcessing = false

local SoulStats = {
    { key = "UpgradeHP",        label = "HP",   enum = 3, saveField = "Rank_HP",         get = function(p) return p:GetHPRank() end },
    { key = "UpgradeAttack",    label = "ATK",  enum = 1, saveField = "Rank_Attack",     get = function(p) return p:GetAttackRank() end },
    { key = "UpgradeDefense",   label = "DEF",  enum = 2, saveField = "Rank_Defence",    get = function(p) return p:GetDefenceRank() end },
    { key = "UpgradeWorkSpeed", label = "Work", enum = 4, saveField = "Rank_CraftSpeed", get = function(p) return p:GetWorkSpeedRank() end },
}

local SoulCostByRank = {
    [0]  = { "PalUpgradeStone",  1 },
    [1]  = { "PalUpgradeStone",  2 },
    [2]  = { "PalUpgradeStone",  3 },
    [3]  = { "PalUpgradeStone",  4 },
    [4]  = { "PalUpgradeStone2", 1 },
    [5]  = { "PalUpgradeStone2", 2 },
    [6]  = { "PalUpgradeStone2", 3 },
    [7]  = { "PalUpgradeStone3", 1 },
    [8]  = { "PalUpgradeStone3", 2 },
    [9]  = { "PalUpgradeStone3", 3 },
    [10] = { "PalUpgradeStone4", 1 },
    [11] = { "PalUpgradeStone4", 2 },
    [12] = { "PalUpgradeStone4", 2 },
    [13] = { "PalUpgradeStone4", 3 },
    [14] = { "PalUpgradeStone4", 3 },
    [15] = { "PalUpgradeStone4", 3 },
    [16] = { "PalUpgradeStone4", 4 },
    [17] = { "PalUpgradeStone4", 4 },
    [18] = { "PalUpgradeStone4", 4 },
    [19] = { "PalUpgradeStone4", 4 },
}

local SOUL_MAX_RANK = 20

local function CanonicalSoulName(itemName)
    if not itemName or itemName == "" then
        return nil
    end
    if itemName == "PalUpgradeStone4" or itemName:find("PalUpgradeStone4", 1, true) then
        return "PalUpgradeStone4"
    end
    if itemName == "PalUpgradeStone3" or itemName:find("PalUpgradeStone3", 1, true) then
        return "PalUpgradeStone3"
    end
    if itemName == "PalUpgradeStone2" or itemName:find("PalUpgradeStone2", 1, true) then
        return "PalUpgradeStone2"
    end
    if itemName == "PalUpgradeStone" or itemName:find("PalUpgradeStone", 1, true) then
        return "PalUpgradeStone"
    end
    return nil
end

local function ForEachItemSlot(InventoryData, fn)
    if not InventoryData or not InventoryData:IsValid() then
        return
    end
    local multiHelper = InventoryData.InventoryMultiHelper
    if not (multiHelper and multiHelper:IsValid() and multiHelper.Containers) then
        return
    end
    for i = 1, #multiHelper.Containers do
        local container = multiHelper.Containers[i]
        if container and container:IsValid() and container.ItemSlotArray then
            for slotIdx = 1, #container.ItemSlotArray do
                local itemSlot = container.ItemSlotArray[slotIdx]
                if itemSlot and itemSlot:IsValid() and not itemSlot:IsEmpty() and itemSlot:GetStackCount() > 0 then
                    if fn(itemSlot, itemSlot.ItemId.StaticId:ToString()) then
                        return
                    end
                end
            end
        end
    end
end

local function FindRankFruitSlot(InventoryData, currentRank)
    local found = nil
    ForEachItemSlot(InventoryData, function(itemSlot, itemName)
        if itemName == "Rankup_Arbitrary" or itemName:find("Arbitrary") then
            found = itemSlot
            return true
        end
        local targetFruitName = "Rankup_" .. tostring(currentRank)
        if itemName == targetFruitName or itemName:find(targetFruitName) then
            found = itemSlot
            return true
        end
    end)
    return found
end

local function CollectSoulBag(InventoryData)
    local bag = {}
    local slots = {}
    ForEachItemSlot(InventoryData, function(itemSlot, itemName)
        local canon = CanonicalSoulName(itemName)
        if canon then
            local n = itemSlot:GetStackCount()
            bag[canon] = (bag[canon] or 0) + n
            slots[#slots + 1] = { slot = itemSlot, name = canon }
        end
    end)
    return bag, slots
end

local function SoulBagHasAny(bag)
    if not bag then
        return false
    end
    for _, n in pairs(bag) do
        if n > 0 then
            return true
        end
    end
    return false
end

local function SoulBagTryPay(bag, itemName, count)
    if not itemName or count == nil or count <= 0 then
        return false
    end
    local have = bag[itemName] or 0
    if have < count then
        return false
    end
    bag[itemName] = have - count
    return true
end

local function GetSoulCost(currentRank)
    local row = SoulCostByRank[currentRank]
    if not row then
        return nil, 0
    end
    return row[1], row[2]
end

local function AnySoulStatEnabled()
    for i = 1, #SoulStats do
        if Config[SoulStats[i].key] then
            return true
        end
    end
    return false
end

local function NewRequestGuid()
    return {
        A = math.random(1, 0x7fffffff),
        B = math.random(1, 0x7fffffff),
        C = math.random(1, 0x7fffffff),
        D = math.random(1, 0x7fffffff),
    }
end

local function DisposeFromSlot(ctx, itemSlot, num)
    if not itemSlot or not itemSlot:IsValid() or num == nil or num <= 0 then
        return false
    end
    if ctx.ItemNet and ctx.ItemNet:IsValid() then
        local ok = pcall(function()
            ctx.ItemNet:RequestDispose_ToServer(NewRequestGuid(), {
                SlotId = itemSlot:GetSlotId(),
                Num = num,
            })
        end)
        if ok then
            return true
        end
    end
    local ok = pcall(function()
        local have = itemSlot:GetStackCount()
        itemSlot.StackCount = math.max(0, have - num)
    end)
    return ok
end

local function ConsumePaidSouls(ctx, paid)
    if not paid or not ctx.SoulSlots then
        return
    end
    for itemName, remain in pairs(paid) do
        if remain and remain > 0 then
            for i = 1, #ctx.SoulSlots do
                if remain <= 0 then
                    break
                end
                local entry = ctx.SoulSlots[i]
                if entry.name == itemName and entry.slot and entry.slot:IsValid() and not entry.slot:IsEmpty() then
                    local have = entry.slot:GetStackCount()
                    if have > 0 then
                        local take = math.min(have, remain)
                        if DisposeFromSlot(ctx, entry.slot, take) then
                            remain = remain - take
                        end
                    end
                end
            end
        end
    end
end

local function WriteSaveParameterRanks(param, newRanks)
    if not param or not param:IsValid() then
        return false
    end
    local wrote = false
    local okCopy = pcall(function()
        local sp = param.SaveParameter
        for field, rank in pairs(newRanks) do
            sp[field] = rank
        end
        param.SaveParameter = sp
        wrote = true
    end)
    if not okCopy or not wrote then
        pcall(function()
            for field, rank in pairs(newRanks) do
                param.SaveParameter[field] = rank
            end
            wrote = true
        end)
    end
    pcall(function()
        param:OnRep_SaveParameter()
    end)
    return wrote
end

local function ApplySoulsToPal(handle, param, ctx, isOtomo)
    if not ctx.SoulBag then
        return nil
    end
    if not SoulBagHasAny(ctx.SoulBag) then
        return nil
    end

    local payload = {}
    local parts = {}
    local newRanks = {}
    local paid = {}
    local anyUp = false

    for i = 1, #SoulStats do
        local stat = SoulStats[i]
        if Config[stat.key] then
            local current = stat.get(param)
            if type(current) ~= "number" then
                current = 0
            end
            local rank = current
            local statPaid = {}
            while rank < SOUL_MAX_RANK do
                local itemName, itemCount = GetSoulCost(rank)
                if not itemName or itemCount <= 0 then
                    break
                end
                if not SoulBagTryPay(ctx.SoulBag, itemName, itemCount) then
                    break
                end
                statPaid[itemName] = (statPaid[itemName] or 0) + itemCount
                rank = rank + 1
            end
            if rank > current then
                anyUp = true
                payload[#payload + 1] = { StatusName = stat.enum, Rank = rank }
                newRanks[stat.saveField] = rank
                parts[#parts + 1] = string.format("%s %d->%d", stat.label, current, rank)
                for itemName, n in pairs(statPaid) do
                    paid[itemName] = (paid[itemName] or 0) + n
                end
            end
        end
    end

    if not anyUp then
        return nil
    end

    local applied = false
    if isOtomo and ctx.StatusComp and ctx.StatusComp:IsValid() then
        local ok = pcall(function()
            ctx.StatusComp:RequestOtomoStatusPointAdd_ToServer(handle:GetIndividualID(), payload)
        end)
        applied = ok
        WriteSaveParameterRanks(param, newRanks)
    else
        applied = WriteSaveParameterRanks(param, newRanks)
        if applied then
            ConsumePaidSouls(ctx, paid)
        else
            for itemName, n in pairs(paid) do
                ctx.SoulBag[itemName] = (ctx.SoulBag[itemName] or 0) + n
            end
            return nil
        end
    end

    if not applied then
        return nil
    end
    return table.concat(parts, " ")
end

local function UpgradeSlots(palSlots, sourceName, ctx, isOtomo)
    local upgradedCount = 0
    local soulCount = 0
    local totalPals = 0
    if not palSlots then
        return 0, 0, 0
    end
    print(string.format("[MassRankUp] Scanning %s (Total slots: %d)...", sourceName, #palSlots))
    for i = 1, #palSlots do
        local palSlot = palSlots[i]
        if palSlot and palSlot:IsValid() and not palSlot:IsEmpty() then
            totalPals = totalPals + 1
            local handle = palSlot:GetHandle()
            if handle and handle:IsValid() then
                local param = handle:TryGetIndividualParameter()
                if param and param:IsValid() then
                    local currentRank = param:GetRank()
                    if currentRank < 5 and not ctx.OutOfFruit then
                        local fruitSlot = FindRankFruitSlot(ctx.InventoryData, currentRank)
                        if fruitSlot ~= nil then
                            fruitSlot:RequestUseToCharacter(handle:GetIndividualID(), 1)
                            upgradedCount = upgradedCount + 1
                            local curStars = currentRank - 1
                            local newStars = curStars + 1
                            print(string.format("[MassRankUp] [%s Slot %d] Upgraded Stars: %d★ -> %d★ %s",
                                sourceName, i, curStars, newStars, (newStars == 4 and "(MAX!)" or "")))
                        else
                            print(string.format("[MassRankUp] Out of suitable rank fruits in inventory! Stars upgraded: %d", upgradedCount))
                            ctx.OutOfFruit = true
                        end
                    end
                    local soulInfo = ApplySoulsToPal(handle, param, ctx, isOtomo)
                    if soulInfo then
                        soulCount = soulCount + 1
                        print(string.format("[MassRankUp] [%s Slot %d] Souls: %s", sourceName, i, soulInfo))
                    end
                end
            end
        end
    end
    return upgradedCount, totalPals, soulCount
end

local function GetPartySlots(PalUtility, WorldContext)
    local holder = PalUtility:GetOtomoHolderComponent(WorldContext)
    if not holder or not holder:IsValid() then
        return nil
    end
    local container = holder.CharacterContainer
    if container and container:IsValid() and container.SlotArray then
        return container.SlotArray
    end
    local maxNum = holder:GetMaxOtomoNum()
    if type(maxNum) ~= "number" or maxNum < 1 then
        maxNum = 5
    end
    local slots = {}
    for i = 0, maxNum - 1 do
        local slot = holder:GetOtomoIndividualCharacterSlot(i)
        if slot and slot:IsValid() then
            slots[#slots + 1] = slot
        end
    end
    return slots
end

local function ResolveStatusComp(WorldContext)
    local StatusCompCDO = StaticFindObject("/Script/Pal.Default__PalNetworkCharacterStatusOperationComponent")
    if StatusCompCDO and StatusCompCDO:IsValid() then
        local inst = StatusCompCDO:NetCharacterStatusOperation(WorldContext)
        if inst and inst:IsValid() then
            return inst
        end
    end
    local found = FindFirstOf("PalNetworkCharacterStatusOperationComponent")
    if found and found:IsValid() then
        return found
    end
    return nil
end

local function ResolveItemNet()
    local transmitter = FindFirstOf("PalNetworkTransmitter")
    if transmitter and transmitter:IsValid() then
        local ok, itemNet = pcall(function()
            return transmitter:GetItem()
        end)
        if ok and itemNet and itemNet:IsValid() then
            return itemNet
        end
    end
    local found = FindFirstOf("PalNetworkItemComponent")
    if found and found:IsValid() then
        return found
    end
    return nil
end

local function MassUpgradePals()
    if isProcessing then
        print("[MassRankUp] Process is already running, please wait...")
        return
    end
    if not Config.UpgradePalbox and not Config.UpgradeParty then
        print("[MassRankUp] Both UpgradePalbox and UpgradeParty are false. Nothing to do.")
        return
    end
    isProcessing = true

    local PalUtility = StaticFindObject("/Script/Pal.Default__PalUtility")
    if not PalUtility:IsValid() then
        print("[MassRankUp] Error: PalUtility CDO not found.")
        isProcessing = false
        return
    end

    local WorldContext = FindFirstOf("PalPlayerCharacter")
    if not WorldContext:IsValid() then
        print("[MassRankUp] Error: Player character not found in world.")
        isProcessing = false
        return
    end

    local PlayerController = PalUtility:GetLocalPalPlayerController(WorldContext)
    if not PlayerController:IsValid() then
        print("[MassRankUp] Error: PlayerController not found.")
        isProcessing = false
        return
    end

    local PlayerState = PlayerController:GetPalPlayerState()
    if not PlayerState:IsValid() then
        print("[MassRankUp] Error: PlayerState not found.")
        isProcessing = false
        return
    end

    local InventoryData = PlayerState:GetInventoryData()
    if not InventoryData:IsValid() then
        print("[MassRankUp] Error: Inventory Data unavailable.")
        isProcessing = false
        return
    end

    local ctx = {
        InventoryData = InventoryData,
        WorldContext = WorldContext,
        OutOfFruit = false,
        SoulBag = nil,
        SoulSlots = nil,
        StatusComp = nil,
        ItemNet = nil,
    }

    if AnySoulStatEnabled() then
        local bag, slots = CollectSoulBag(InventoryData)
        ctx.SoulBag = bag
        ctx.SoulSlots = slots
        if not SoulBagHasAny(ctx.SoulBag) then
            print("[MassRankUp] No Pal Souls in inventory.")
            ctx.SoulBag = nil
            ctx.SoulSlots = nil
        else
            ctx.StatusComp = ResolveStatusComp(WorldContext)
            ctx.ItemNet = ResolveItemNet()
            if not ctx.StatusComp then
                print("[MassRankUp] Warning: Soul RPC not found. Party souls will use SaveParameter write.")
            end
        end
    end

    local upgradedCount = 0
    local totalPals = 0
    local soulCount = 0

    if Config.UpgradeParty then
        local partySlots = GetPartySlots(PalUtility, WorldContext)
        if not partySlots then
            print("[MassRankUp] Error: Party (OtomoHolder) not found.")
        else
            local up, pals, souls = UpgradeSlots(partySlots, "Party", ctx, true)
            upgradedCount = upgradedCount + up
            totalPals = totalPals + pals
            soulCount = soulCount + souls
        end
    end

    if Config.UpgradePalbox then
        local PalStorage = PlayerState:GetPalStorage()
        if not PalStorage:IsValid() then
            print("[MassRankUp] Error: Pal Storage unavailable.")
        else
            local PalContainer = PalStorage.TargetContainer
            if not PalContainer:IsValid() or not PalContainer.SlotArray then
                print("[MassRankUp] Error: Palbox slot container not initialized.")
            else
                local up, pals, souls = UpgradeSlots(PalContainer.SlotArray, "Palbox", ctx, false)
                upgradedCount = upgradedCount + up
                totalPals = totalPals + pals
                soulCount = soulCount + souls
            end
        end
    end

    print(string.format("[MassRankUp] Finished! Total Pals: %d, Stars upgraded: %d, Souls applied: %d",
        totalPals, upgradedCount, soulCount))
    isProcessing = false
end

RegisterKeyBind(Config.Hotkey, function()
    print("[MassRankUp] Hotkey pressed: Starting mass Pal upgrade...")
    MassUpgradePals()
end)

print("[MassRankUp] Mod loaded. Palbox=" .. tostring(Config.UpgradePalbox)
    .. " Party=" .. tostring(Config.UpgradeParty)
    .. " Souls HP/ATK/DEF/Work="
    .. tostring(Config.UpgradeHP) .. "/"
    .. tostring(Config.UpgradeAttack) .. "/"
    .. tostring(Config.UpgradeDefense) .. "/"
    .. tostring(Config.UpgradeWorkSpeed))


