---@meta

---@class ABP_SkillEffect_Tremor_Blast_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field EffectDuration double
---@field RockCount int32
local ABP_SkillEffect_Tremor_Blast_C = {}

function ABP_SkillEffect_Tremor_Blast_C:Explosion() end
function ABP_SkillEffect_Tremor_Blast_C:ReceiveBeginPlay() end
function ABP_SkillEffect_Tremor_Blast_C:EffectTimeout() end
---@param EntryPoint int32
function ABP_SkillEffect_Tremor_Blast_C:ExecuteUbergraph_BP_SkillEffect_Tremor_Blast(EntryPoint) end


