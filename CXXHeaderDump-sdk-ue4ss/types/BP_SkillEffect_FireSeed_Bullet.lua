---@meta

---@class ABP_SkillEffect_FireSeed_Bullet_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Collision_0 USphereComponent
---@field ProjectileMovement_0 UProjectileMovementComponent
---@field NS_FireSeed_Bullet UNiagaraComponent
---@field RandSpeed float
---@field Gravity double
---@field MinSpeed double
---@field RandomStream_0 FRandomStream
---@field EffectLifeTime float
local ABP_SkillEffect_FireSeed_Bullet_C = {}

function ABP_SkillEffect_FireSeed_Bullet_C:ReceiveBeginPlay() end
---@param DeltaSecond double
function ABP_SkillEffect_FireSeed_Bullet_C:FadeOutEffect(DeltaSecond) end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_FireSeed_Bullet_C:BndEvt__BP_SkillEffect_FireSeed_Bullet_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param Defencer AActor
---@param DamageInfo FPalDamageInfo
---@param HitCount int32
---@param AttackerComponent UPrimitiveComponent
function ABP_SkillEffect_FireSeed_Bullet_C:BndEvt__BP_SkillEffect_AirCanon_AttackFilter_K2Node_ComponentBoundEvent_0_OnAttackDelegate__DelegateSignature(Defencer, DamageInfo, HitCount, AttackerComponent) end
---@param EntryPoint int32
function ABP_SkillEffect_FireSeed_Bullet_C:ExecuteUbergraph_BP_SkillEffect_FireSeed_Bullet(EntryPoint) end


