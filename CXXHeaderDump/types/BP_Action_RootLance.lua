---@meta

---@class UBP_Action_RootLance_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field SkillSign UNiagaraComponent
local UBP_Action_RootLance_C = {}

---@param Effect APalSkillEffectBase
function UBP_Action_RootLance_C:OnSpawnEffect(Effect) end
function UBP_Action_RootLance_C:OnBeginAction() end
function UBP_Action_RootLance_C:OnBreakAction() end
function UBP_Action_RootLance_C:OnEndAction() end
---@param EntryPoint int32
function UBP_Action_RootLance_C:ExecuteUbergraph_BP_Action_RootLance(EntryPoint) end


