---@meta

---@class ABP_SkillEffectFireBall_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field aura UNiagaraComponent
---@field ball UNiagaraComponent
---@field ProjectileMovement UProjectileMovementComponent
---@field BallDamage USphereComponent
---@field ReadyTime double
---@field TargetActor AActor
---@field ImpactEffect UNiagaraSystem
---@field ImpactPoint FVector
local ABP_SkillEffectFireBall_C = {}

function ABP_SkillEffectFireBall_C:ReceiveBeginPlay() end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffectFireBall_C:BndEvt__BP_SkillEffectFireBall_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param Defencer AActor
---@param DamageInfo FPalDamageInfo
---@param HitCount int32
---@param AttackerComponent UPrimitiveComponent
function ABP_SkillEffectFireBall_C:BndEvt__BP_SkillEffect_FlareArrow_AttackFilter_K2Node_ComponentBoundEvent_1_OnAttackDelegate__DelegateSignature(Defencer, DamageInfo, HitCount, AttackerComponent) end
---@param EntryPoint int32
function ABP_SkillEffectFireBall_C:ExecuteUbergraph_BP_SkillEffectFireBall(EntryPoint) end


