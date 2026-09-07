---@meta

---@class ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Bullet_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field PalProjectileMovement UPalProjectileMovementComponent
---@field Capsule UCapsuleComponent
---@field Niagara UNiagaraComponent
---@field Life double
---@field ['Max Speed'] float
local ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Bullet_C = {}

---@param Target AActor
---@param Success boolean
function ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Bullet_C:SetHomingTarget(Target, Success) end
function ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Bullet_C:ReceiveBeginPlay() end
function ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Bullet_C:EndLife() end
---@param Defencer AActor
---@param DamageInfo FPalDamageInfo
---@param HitCount int32
---@param AttackerComponent UPrimitiveComponent
function ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Bullet_C:BndEvt__BP_UniqueSkillEffect_ClownRabbit_TrickShow_Bullet_AttackFilter_K2Node_ComponentBoundEvent_0_OnAttackDelegate__DelegateSignature(Defencer, DamageInfo, HitCount, AttackerComponent) end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Bullet_C:BndEvt__BP_UniqueSkillEffect_ClownRabbit_TrickShow_Bullet_MovementSphereRoot_K2Node_ComponentBoundEvent_1_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param DeltaSecond double
function ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Bullet_C:FadeOutEffect(DeltaSecond) end
---@param EntryPoint int32
function ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Bullet_C:ExecuteUbergraph_BP_UniqueSkillEffect_ClownRabbit_TrickShow_Bullet(EntryPoint) end


