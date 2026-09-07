---@meta

---@class ABP_SkillEffect_FireBlastShoot_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field BulletClass TSubclassOf<APalSkillEffectBase>
---@field ShootIntervalTime double
---@field TimeHandle FTimerHandle
local ABP_SkillEffect_FireBlastShoot_C = {}

---@param DestroyedActor AActor
ABP_SkillEffect_FireBlastShoot_C['OnDestroyed_イベント_0'] = function(self, DestroyedActor) end
function ABP_SkillEffect_FireBlastShoot_C:ReceiveBeginPlay() end
---@param PSystem UParticleSystemComponent
ABP_SkillEffect_FireBlastShoot_C['OnSystemFinished_イベント_0'] = function(self, PSystem) end
function ABP_SkillEffect_FireBlastShoot_C:Shoot() end
---@param EntryPoint int32
function ABP_SkillEffect_FireBlastShoot_C:ExecuteUbergraph_BP_SkillEffect_FireBlastShoot(EntryPoint) end


