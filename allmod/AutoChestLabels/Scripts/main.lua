-- ============================================================================
-- Auto Chest Labels - By Wol4ara896
-- ============================================================================

-- ============================== CONFIGURATION ================================
local Config = {
    FAST_SCAN_INTERVAL = 2000, -- ms: distance / visibility / cleanup
    CONTENT_SCAN_INTERVAL = 1000, -- ms: process a small content batch
    CONTENT_BATCH_SIZE = 5,
    CONTENT_REFRESH_SECONDS = 5.0, -- non-empty container or custom name
    EMPTY_REFRESH_SECONDS = 8.0, -- empty containers are checked less frequently
    FULL_RESCAN_INTERVAL = 300000, -- 5 minutes
    MAX_DISTANCE = 2000.0, -- 20 meters
    
    SHOW_SLOT_USAGE = true,

    LABEL_WORLD_SIZE = 32.0,
    LABEL_TOP_GAP = 38.0, -- gap above the top boundary of the model
    OUTLINE_SCALE = 1.03, -- black text slightly larger than the main text
    OUTLINE_BACK_OFFSET = 0.75, -- offset behind the text plane
    USE_OUTLINE = true,
}

local MaxDistSq = Config.MAX_DISTANCE * Config.MAX_DISTANCE

local ITEM_COLOR    = {R = 255, G = 0, B = 0,  A = 255}
local EMPTY_COLOR   = {R = 120, G = 235, B = 255, A = 255}
local OUTLINE_COLOR = {R = 1,   G = 1,   B = 1,   A = 255}

local BlacklistKeywords = {
    "PalBox",
    "ToolBox",
    "Toolbox",
}

local StorageKeywords = {
    "Chest", "Box", "Container", "Shelf", "Locker", "Cabinet",
    "Barrel", "Cooler", "Refrigerator", "Wardrobe", "Bookshelf", "Dispenser"
}

local Cache = {}
local ActiveList = {}
local ScratchActiveList = {}
local ActiveCount = 0
local ContentCursor = 1

local CachedPlayer = nil
local TextClass = nil
local OpaqueTextMaterial = nil

local ScratchItemCounts = {}
local FormattedNameCache = {}

local function IsValidObject(Object)
    return Object and Object:IsValid()
end

local function IsVector(Value)
    if not Value then return false end

    local ok, X, Y, Z = pcall(function()
        return Value.X, Value.Y, Value.Z
    end)

    return ok and type(X) == "number" and type(Y) == "number" and type(Z) == "number"
end

local function ExtractFirstTwoVectors(A, B, C, D)
    local First = nil
    local Second = nil

    local function Take(Value)
        if IsVector(Value) then
            if not First then
                First = Value
            elseif not Second then
                Second = Value
            end
        end
    end

    Take(A)
    Take(B)
    Take(C)
    Take(D)

    return First, Second
end

local function IsStorageClass(ClassName)
    local lowerClassName = string.lower(ClassName)
    for i = 1, #BlacklistKeywords do
        if string.find(lowerClassName, string.lower(BlacklistKeywords[i]), 1, true) then
            return false
        end
    end

    for i = 1, #StorageKeywords do
        if string.find(ClassName, StorageKeywords[i], 1, true) then
            return true
        end
    end

    return false
end

local function IsChestAlive(Chest)
    if not IsValidObject(Chest) then return false end

    local Root = Chest.RootComponent
    return IsValidObject(Root)
end

local function GetActivePlayer()
    if IsValidObject(CachedPlayer) then
        local Root = CachedPlayer.RootComponent
        if IsValidObject(Root) then
            return CachedPlayer
        end
    end

    CachedPlayer = nil

    local Player = FindFirstOf("PalPlayerCharacter")
    if not IsValidObject(Player) then return nil end

    local Root = Player.RootComponent
    if not IsValidObject(Root) then return nil end

    CachedPlayer = Player
    return Player
end

