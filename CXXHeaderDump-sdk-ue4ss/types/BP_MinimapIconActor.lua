---@meta

---@class UBP_MinimapIconActor_C : UActorComponent
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BaseScale float
---@field ZoomedScale float
---@field MinScale float
---@field MaxScale float
---@field bIsInitialized boolean
---@field IconMaterial UMaterialInterface
---@field DynMaterial UMaterialInstanceDynamic
---@field HeightOffset float
---@field ScaleMultiplier float
---@field ScaleSettingKey FString
---@field SortPriority int32
---@field LivenessCheckTimer float
---@field TrackedPal APalCharacter
---@field bHasTrackedPal boolean
---@field TrackedGenericActor AActor
---@field bHasTrackedGenericActor boolean
---@field bCheckPickedInClient boolean
---@field bLockRotationNorth boolean
---@field RenderComponent UPaperSpriteComponent
---@field SpringArm USpringArmComponent
---@field OwningModActor AModActor_C
local UBP_MinimapIconActor_C = {}

function UBP_MinimapIconActor_C:RemoveThisIcon() end
---@param Color FLinearColor
function UBP_MinimapIconActor_C:SetIconColor(Color) end
---@param IconTexture UTexture2D
function UBP_MinimapIconActor_C:SetIconTexture(IconTexture) end
function UBP_MinimapIconActor_C:EnsureInitialized() end
---@param Loaded UObject
function UBP_MinimapIconActor_C:OnLoaded_BDB42DA14F4F89E7FD75AD9B0A5B0267(Loaded) end
---@param Loaded UObject
function UBP_MinimapIconActor_C:OnLoaded_FA82268E4271A45C59C9BB87D0E41FD0(Loaded) end
---@param IconPath FSoftObjectPath
function UBP_MinimapIconActor_C:InitIconAsync(IconPath) end
---@param DeltaSeconds float
function UBP_MinimapIconActor_C:ReceiveTick(DeltaSeconds) end
---@param IconPath FSoftObjectPath
---@param RetriesRemaining int32
function UBP_MinimapIconActor_C:RetryLoadIcon(IconPath, RetriesRemaining) end
---@param EntryPoint int32
function UBP_MinimapIconActor_C:ExecuteUbergraph_BP_MinimapIconActor(EntryPoint) end


