---@meta

---@class ABP_BuildObject_BaseCampWorkHard_02_C : APalBuildObject
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BaseCampPassiveEffectSanityWatchtowerParameter UPalMapObjectBaseCampPassiveEffectSanityWatchtowerParameterComponent
---@field SM_SurveillanceTableAdvanced UStaticMeshComponent
---@field BP_BuildObjectSimulateArrowComponent UBP_BuildObjectSimulateArrowComponent_C
---@field BaseCampPassiveEffectWorkHardParameter UPalMapObjectBaseCampPassiveEffectWorkHardParameterComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field BuildWorkableBounds UBoxComponent
---@field CheckOverlapCollision UBoxComponent
---@field Root USceneComponent
---@field WorkTypeMaterialInstance UMaterialInstanceDynamic
---@field WorkHardModel UPalMapObjectBaseCampPassiveWorkHardModel
---@field PassiveEffectWorkHard UPalBaseCampPassiveEffect_WorkHard
local ABP_BuildObject_BaseCampWorkHard_02_C = {}

---@param PassiveEffectWorkHard UPalBaseCampPassiveEffect_WorkHard
ABP_BuildObject_BaseCampWorkHard_02_C['On Update Work Hard Type'] = function(self, PassiveEffectWorkHard) end
---@param InWorkHardModel UPalMapObjectBaseCampPassiveWorkHardModel
function ABP_BuildObject_BaseCampWorkHard_02_C:SetupWorkHardModel(InWorkHardModel) end
---@param IsValidWorkType boolean
---@param WorkType EPalBaseCampPassiveEffectWorkHardType
function ABP_BuildObject_BaseCampWorkHard_02_C:UpdateWorkTypeMaterialInstance(IsValidWorkType, WorkType) end
function ABP_BuildObject_BaseCampWorkHard_02_C:UpdateWorkTypeMaterial() end
function ABP_BuildObject_BaseCampWorkHard_02_C:SetupWorkTypeMaterial() end
---@param ConcreteModel UPalMapObjectConcreteModelBase
function ABP_BuildObject_BaseCampWorkHard_02_C:BP_OnSetConcreteModel(ConcreteModel) end
function ABP_BuildObject_BaseCampWorkHard_02_C:OnAvailable_BlueprintImpl() end
function ABP_BuildObject_BaseCampWorkHard_02_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_BuildObject_BaseCampWorkHard_02_C:ExecuteUbergraph_BP_BuildObject_BaseCampWorkHard_02(EntryPoint) end


