---@meta

---@class ABP_MapObject_MeteorDrop_Damagable_C : APalMapObject
---@field Mesh1 UStaticMeshComponent
---@field Niagara UNiagaraComponent
---@field CheckOverlapCollision UBoxComponent
---@field WorkableBounds UBoxComponent
---@field IndicatorOrigin UArrowComponent
---@field DropItemParameter UPalMapObjectDropItemParameterComponent
---@field BP_InteractableSphere UPalInteractableSphereComponentNative
---@field Mesh UStaticMeshComponent
---@field DefaultSceneRoot USceneComponent
local ABP_MapObject_MeteorDrop_Damagable_C = {}

---@return boolean
function ABP_MapObject_MeteorDrop_Damagable_C:IsShowOutlineInReticleTargetting() end