local function GetClassFallbackHeight(ClassName)
    if not ClassName then return 145.0 end

    if string.find(ClassName, "Container", 1, true) then return 330.0 end
    if string.find(ClassName, "Locker", 1, true) then return 285.0 end
    if string.find(ClassName, "Cabinet", 1, true) then return 285.0 end
    if string.find(ClassName, "Wardrobe", 1, true) then return 300.0 end
    if string.find(ClassName, "Refrigerator", 1, true) then return 285.0 end
    if string.find(ClassName, "Bookshelf", 1, true) then return 270.0 end
    if string.find(ClassName, "Shelf", 1, true) then return 235.0 end
    if string.find(ClassName, "Dispenser", 1, true) then return 220.0 end
    if string.find(ClassName, "Barrel", 1, true) then return 165.0 end
    if string.find(ClassName, "Cooler", 1, true) then return 145.0 end

    return 145.0
end

local function TryGetActorBounds(Chest)
    local Dummy1 = {X = 0, Y = 0, Z = 0}
    local Dummy2 = {X = 0, Y = 0, Z = 0}

    local ok, A, B, C, D = pcall(function()
        return Chest:GetActorBounds(true, Dummy1, Dummy2, false)
    end)

    if ok then
        local Origin, Extent = ExtractFirstTwoVectors(A, B, C, D)

        if not Origin and IsVector(Dummy1) and (Dummy1.X ~= 0 or Dummy1.Y ~= 0 or Dummy1.Z ~= 0) then
            Origin = Dummy1
        end
        if not Extent and IsVector(Dummy2) and (Dummy2.X ~= 0 or Dummy2.Y ~= 0 or Dummy2.Z ~= 0) then
            Extent = Dummy2
        end

        if Origin and Extent and type(Extent.Z) == "number" and math.abs(Extent.Z) > 1.0 then
            return Origin, Extent
        end
    end

    local Root = Chest.RootComponent
    if IsValidObject(Root) then
        local okRoot, Origin, Extent = pcall(function()
            return Root.Bounds.Origin, Root.Bounds.BoxExtent
        end)

        if okRoot and IsVector(Origin) and IsVector(Extent) and type(Extent.Z) == "number" and math.abs(Extent.Z) > 1.0 then
            return Origin, Extent
        end
    end

    return nil, nil
end

local function GetLabelWorldLocation(Chest, ClassName)

    local isRefined = false
    pcall(function()
        if Chest.BuildObjectId and Chest.BuildObjectId:ToString() == "ItemChest_03" then
            isRefined = true
        end
    end)

    if isRefined then
        local ActorLoc = Chest:K2_GetActorLocation()
        local FX, FY = 1.0, 0.0
        pcall(function()
            local Fwd = Chest:GetActorForwardVector()
            if Fwd then
                local Len = math.sqrt(Fwd.X * Fwd.X + Fwd.Y * Fwd.Y)
                if Len > 0.001 then
                    FX = Fwd.X / Len
                    FY = Fwd.Y / Len
                end
            end
        end)
        
        return {
            X = ActorLoc.X + FX * 52.0,
            Y = ActorLoc.Y + FY * 42.0,
            Z = ActorLoc.Z + 235.0,
        }
    end

    local Origin, Extent = TryGetActorBounds(Chest)

    if Origin and Extent then
        return {
            X = Origin.X,
            Y = Origin.Y,
            Z = Origin.Z + math.abs(Extent.Z) + Config.LABEL_TOP_GAP,
        }
    end

    local ActorLoc = Chest:K2_GetActorLocation()
    return {
        X = ActorLoc.X,
        Y = ActorLoc.Y,
        Z = ActorLoc.Z + GetClassFallbackHeight(ClassName),
    }
end

local function GetActorForwardXY(Chest)
    local ok, Forward = pcall(function()
        return Chest:GetActorForwardVector()
    end)

    if not ok or not IsVector(Forward) then
        return 1.0, 0.0
    end

    local Length = math.sqrt(Forward.X * Forward.X + Forward.Y * Forward.Y)
    if Length < 0.001 then return 1.0, 0.0 end

    return Forward.X / Length, Forward.Y / Length
