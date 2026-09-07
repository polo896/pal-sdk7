---@meta

---@class ABP_BuildObject_FishingPond02_C : APalBuildObjectFishPond
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ToClimbBox_2 UBoxComponent
---@field ToClimbBox_1 UBoxComponent
---@field WaterBoxBody3 UBoxComponent
---@field WaterBoxBody2 UBoxComponent
---@field WaterBoxBody4 UBoxComponent
---@field WaterBoxBody UBoxComponent
---@field WaterBox4 UBoxComponent
---@field WaterBox3 UBoxComponent
---@field WaterBox2 UBoxComponent
---@field WaterBox UBoxComponent
---@field SM_FishingPond_Rodpillow UStaticMeshComponent
---@field SK_FishingFloat USkeletalMeshComponent
---@field Cable UCableComponent
---@field SkeletalMesh USkeletalMeshComponent
---@field FishPondParameter UPalMapObjectFishPondParameterComponent
---@field WorkFacing UPalWorkFacingComponent
---@field BP_InteractableBox_Chest UBP_InteractableBox_C
---@field CheckOverlapCollision UBoxComponent
---@field BuildWorkableBounds UBoxComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field SM_FishinPond UStaticMeshComponent
---@field DefaultSceneRoot USceneComponent
local ABP_BuildObject_FishingPond02_C = {}

---@param IsVisible boolean
function ABP_BuildObject_FishingPond02_C:SetBoxCollision(IsVisible) end
---@param IsVisible boolean
function ABP_BuildObject_FishingPond02_C:SetWaterCollision(IsVisible) end
function ABP_BuildObject_FishingPond02_C:ResetVisiblity() end
---@param DeltaSeconds float
function ABP_BuildObject_FishingPond02_C:ReceiveTick(DeltaSeconds) end
function ABP_BuildObject_FishingPond02_C:ReceiveBeginPlay() end
function ABP_BuildObject_FishingPond02_C:OnAvailable_BlueprintImpl() end
---@param EntryPoint int32
function ABP_BuildObject_FishingPond02_C:ExecuteUbergraph_BP_BuildObject_FishingPond02(EntryPoint) end


