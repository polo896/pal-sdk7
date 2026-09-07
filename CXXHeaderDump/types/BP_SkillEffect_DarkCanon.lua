---@meta

---@class ABP_SkillEffect_DarkCanon_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ImpactTrigger UCapsuleComponent
---@field MainEffect UNiagaraComponent
---@field ProjectileMovement UProjectileMovementComponent
---@field MaxEffectDuration float
---@field DefaultCollisionProfile FName
---@field StopBulletDelayTime float
local ABP_SkillEffect_DarkCanon_C = {}

function ABP_SkillEffect_DarkCanon_C:ReceiveBeginPlay() end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_SkillEffect_DarkCanon_C:BndEvt__BP_SkillEffect_WaterBall_ImpactCollision_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
---@param DeltaSecond double
function ABP_SkillEffect_DarkCanon_C:FadeOutEffect(DeltaSecond) end
function ABP_SkillEffect_DarkCanon_C:Explosion() end
function ABP_SkillEffect_DarkCanon_C:EnableCollision() end
function ABP_SkillEffect_DarkCanon_C:StopBullet() end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_DarkCanon_C:BndEvt__BP_SkillEffect_DragonCanon_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param EntryPoint int32
function ABP_SkillEffect_DarkCanon_C:ExecuteUbergraph_BP_SkillEffect_DarkCanon(EntryPoint) end


