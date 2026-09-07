---@meta

---@class UBP_ActionHydroPump_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field EndEffect UNiagaraSystem
---@field EndEffectTimeOffset float
local UBP_ActionHydroPump_C = {}

UBP_ActionHydroPump_C['カスタムイベント_0'] = function(self, ) end
---@param Effect APalSkillEffectBase
function UBP_ActionHydroPump_C:OnSpawnEffect(Effect) end
---@param EntryPoint int32
function UBP_ActionHydroPump_C:ExecuteUbergraph_BP_ActionHydroPump(EntryPoint) end


