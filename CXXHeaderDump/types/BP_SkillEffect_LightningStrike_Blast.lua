---@meta

---@class ABP_SkillEffect_LightningStrike_Blast_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field NS_Hedgehog_Grenade UNiagaraComponent
---@field Sphere USphereComponent
---@field EffectDuration double
local ABP_SkillEffect_LightningStrike_Blast_C = {}

function ABP_SkillEffect_LightningStrike_Blast_C:ReceiveBeginPlay() end
function ABP_SkillEffect_LightningStrike_Blast_C:DisableCollision() end
function ABP_SkillEffect_LightningStrike_Blast_C:EffectTimeout() end
---@param EntryPoint int32
function ABP_SkillEffect_LightningStrike_Blast_C:ExecuteUbergraph_BP_SkillEffect_LightningStrike_Blast(EntryPoint) end


