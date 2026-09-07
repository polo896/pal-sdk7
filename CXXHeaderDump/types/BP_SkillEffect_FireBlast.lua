---@meta

---@class ABP_SkillEffect_FireBlast_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field NS_FireBlastOura UNiagaraComponent
---@field Sphere USphereComponent
---@field ProjectileMovement UProjectileMovementComponent
local ABP_SkillEffect_FireBlast_C = {}

function ABP_SkillEffect_FireBlast_C:ReceiveBeginPlay() end
---@param Defencer AActor
---@param DamageInfo FPalDamageInfo
---@param HitCount int32
---@param AttackerComponent UPrimitiveComponent
function ABP_SkillEffect_FireBlast_C:BndEvt__BP_SkillEffect_FireBlast_AttackFilter_K2Node_ComponentBoundEvent_0_OnAttackDelegate__DelegateSignature(Defencer, DamageInfo, HitCount, AttackerComponent) end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_FireBlast_C:BndEvt__BP_SkillEffect_FireBlast_MovementSphereRoot_K2Node_ComponentBoundEvent_1_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param DeltaSecond double
function ABP_SkillEffect_FireBlast_C:FadeOutEffect(DeltaSecond) end
---@param EntryPoint int32
function ABP_SkillEffect_FireBlast_C:ExecuteUbergraph_BP_SkillEffect_FireBlast(EntryPoint) end


