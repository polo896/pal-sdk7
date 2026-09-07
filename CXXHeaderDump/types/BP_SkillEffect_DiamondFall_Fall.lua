---@meta

---@class ABP_SkillEffect_DiamondFall_Fall_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field ProjectileMovement UProjectileMovementComponent
---@field Capsule UCapsuleComponent
---@field FallingPrepareTime float
---@field sign UNiagaraComponent
---@field MinScale double
---@field MaxScale double
---@field CurrentScale double
local ABP_SkillEffect_DiamondFall_Fall_C = {}

---@param DeltaSecond double
function ABP_SkillEffect_DiamondFall_Fall_C:FadeOutEffect(DeltaSecond) end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_DiamondFall_Fall_C:BndEvt__BP_SkillEffect_SeedMine_Seed_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param Defencer AActor
---@param DamageInfo FPalDamageInfo
---@param HitCount int32
---@param AttackerComponent UPrimitiveComponent
function ABP_SkillEffect_DiamondFall_Fall_C:BndEvt__BP_EnergyShotBullet_AttackFilter_K2Node_ComponentBoundEvent_1_OnAttackDelegate__DelegateSignature(Defencer, DamageInfo, HitCount, AttackerComponent) end
function ABP_SkillEffect_DiamondFall_Fall_C:OnBreakAction() end
function ABP_SkillEffect_DiamondFall_Fall_C:ReceiveBeginPlay() end
function ABP_SkillEffect_DiamondFall_Fall_C:EnableFall() end
---@param EntryPoint int32
function ABP_SkillEffect_DiamondFall_Fall_C:ExecuteUbergraph_BP_SkillEffect_DiamondFall_Fall(EntryPoint) end


