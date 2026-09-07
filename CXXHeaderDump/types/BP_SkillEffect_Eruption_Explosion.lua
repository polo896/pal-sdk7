---@meta

---@class ABP_SkillEffect_Eruption_Explosion_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ExplosionEffect UNiagaraComponent
---@field ImpactDamage USphereComponent
---@field MaxEffectDuration float
---@field CollisionEnableTime float
local ABP_SkillEffect_Eruption_Explosion_C = {}

function ABP_SkillEffect_Eruption_Explosion_C:ReceiveBeginPlay() end
function ABP_SkillEffect_Eruption_Explosion_C:EndEffect() end
function ABP_SkillEffect_Eruption_Explosion_C:CollisionDisable() end
---@param EntryPoint int32
function ABP_SkillEffect_Eruption_Explosion_C:ExecuteUbergraph_BP_SkillEffect_Eruption_Explosion(EntryPoint) end


