---@meta

---@class ABP_BuildObject_StationDeforest3_C : APalBuildObject
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Box UBoxComponent
---@field CheckOverlapCollision UBoxComponent
---@field ['PalWorkFacing '] UPalWorkFacingComponent
---@field ['PalWorkFacing 1'] UPalWorkFacingComponent
---@field ['PalWorkFacing 2'] UPalWorkFacingComponent
---@field SM_Loggingcamp_Tree UStaticMeshComponent
---@field SM_Loggingcamp_Fence UStaticMeshComponent
---@field StaticMesh UStaticMeshComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field BuildWorkableBounds UBoxComponent
---@field Scene USceneComponent
---@field ItemSimpleProductParameter UPalMapObjectItemSimpleProductParameterComponent
---@field Root USceneComponent
local ABP_BuildObject_StationDeforest3_C = {}

---@param On boolean
function ABP_BuildObject_StationDeforest3_C:SetActive_Internal(On) end
function ABP_BuildObject_StationDeforest3_C:ReceiveBeginPlay() end
function ABP_BuildObject_StationDeforest3_C:OnAvailable_BlueprintImpl() end
---@param EntryPoint int32
function ABP_BuildObject_StationDeforest3_C:ExecuteUbergraph_BP_BuildObject_StationDeforest3(EntryPoint) end


