---@meta

---@class ABP_SkillEffect_BastCannon_Explosion_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ExplosionEffect UNiagaraComponent
---@field ImpactDamage USphereComponent
---@field MaxEffectDuration float
---@field CollisionEnableTime float
local ABP_SkillEffect_BastCannon_Explosion_C = {}

function ABP_SkillEffect_BastCannon_Explosion_C:ReceiveBeginPlay() end
function ABP_SkillEffect_BastCannon_Explosion_C:EndEffect() end
---@param DeltaSecond double
function ABP_SkillEffect_BastCannon_Explosion_C:FadeOutEffect(DeltaSecond) end
function ABP_SkillEffect_BastCannon_Explosion_C:CollisionDisable() end
---@param EntryPoint int32
function ABP_SkillEffect_BastCannon_Explosion_C:ExecuteUbergraph_BP_SkillEffect_BastCannon_Explosion(EntryPoint) end


