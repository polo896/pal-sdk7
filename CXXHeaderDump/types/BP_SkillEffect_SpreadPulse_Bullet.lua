---@meta

---@class ABP_SkillEffect_SpreadPulse_Bullet_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field SphereCollision USphereComponent
---@field MainEffect UNiagaraComponent
---@field ProjectileMovement UProjectileMovementComponent
---@field EffectDuration float
local ABP_SkillEffect_SpreadPulse_Bullet_C = {}

---@param NiagaraComp UNiagaraComponent
function ABP_SkillEffect_SpreadPulse_Bullet_C:SetRandomValueIntoNiagaraVariable(NiagaraComp) end
---@param SelfActor AActor
---@param OtherHitActor AActor
---@param IsHit boolean
function ABP_SkillEffect_SpreadPulse_Bullet_C:IsValidHit(SelfActor, OtherHitActor, IsHit) end
function ABP_SkillEffect_SpreadPulse_Bullet_C:ReceiveBeginPlay() end
---@param MyHitComponent UPrimitiveComponent
---@param OtherHitActor AActor
---@param OtherHitComponent UPrimitiveComponent
---@param FoliageIndex TArray<int32>
---@param HitLocation FVector
---@param HitCount int32
ABP_SkillEffect_SpreadPulse_Bullet_C['OnHitDelegate_イベント_0'] = function(self, MyHitComponent, OtherHitActor, OtherHitComponent, FoliageIndex, HitLocation, HitCount) end
---@param DeltaSecond double
function ABP_SkillEffect_SpreadPulse_Bullet_C:FadeOutEffect(DeltaSecond) end
function ABP_SkillEffect_SpreadPulse_Bullet_C:OnHitGround() end
---@param Defencer AActor
---@param DamageInfo FPalDamageInfo
---@param HitCount int32
---@param AttackerComponent UPrimitiveComponent
function ABP_SkillEffect_SpreadPulse_Bullet_C:BndEvt__BP_SkillEffect_SpreadPulse_Bullet_AttackFilter_K2Node_ComponentBoundEvent_1_OnAttackDelegate__DelegateSignature(Defencer, DamageInfo, HitCount, AttackerComponent) end
function ABP_SkillEffect_SpreadPulse_Bullet_C:ReachEndLife() end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_SpreadPulse_Bullet_C:BndEvt__BP_SkillEffect_SpreadPulse_Bullet_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param EntryPoint int32
function ABP_SkillEffect_SpreadPulse_Bullet_C:ExecuteUbergraph_BP_SkillEffect_SpreadPulse_Bullet(EntryPoint) end


