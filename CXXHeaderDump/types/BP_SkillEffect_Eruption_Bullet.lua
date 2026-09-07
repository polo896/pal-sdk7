---@meta

---@class ABP_SkillEffect_Eruption_Bullet_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ImpactTrigger USphereComponent
---@field ProjectileMovement UProjectileMovementComponent
---@field BulletEffect UNiagaraComponent
---@field MaxEffectDuration float
---@field TargetLocation FVector
---@field ShowSignDelayTime double
---@field FallTotalTime double
---@field StartTime FDateTime
---@field SignEffect UNiagaraComponent
local ABP_SkillEffect_Eruption_Bullet_C = {}

function ABP_SkillEffect_Eruption_Bullet_C:ReceiveBeginPlay() end
---@param DeltaSecond double
function ABP_SkillEffect_Eruption_Bullet_C:FadeOutEffect(DeltaSecond) end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_Eruption_Bullet_C:BndEvt__BP_SkillEffect_Eruption_Bullet_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_SkillEffect_Eruption_Bullet_C:BndEvt__BP_SkillEffect_Eruption_Bullet_ImpactTrigger_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
function ABP_SkillEffect_Eruption_Bullet_C:Explosion() end
---@param TargetLocation FVector
function ABP_SkillEffect_Eruption_Bullet_C:SetTargetLocation(TargetLocation) end
---@param DeltaSeconds float
function ABP_SkillEffect_Eruption_Bullet_C:ReceiveTick(DeltaSeconds) end
function ABP_SkillEffect_Eruption_Bullet_C:SpawnSign() end
---@param EntryPoint int32
function ABP_SkillEffect_Eruption_Bullet_C:ExecuteUbergraph_BP_SkillEffect_Eruption_Bullet(EntryPoint) end


