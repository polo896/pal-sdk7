---@meta

---@class ABP_Skill_ThunderFunnel_Bullet_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field NS_CommonSkill_ThunderFunnel_Bullet UNiagaraComponent
---@field Sphere USphereComponent
---@field ProjectileMovement UProjectileMovementComponent
---@field LifeTimeAfterDestroyFunnel double
local ABP_Skill_ThunderFunnel_Bullet_C = {}

function ABP_Skill_ThunderFunnel_Bullet_C:ReceiveBeginPlay() end
---@param Defencer AActor
---@param DamageInfo FPalDamageInfo
---@param HitCount int32
---@param AttackerComponent UPrimitiveComponent
function ABP_Skill_ThunderFunnel_Bullet_C:BndEvt__BP_SkillEffect_SpreadPulse_Bullet_AttackFilter_K2Node_ComponentBoundEvent_1_OnAttackDelegate__DelegateSignature(Defencer, DamageInfo, HitCount, AttackerComponent) end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_Skill_ThunderFunnel_Bullet_C:BndEvt__BP_SkillEffect_SpreadPulse_Bullet_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
function ABP_Skill_ThunderFunnel_Bullet_C:OnHitGround() end
---@param DeltaSecond double
function ABP_Skill_ThunderFunnel_Bullet_C:FadeOutEffect(DeltaSecond) end
---@param Delay double
function ABP_Skill_ThunderFunnel_Bullet_C:SetDelayFadeOutEffect(Delay) end
function ABP_Skill_ThunderFunnel_Bullet_C:SetDelayFadeOutEffectInternal() end
---@param EntryPoint int32
function ABP_Skill_ThunderFunnel_Bullet_C:ExecuteUbergraph_BP_Skill_ThunderFunnel_Bullet(EntryPoint) end


