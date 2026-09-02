---@meta

---@class UBP_ActionTremor_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
local UBP_ActionTremor_C = {}

---@param Effect APalSkillEffectBase
function UBP_ActionTremor_C:OnSpawnEffect(Effect) end
function UBP_ActionTremor_C:OnStartReadyAnimation() end
---@param EntryPoint int32
function UBP_ActionTremor_C:ExecuteUbergraph_BP_ActionTremor(EntryPoint) end


