---@meta

---@class ABP_BuildObject_BaseCampWorkHard_03_C : APalBuildObject
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BaseCampPassiveEffectSanityWatchtowerParameter UPalMapObjectBaseCampPassiveEffectSanityWatchtowerParameterComponent
---@field SM_SurveillanceTableAncient UStaticMeshComponent
---@field BP_BuildObjectSimulateArrowComponent UBP_BuildObjectSimulateArrowComponent_C
---@field BaseCampPassiveEffectWorkHardParameter UPalMapObjectBaseCampPassiveEffectWorkHardParameterComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field BuildWorkableBounds UBoxComponent
---@field CheckOverlapCollision UBoxComponent
---@field Root USceneComponent
---@field WorkHardModel UPalMapObjectBaseCampPassiveWorkHardModel
---@field PassiveEffectWorkHard UPalBaseCampPassiveEffect_WorkHard
---@field WorkTypeMaterialIndexInfoDisplay int32
---@field WorkTypeMaterialInstanceInfoDisplay UMaterialInstanceDynamic
---@field WorkTypeMaterialIndexIconDisplay int32
---@field WorkTypeMaterialInstanceIconDisplay UMaterialInstanceDynamic
local ABP_BuildObject_BaseCampWorkHard_03_C = {}

---@param InIsValidWorkType boolean
---@param InWorkType EPalBaseCampPassiveEffectWorkHardType
function ABP_BuildObject_BaseCampWorkHard_03_C:UpdateWorkTypeMaterialInstanceIconDisplay(InIsValidWorkType, InWorkType) end
---@param InIsValidWorkType boolean
---@param InWorkType EPalBaseCampPassiveEffectWorkHardType
function ABP_BuildObject_BaseCampWorkHard_03_C:UpdateWorkTypeMaterialInstanceInfoDisplay(InIsValidWorkType, InWorkType) end
---@param InIsValidWorkType boolean
---@param InWorkType EPalBaseCampPassiveEffectWorkHardType
function ABP_BuildObject_BaseCampWorkHard_03_C:UpdateWorkTypeMaterialInstances(InIsValidWorkType, InWorkType) end
function ABP_BuildObject_BaseCampWorkHard_03_C:UpdateWorkTypeMaterials() end
---@param InPassiveEffectWorkHard UPalBaseCampPassiveEffect_WorkHard
function ABP_BuildObject_BaseCampWorkHard_03_C:OnUpdateWorkHardType(InPassiveEffectWorkHard) end
function ABP_BuildObject_BaseCampWorkHard_03_C:SetupWorkTypeMaterials() end
---@param InWorkHardModel UPalMapObjectBaseCampPassiveWorkHardModel
function ABP_BuildObject_BaseCampWorkHard_03_C:SetupWorkHardModel(InWorkHardModel) end
function ABP_BuildObject_BaseCampWorkHard_03_C:OnAvailable_BlueprintImpl() end
function ABP_BuildObject_BaseCampWorkHard_03_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_BuildObject_BaseCampWorkHard_03_C:ExecuteUbergraph_BP_BuildObject_BaseCampWorkHard_03(EntryPoint) end


