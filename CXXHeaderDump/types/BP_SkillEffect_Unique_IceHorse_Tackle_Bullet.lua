---@meta

---@class ABP_SkillEffect_Unique_IceHorse_Tackle_Bullet_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field PalProjectileMovement UPalProjectileMovementComponent
---@field Capsule UCapsuleComponent
---@field Niagara UNiagaraComponent
---@field HomingStrength double
---@field Life double
local ABP_SkillEffect_Unique_IceHorse_Tackle_Bullet_C = {}

function ABP_SkillEffect_Unique_IceHorse_Tackle_Bullet_C:ReceiveBeginPlay() end
---@param InitialDirect FVector
---@param TargetActor AActor
function ABP_SkillEffect_Unique_IceHorse_Tackle_Bullet_C:Launch(InitialDirect, TargetActor) end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_Unique_IceHorse_Tackle_Bullet_C:BndEvt__BP_SkillEffect_Unique_IceHorse_Tackle_Bullet_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param Defencer AActor
---@param DamageInfo FPalDamageInfo
---@param HitCount int32
---@param AttackerComponent UPrimitiveComponent
function ABP_SkillEffect_Unique_IceHorse_Tackle_Bullet_C:OnAttack(Defencer, DamageInfo, HitCount, AttackerComponent) end
function ABP_SkillEffect_Unique_IceHorse_Tackle_Bullet_C:OnLifeEnd() end
---@param DeltaSecond double
function ABP_SkillEffect_Unique_IceHorse_Tackle_Bullet_C:FadeOutEffect(DeltaSecond) end
---@param EntryPoint int32
function ABP_SkillEffect_Unique_IceHorse_Tackle_Bullet_C:ExecuteUbergraph_BP_SkillEffect_Unique_IceHorse_Tackle_Bullet(EntryPoint) end


