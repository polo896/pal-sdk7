---@meta

---@class ABP_BuildObject_AncientEnergyGenerator_C : APalBuildObjectGenerateEnergy
---@field EffectAttachment USceneComponent
---@field PalMapObjectSkeletalMesh UPalMapObjectSkeletalMeshComponent
---@field OperationalLoadParameter UPalMapObjectOperationalLoadParameterComponent
---@field BP_BuildObjectSimulateArrowComponent UBP_BuildObjectSimulateArrowComponent_C
---@field GenerateEnergyParameter UPalMapObjectGenerateEnergyParameterComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field BuildWorkableBounds UBoxComponent
---@field CheckOverlapCollision UBoxComponent
---@field Root USceneComponent
---@field PlayingFX UNiagaraComponent
local ABP_BuildObject_AncientEnergyGenerator_C = {}

function ABP_BuildObject_AncientEnergyGenerator_C:OnEndOverHeatCoolingWork() end
function ABP_BuildObject_AncientEnergyGenerator_C:OnStartOverHeatCoolingWork() end
function ABP_BuildObject_AncientEnergyGenerator_C:OnEndGenerate() end
function ABP_BuildObject_AncientEnergyGenerator_C:OnStartGenerate() end


