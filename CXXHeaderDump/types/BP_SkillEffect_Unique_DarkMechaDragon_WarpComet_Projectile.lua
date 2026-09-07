---@meta

---@class ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field PalProjectileMovement UPalProjectileMovementComponent
---@field Capsule UCapsuleComponent
---@field Niagara UNiagaraComponent
---@field TimeUntilFade double
---@field HomingTimeRange FVector2D
---@field TargetLocationNoiseRadius double
---@field TargetLocationNoise FVector
---@field EnableUserHorming boolean
---@field ForceTargetRate double
---@field NiagaraOnHit UNiagaraSystem
---@field EnableUseHitEffect boolean
---@field ScaleCache double
---@field CurrentSpeed double
---@field ForceLocation FVector
local ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_C = {}

---@param Location FVector
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_C:SetTargetLocation(Location) end
---@param Direction FRotator
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_C:SetDirection(Direction) end
---@param Target AActor
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_C:SetTarget(Target) end
---@param DeltaSecond double
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_C:FadeOutEffect(DeltaSecond) end
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_C:ReceiveBeginPlay() end
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_C:OnTime() end
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_C:StartHoming() end
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_C:EndHoming() end
---@param DeltaSeconds float
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_C:ReceiveTick(DeltaSeconds) end
---@param Scale double
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_C:SetScale(Scale) end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_C:BndEvt__BP_SkillEffect_FlareArrow_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param Defencer AActor
---@param DamageInfo FPalDamageInfo
---@param HitCount int32
---@param AttackerComponent UPrimitiveComponent
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_C:BndEvt__BP_SkillEffect_FlareArrow_AttackFilter_K2Node_ComponentBoundEvent_1_OnAttackDelegate__DelegateSignature(Defencer, DamageInfo, HitCount, AttackerComponent) end
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_C:EndProjectile() end
---@param EntryPoint int32
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_C:ExecuteUbergraph_BP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile(EntryPoint) end