end

local function WorldToActorRelative(Chest, WorldPos)
    local ActorLoc = Chest:K2_GetActorLocation()
    local DX = WorldPos.X - ActorLoc.X
    local DY = WorldPos.Y - ActorLoc.Y
    local DZ = WorldPos.Z - ActorLoc.Z

    local ok, Rot = pcall(function()
        return Chest:K2_GetActorRotation()
    end)

    if ok and Rot and type(Rot.Yaw) == "number" then
        local Yaw = math.rad(Rot.Yaw)
        local CosYaw = math.cos(Yaw)
        local SinYaw = math.sin(Yaw)

        return {
            X =  CosYaw * DX + SinYaw * DY,
            Y = -SinYaw * DX + CosYaw * DY,
            Z = DZ,
        }
    end

    return {X = DX, Y = DY, Z = DZ}
end

local function SetComponentWorldLocation(Comp, Chest, WorldPos)
    if not IsValidObject(Comp) then return false end

    local ok = pcall(function()
        Comp:K2_SetWorldLocation(WorldPos, false, {}, false)
    end)
    if ok then return true end

    local Relative = WorldToActorRelative(Chest, WorldPos)
    ok = pcall(function()
        Comp:K2_SetRelativeLocation(Relative, false, {}, false)
    end)

    return ok
end

local function GetChestContainer(Chest)
    if not IsChestAlive(Chest) then return nil end

    local ok, Container = pcall(function()
        local Model = Chest:GetModel()
        if not IsValidObject(Model) then return nil end

        local ConcreteModel = Model:GetConcreteModel(true)
        if not IsValidObject(ConcreteModel) then return nil end

        local ContainerModule = ConcreteModel:GetItemContainerModule()
        if not IsValidObject(ContainerModule) then return nil end

        return ContainerModule:GetContainer()
    end)

    if ok and IsValidObject(Container) then
        return Container
    end

    return nil
end

local function GetFormattedItemName(ItemName)
    local Cached = FormattedNameCache[ItemName]
    if Cached then return Cached end

    local Name = string.gsub(ItemName, "([a-z])([A-Z])", "%1 %2")
    Name = string.gsub(Name, "_", " ")
    Name = string.gsub(Name, "High Grade", "HQ")
    Name = string.gsub(Name, "Processed", "Proc.")
    Name = string.gsub(Name, "Medicine", "Med.")
    Name = string.gsub(Name, "Component", "Comp.")
    Name = string.gsub(Name, "Material", "Mat.")

    FormattedNameCache[ItemName] = Name
    return Name
end

local function GetChestCustomName(Chest)
    if not IsChestAlive(Chest) then return nil end
    local ok, CustomName = pcall(function()
        local Model = Chest:GetModel()
        if not IsValidObject(Model) then return nil end

        local NameFStr = nil
        pcall(function() NameFStr = Model:GetCustomName() end)
        if not NameFStr then
            pcall(function() NameFStr = Model.CustomName end)
        end

        if NameFStr then
            local NameStr = NameFStr:ToString()
            if NameStr and NameStr ~= "" then
                return NameStr
            end
        end
        return nil
    end)
    if ok and CustomName then
        return CustomName
    end
    return nil
end

local function ClearScratchItemCounts()
    for Key in pairs(ScratchItemCounts) do
        ScratchItemCounts[Key] = nil
    end
end

