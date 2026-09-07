---@meta

---@class UBP_ActionLightningStrike_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field SkillSign UNiagaraComponent
local UBP_ActionLightningStrike_C = {}

---@param Effect APalSkillEffectBase
function UBP_ActionLightningStrike_C:OnSpawnEffect(Effect) end
function UBP_ActionLightningStrike_C:OnBeginAction() end
function UBP_ActionLightningStrike_C:OnBreakAction() end
function UBP_ActionLightningStrike_C:OnEndAction() end
---@param EntryPoint int32
function UBP_ActionLightningStrike_C:ExecuteUbergraph_BP_ActionLightningStrike(EntryPoint) end


