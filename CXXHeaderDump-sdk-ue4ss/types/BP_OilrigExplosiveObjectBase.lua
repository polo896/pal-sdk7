---@meta

---@class ABP_OilrigExplosiveObjectBase_C : APalOilrigExplosiveObject
---@field UberGraphFrame FPointerToUberGraphFrame
---@field StaticMesh UStaticMeshComponent
---@field BP_PalDamageExplodeComponent UBP_PalDamageExplodeComponent_C
---@field DefaultSceneRoot USceneComponent
local ABP_OilrigExplosiveObjectBase_C = {}

function ABP_OilrigExplosiveObjectBase_C:ReceiveBeginPlay() end
function ABP_OilrigExplosiveObjectBase_C:PlayDestroyEffect() end
function ABP_OilrigExplosiveObjectBase_C:ChangeDestroyedVisual_BP() end
function ABP_OilrigExplosiveObjectBase_C:ChangeDefaultVisual_BP() end
---@param EntryPoint int32
function ABP_OilrigExplosiveObjectBase_C:ExecuteUbergraph_BP_OilrigExplosiveObjectBase(EntryPoint) end


