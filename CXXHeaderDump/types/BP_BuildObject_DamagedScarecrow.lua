---@meta

---@class ABP_BuildObject_DamagedScarecrow_C : APalBuildObject
---@field UberGraphFrame FPointerToUberGraphFrame
---@field PalBodyPartsCapsule UPalBodyPartsCapsuleComponent
---@field PalBodyPartsSphere UPalBodyPartsSphereComponent
---@field SM_DamagedScarecrow UStaticMeshComponent
---@field NavmeshCollision UBoxComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field BuildWorkableBounds UBoxComponent
---@field CheckOverlapCollision UBoxComponent
---@field DefaultSceneRoot USceneComponent
local ABP_BuildObject_DamagedScarecrow_C = {}

function ABP_BuildObject_DamagedScarecrow_C:ReceiveBeginPlay() end
function ABP_BuildObject_DamagedScarecrow_C:OnAvailable_BlueprintImpl() end
---@param EntryPoint int32
function ABP_BuildObject_DamagedScarecrow_C:ExecuteUbergraph_BP_BuildObject_DamagedScarecrow(EntryPoint) end


