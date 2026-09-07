---@meta

---@class ABP_BuildObject_TorchStand_C : ABP_BuildObject_Torch_Base_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_BuildObjectSimulateArrowComponent UBP_BuildObjectSimulateArrowComponent_C
---@field NS_TorchFire UNiagaraComponent
---@field BuildWorkableBounds UBoxComponent
---@field PointLight UPointLightComponent
---@field CheckOverlapCollision UBoxComponent
---@field SM_TorchStand UStaticMeshComponent
---@field BP_InteractableBox UBP_InteractableBox_C
local ABP_BuildObject_TorchStand_C = {}

---@param bActive boolean
function ABP_BuildObject_TorchStand_C:SetActiveLight(bActive) end
function ABP_BuildObject_TorchStand_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_BuildObject_TorchStand_C:ExecuteUbergraph_BP_BuildObject_TorchStand(EntryPoint) end


