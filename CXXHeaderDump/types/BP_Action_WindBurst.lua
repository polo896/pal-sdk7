---@meta

---@class UBP_Action_WindBurst_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
local UBP_Action_WindBurst_C = {}

---@param Effect APalSkillEffectBase
function UBP_Action_WindBurst_C:OnSpawnEffect(Effect) end
function UBP_Action_WindBurst_C:OnStartReadyAnimation() end
---@param EntryPoint int32
function UBP_Action_WindBurst_C:ExecuteUbergraph_BP_Action_WindBurst(EntryPoint) end


