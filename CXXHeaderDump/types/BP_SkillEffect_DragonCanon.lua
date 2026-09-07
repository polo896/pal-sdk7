---@meta

---@class ABP_SkillEffect_DragonCanon_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field PalProjectileMovement UPalProjectileMovementComponent
---@field ImpactTrigger USphereComponent
---@field MainEffect UNiagaraComponent
---@field MaxEffectDuration float
---@field DefaultCollisionProfile FName
---@field StopBulletDelayTime float
local ABP_SkillEffect_DragonCanon_C = {}

function ABP_SkillEffect_DragonCanon_C:ReceiveBeginPlay() end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_SkillEffect_DragonCanon_C:BndEvt__BP_SkillEffect_WaterBall_ImpactCollision_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
---@param DeltaSecond double
function ABP_SkillEffect_DragonCanon_C:FadeOutEffect(DeltaSecond) end
function ABP_SkillEffect_DragonCanon_C:Explosion() end
function ABP_SkillEffect_DragonCanon_C:EnableCollision() end
function ABP_SkillEffect_DragonCanon_C:StopBullet() end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_DragonCanon_C:BndEvt__BP_SkillEffect_DragonCanon_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param EntryPoint int32
function ABP_SkillEffect_DragonCanon_C:ExecuteUbergraph_BP_SkillEffect_DragonCanon(EntryPoint) end


