---@meta

---@class ABP_SkillEffectPoseidonOrca_SpearBullet_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field SkeletalMesh USkeletalMeshComponent
---@field TrailEffect UNiagaraComponent
---@field ImpactEffect UNiagaraComponent
---@field MainEffect UNiagaraComponent
---@field Sphere USphereComponent
---@field ImpactCollison USphereComponent
---@field ProjectileMovement UProjectileMovementComponent
---@field ReadyTime double
---@field TargetActor AActor
---@field AutoDestroyTime double
local ABP_SkillEffectPoseidonOrca_SpearBullet_C = {}

---@param Enable boolean
function ABP_SkillEffectPoseidonOrca_SpearBullet_C:SetEnableCollision(Enable) end
function ABP_SkillEffectPoseidonOrca_SpearBullet_C:ReceiveBeginPlay() end
---@param MyHitComponent UPrimitiveComponent
---@param OtherHitActor AActor
---@param OtherHitComponent UPrimitiveComponent
---@param FoliageIndex TArray<int32>
---@param HitLocation FVector
---@param HitCount int32
function ABP_SkillEffectPoseidonOrca_SpearBullet_C:OnHitDelegate(MyHitComponent, OtherHitActor, OtherHitComponent, FoliageIndex, HitLocation, HitCount) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_SkillEffectPoseidonOrca_SpearBullet_C:BndEvt__BP_SkillEffectDragonMeteorBullet_ImpactCollison_K2Node_ComponentBoundEvent_0_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffectPoseidonOrca_SpearBullet_C:BndEvt__BP_SkillEffectDragonMeteorBullet_MovementSphereRoot_K2Node_ComponentBoundEvent_1_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param DeltaSecond double
function ABP_SkillEffectPoseidonOrca_SpearBullet_C:FadeOutEffect(DeltaSecond) end
function ABP_SkillEffectPoseidonOrca_SpearBullet_C:OnShootBullet() end
function ABP_SkillEffectPoseidonOrca_SpearBullet_C:OnAutoDestroy() end
---@param Defencer AActor
---@param DamageInfo FPalDamageInfo
---@param HitCount int32
---@param AttackerComponent UPrimitiveComponent
function ABP_SkillEffectPoseidonOrca_SpearBullet_C:BndEvt__BP_SkillEffect_BubbleShot_Bullet_AttackFilter_K2Node_ComponentBoundEvent_1_OnAttackDelegate__DelegateSignature(Defencer, DamageInfo, HitCount, AttackerComponent) end
function ABP_SkillEffectPoseidonOrca_SpearBullet_C:OnHitGround() end
---@param EntryPoint int32
function ABP_SkillEffectPoseidonOrca_SpearBullet_C:ExecuteUbergraph_BP_SkillEffectPoseidonOrca_SpearBullet(EntryPoint) end


