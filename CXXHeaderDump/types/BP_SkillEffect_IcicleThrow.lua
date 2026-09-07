---@meta

---@class ABP_SkillEffect_IcicleThrow_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Effect_Charge UNiagaraComponent
---@field Effect_MainBullet UNiagaraComponent
---@field AttackCollision UCapsuleComponent
---@field ChildSpawnPosition USphereComponent
---@field ProjectileMovement UProjectileMovementComponent
---@field AttachEffectScale double
---@field ShotStartTime double
---@field ExplosionTime double
---@field Explosion_volume int32
---@field Explosion_Num int32
---@field Explosion_Rot_Y double
---@field BulletExtent double
---@field BulletPos FVector
---@field BulletRot FRotator
---@field IsHit boolean
---@field HitGround boolean
---@field OnRide boolean
---@field EndWait boolean
---@field AttachedEffect UNiagaraComponent
---@field ['Rate of ImpactPoint'] double
---@field RandSeedNum int32
---@field IsCharging boolean
---@field MainBulletSize double
---@field CurrentTime double
---@field MainBulletSpeed double
local ABP_SkillEffect_IcicleThrow_C = {}

function ABP_SkillEffect_IcicleThrow_C:ShootMainBullet() end
function ABP_SkillEffect_IcicleThrow_C:UpdateMainBulletScale() end
function ABP_SkillEffect_IcicleThrow_C:UpdateMainBulletRotation() end
---@param MyComp UPrimitiveComponent
---@param Other AActor
---@param OtherComp UPrimitiveComponent
---@param bSelfMoved boolean
---@param HitLocation FVector
---@param HitNormal FVector
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_IcicleThrow_C:ReceiveHit(MyComp, Other, OtherComp, bSelfMoved, HitLocation, HitNormal, NormalImpulse, Hit) end
function ABP_SkillEffect_IcicleThrow_C:ExplosionMainBullet() end
function ABP_SkillEffect_IcicleThrow_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function ABP_SkillEffect_IcicleThrow_C:ReceiveTick(DeltaSeconds) end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_IcicleThrow_C:BndEvt__BP_SkillEffect_IcicleThrow_MovementSphereRoot_K2Node_ComponentBoundEvent_1_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param DeltaSecond double
function ABP_SkillEffect_IcicleThrow_C:FadeOutEffect(DeltaSecond) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_SkillEffect_IcicleThrow_C:BndEvt__BP_SkillEffect_IcicleThrow_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
---@param EntryPoint int32
function ABP_SkillEffect_IcicleThrow_C:ExecuteUbergraph_BP_SkillEffect_IcicleThrow(EntryPoint) end


