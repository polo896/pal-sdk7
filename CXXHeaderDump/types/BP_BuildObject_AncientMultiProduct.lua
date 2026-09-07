---@meta

---@class ABP_BuildObject_AncientMultiProduct_C : APalBuildObjectMultiProduct
---@field UberGraphFrame FPointerToUberGraphFrame
---@field VirtualMeshCollision UCapsuleComponent
---@field PalMapObjectSkeletalMesh UPalMapObjectSkeletalMeshComponent
---@field CheckOverlapCollision UBoxComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field WorkFacing UPalWorkFacingComponent
---@field MultiProductParameter UPalMapObjectMultiProductParameterComponent
---@field BuildWorkableBounds UBoxComponent
local ABP_BuildObject_AncientMultiProduct_C = {}

function ABP_BuildObject_AncientMultiProduct_C:PlayAnimationProductModeChanged() end
function ABP_BuildObject_AncientMultiProduct_C:OnAvailable_BlueprintImpl() end
---@param EntryPoint int32
function ABP_BuildObject_AncientMultiProduct_C:ExecuteUbergraph_BP_BuildObject_AncientMultiProduct(EntryPoint) end


