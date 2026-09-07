---@meta

---@class ABP_SkillEffect_BlastCannon_Omen_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field OmenEffect UNiagaraComponent
---@field MaxEffectDuration float
---@field ExplosionTime float
local ABP_SkillEffect_BlastCannon_Omen_C = {}

function ABP_SkillEffect_BlastCannon_Omen_C:ReceiveBeginPlay() end
function ABP_SkillEffect_BlastCannon_Omen_C:Explosion() end
---@param EntryPoint int32
function ABP_SkillEffect_BlastCannon_Omen_C:ExecuteUbergraph_BP_SkillEffect_BlastCannon_Omen(EntryPoint) end


