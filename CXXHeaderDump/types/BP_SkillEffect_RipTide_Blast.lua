---@meta

---@class ABP_SkillEffect_RipTide_Blast_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Capsule UCapsuleComponent
---@field Niagara UNiagaraComponent
local ABP_SkillEffect_RipTide_Blast_C = {}

function ABP_SkillEffect_RipTide_Blast_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_SkillEffect_RipTide_Blast_C:ExecuteUbergraph_BP_SkillEffect_RipTide_Blast(EntryPoint) end


