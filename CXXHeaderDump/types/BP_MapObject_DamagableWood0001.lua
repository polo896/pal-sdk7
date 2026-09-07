---@meta

---@class ABP_MapObject_DamagableWood0001_C : APalMapObject
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field CheckOverlapCollision UBoxComponent
---@field WorkableBounds UBoxComponent
---@field IndicatorOrigin UArrowComponent
---@field DropItemParameter UPalMapObjectDropItemParameterComponent
---@field BP_InteractableSphere UPalInteractableSphereComponentNative
---@field Mesh UStaticMeshComponent
---@field DefaultSceneRoot USceneComponent
local ABP_MapObject_DamagableWood0001_C = {}

---@return FPalObjectPoolParameter
function ABP_MapObject_DamagableWood0001_C:GetObjectPoolParameter() end
function ABP_MapObject_DamagableWood0001_C:InitializeFromPool() end
function ABP_MapObject_DamagableWood0001_C:ReturnToPool() end
---@param EntryPoint int32
function ABP_MapObject_DamagableWood0001_C:ExecuteUbergraph_BP_MapObject_DamagableWood0001(EntryPoint) end