local function GetMostAbundantItemText(Container)
    if not IsValidObject(Container) then return "Empty" end

    local Slots = Container.ItemSlotArray
    if not Slots or #Slots == 0 then return "Empty" end

    ClearScratchItemCounts()

    local TotalSlots = #Slots
    local UsedSlots = 0
    local MaxItem = nil
    local MaxCount = 0

    for i = 1, TotalSlots do
        local Slot = Slots[i]
        if IsValidObject(Slot) and not Slot:IsEmpty() then
            UsedSlots = UsedSlots + 1
            local StackCount = Slot:GetStackCount()
            local ItemId = Slot:GetItemId()

            if ItemId and ItemId.StaticId then
                local ItemName = ItemId.StaticId:ToString()
                if ItemName and ItemName ~= "None" then
                    local NewCount = (ScratchItemCounts[ItemName] or 0) + StackCount
                    ScratchItemCounts[ItemName] = NewCount

                    if NewCount > MaxCount then
                        MaxItem = ItemName
                        MaxCount = NewCount
                    end
                end
            end
        end
    end

    if not MaxItem then
        if Config.SHOW_SLOT_USAGE and TotalSlots > 0 then
            return string.format("Empty\n0/%d", TotalSlots)
        end
        return "Empty"
    end

    if Config.SHOW_SLOT_USAGE and TotalSlots > 0 then
        return string.format("%s x%d\n%d/%d", GetFormattedItemName(MaxItem), MaxCount, UsedSlots, TotalSlots)
    end

    return string.format("%s\nx%d", GetFormattedItemName(MaxItem), MaxCount)
end

local function SetTextColor(Comp, Color)
    if not IsValidObject(Comp) then return end

    local ok = pcall(function()
        Comp:SetTextRenderColor(Color)
    end)

    if not ok then
        pcall(function()
            Comp.TextRenderColor = Color
        end)
    end
end

local function SetTextValue(Comp, Value)
    if not IsValidObject(Comp) then return false end

    local ok = pcall(function()
        Comp:K2_SetText(FText(Value))
    end)

    if not ok then
        ok = pcall(function()
            Comp:SetText(Value)
        end)
    end

    return ok
end

local function ConfigureTextComponent(Comp, Scale, Color)
    if not IsValidObject(Comp) then return end

    pcall(function() Comp:SetWorldSize(Config.LABEL_WORLD_SIZE) end)
    pcall(function() Comp:SetHorizontalAlignment(1) end)
    pcall(function() Comp:SetVerticalAlignment(2) end)
    pcall(function() Comp:SetXScale(Scale) end)
    pcall(function() Comp:SetYScale(Scale) end)

    pcall(function()
        Comp.WorldSize = Config.LABEL_WORLD_SIZE
        Comp.HorizontalAlignment = 1
        Comp.VerticalAlignment = 2
        Comp.XScale = Scale
        Comp.YScale = Scale
        Comp.bAlwaysRenderAsText = 1
    end)

    if IsValidObject(OpaqueTextMaterial) then
        pcall(function()
            Comp:SetTextMaterial(OpaqueTextMaterial)
        end)
    end

    SetTextColor(Comp, Color)

    pcall(function() Comp:SetCastShadow(false) end)
    pcall(function() Comp:SetGenerateOverlapEvents(false) end)
    pcall(function() Comp:SetCollisionEnabled(0) end)
end

local function ConstructTextComponent(Chest, ComponentName, Scale, Color, WorldPos)
    local Comp = StaticConstructObject(TextClass, Chest, FName(ComponentName))
    if not IsValidObject(Comp) then return nil end

    ConfigureTextComponent(Comp, Scale, Color)

    local Added = pcall(function()
        Chest:FinishAddComponent(Comp, false, {
            Rotation = {X = 0, Y = 0, Z = 0, W = 1},
            Translation = {X = 0, Y = 0, Z = 145},
            Scale3D = {X = 1, Y = 1, Z = 1}
        })
    end)

    if not Added then
        pcall(function() Comp:K2_DestroyComponent(Comp) end)
        return nil
    end

    SetComponentWorldLocation(Comp, Chest, WorldPos)
    pcall(function() Comp:SetVisibility(false, false) end)

    return Comp
end

local function CreateLabelComponents(Chest, ClassName)
    if not IsChestAlive(Chest) or not IsValidObject(TextClass) then
        return nil, nil
    end

    local MainPos = GetLabelWorldLocation(Chest, ClassName)

    local MainComp = ConstructTextComponent(
        Chest,
        "ChestLabel_Main_v2",
        1.0,
        ITEM_COLOR,
        MainPos
    )

    if not MainComp then return nil, nil end

    local OutlineComp = nil

    if Config.USE_OUTLINE then
        local FX, FY = GetActorForwardXY(Chest)
        local OutlinePos = {
            X = MainPos.X - FX * Config.OUTLINE_BACK_OFFSET,
            Y = MainPos.Y - FY * Config.OUTLINE_BACK_OFFSET,
            Z = MainPos.Z,
        }

        OutlineComp = ConstructTextComponent(
            Chest,
            "ChestLabel_Outline_v2",
            Config.OUTLINE_SCALE,
            OUTLINE_COLOR,
            OutlinePos
        )
    end

    return MainComp, OutlineComp
end

local function SetLabelVisible(Entry, Visible)
    if IsValidObject(Entry.MainComp) then
        pcall(function() Entry.MainComp:SetVisibility(Visible, false) end)
    end

    if IsValidObject(Entry.OutlineComp) then
        pcall(function() Entry.OutlineComp:SetVisibility(Visible, false) end)
    end
end

local function UpdateLabel(Entry, Text)
    if not IsValidObject(Entry.MainComp) then return false end

    local MainColor = ITEM_COLOR
    if Text == "Empty" or string.sub(Text, 1, 5) == "Empty" then MainColor = EMPTY_COLOR end

    SetTextColor(Entry.MainComp, MainColor)
    local MainOK = SetTextValue(Entry.MainComp, Text)

    if IsValidObject(Entry.OutlineComp) then
        SetTextColor(Entry.OutlineComp, OUTLINE_COLOR)
        SetTextValue(Entry.OutlineComp, Text)
    end

    return MainOK
end

local function DestroyComponent(Comp)
    if IsValidObject(Comp) then
        pcall(function() Comp:K2_DestroyComponent(Comp) end)
    end
end

local function RemoveEntry(Object, Entry)
    if Entry then
        DestroyComponent(Entry.MainComp)
        DestroyComponent(Entry.OutlineComp)
    end

    Cache[Object] = nil
end

local function AddToCacheIfStorage(Object)
    if Cache[Object] then return end
    if not IsValidObject(Object) then return end

    local ok, ClassName = pcall(function()
        return Object:GetClass():GetFName():ToString()
    end)

    if not ok or not ClassName or not IsStorageClass(ClassName) then
        return
    end

    Cache[Object] = {
        Object = Object,
        ClassName = ClassName,
        MainComp = nil,
        OutlineComp = nil,
        Container = nil,
        Visible = false,
        NextContentRefresh = 0,
        LastText = nil,
    }
end

local function FullRescan()
    local BuiltObjects = FindAllOf("PalBuildObject")
    if not BuiltObjects then return end

    for _, Object in ipairs(BuiltObjects) do
        AddToCacheIfStorage(Object)
    end
end

pcall(function()
    NotifyOnNewObject("/Script/Pal.PalBuildObject", function(NewObject)
        AddToCacheIfStorage(NewObject)
    end)
end)

local function FastPass()
    local Player = GetActivePlayer()

    for i = 1, #ScratchActiveList do
        ScratchActiveList[i] = nil
    end

    local NewActiveCount = 0

    if not Player then
        for Object, Entry in pairs(Cache) do
            if not IsChestAlive(Object) then
                RemoveEntry(Object, Entry)
            elseif Entry.Visible then
                SetLabelVisible(Entry, false)
                Entry.Visible = false
            end
        end

        ActiveList, ScratchActiveList = ScratchActiveList, ActiveList
        ActiveCount = 0
        return
    end

    local PlayerLoc = Player:K2_GetActorLocation()
    local PX, PY, PZ = PlayerLoc.X, PlayerLoc.Y, PlayerLoc.Z

    for Object, Entry in pairs(Cache) do
        if not IsChestAlive(Object) then
            RemoveEntry(Object, Entry)
        else
            local ok, ObjectLoc = pcall(function()
                return Object:K2_GetActorLocation()
            end)

            if ok and ObjectLoc then
                local DX = PX - ObjectLoc.X
                local DY = PY - ObjectLoc.Y
                local DZ = PZ - ObjectLoc.Z
                local DistSq = DX * DX + DY * DY + DZ * DZ

                if DistSq <= MaxDistSq then
                    if not IsValidObject(Entry.MainComp) then
                        Entry.MainComp, Entry.OutlineComp = CreateLabelComponents(
                            Object,
                            Entry.ClassName
                        )
                    end

                    if IsValidObject(Entry.MainComp) then
                        if not Entry.Visible then
                            SetLabelVisible(Entry, true)
                            Entry.Visible = true
                            Entry.NextContentRefresh = 0
                        end

                        NewActiveCount = NewActiveCount + 1
                        ScratchActiveList[NewActiveCount] = Object
                    end
                elseif Entry.Visible then
                    SetLabelVisible(Entry, false)
                    Entry.Visible = false
                end
            end
        end
    end

    ActiveList, ScratchActiveList = ScratchActiveList, ActiveList
    ActiveCount = NewActiveCount

    if ContentCursor > ActiveCount then
        ContentCursor = 1
    end
end

local function ContentPass()
    if ActiveCount == 0 then return end

    local Now = os.clock()
    local Processed = 0
    local Checked = 0

    if ContentCursor > ActiveCount then ContentCursor = 1 end

    while Checked < ActiveCount and Processed < Config.CONTENT_BATCH_SIZE do
        local Object = ActiveList[ContentCursor]
        local Entry = Object and Cache[Object]

        if Entry and Entry.Visible and Now >= Entry.NextContentRefresh then
            local LabelText = GetChestCustomName(Object)
            local IsCustom = (LabelText ~= nil)

            if not IsCustom then
                if not IsValidObject(Entry.Container) then
                    Entry.Container = GetChestContainer(Object)
                end
                LabelText = GetMostAbundantItemText(Entry.Container)
            end

            if LabelText ~= Entry.LastText then
                if UpdateLabel(Entry, LabelText) then
                    Entry.LastText = LabelText
                end
            end

            if IsCustom then
                Entry.NextContentRefresh = Now + Config.CONTENT_REFRESH_SECONDS
            elseif LabelText == "Empty" or string.sub(LabelText, 1, 5) == "Empty" then
                Entry.NextContentRefresh = Now + Config.EMPTY_REFRESH_SECONDS
            else
                Entry.NextContentRefresh = Now + Config.CONTENT_REFRESH_SECONDS
            end

            Processed = Processed + 1
        end

        ContentCursor = ContentCursor + 1
        if ContentCursor > ActiveCount then ContentCursor = 1 end

        Checked = Checked + 1
    end
end

ExecuteInGameThread(function()
    TextClass = StaticFindObject("/Script/Engine.TextRenderComponent")

    pcall(function()
        OpaqueTextMaterial = StaticFindObject(
            "/Engine/EngineMaterials/DefaultTextMaterialOpaque.DefaultTextMaterialOpaque"
        )
    end)

    if not IsValidObject(OpaqueTextMaterial) then
        pcall(function()
            OpaqueTextMaterial = StaticFindObject(
                "/Engine/EngineMaterials/DefaultTextMaterialOpaque"
            )
        end)
    end

    pcall(FullRescan)
end)

LoopAsync(Config.FAST_SCAN_INTERVAL, function()
    ExecuteInGameThread(function()
        pcall(FastPass)
    end)
    return false
end)

LoopAsync(Config.CONTENT_SCAN_INTERVAL, function()
    ExecuteInGameThread(function()
        pcall(ContentPass)
    end)
    return false
end)

LoopAsync(Config.FULL_RESCAN_INTERVAL, function()
    ExecuteInGameThread(function()
        pcall(FullRescan)
    end)
    return false
end)

print("[ChestLabel] Loaded successfully!\n")