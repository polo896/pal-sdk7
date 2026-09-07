---@meta

---@class ABP_SkillEffect_FireSeed_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field DamageCollision USphereComponent
---@field NS_FireSeed UNiagaraComponent
---@field DisableHomingTrigger USphereComponent
---@field ExplosionTrigger USphereComponent
---@field SpawnPos USphereComponent
---@field rotater UStaticMeshComponent
---@field ProjectileMovement UProjectileMovementComponent
---@field ExplosionTime double
---@field Explosion_volume int32
---@field Explosion_extent double
---@field ['Explosion Rot Y'] double
---@field ['Random Stream'] FRandomStream
---@field Explosioned boolean
---@field DistanceRequiredForExplosion double
---@field MaxEffectDuration float
---@field ChildFireMinScale float
---@field ChildFireMaxScale float
---@field ExplosionEffectDelay float
local ABP_SkillEffect_FireSeed_C = {}

---@param PredictedTarget AActor
ABP_SkillEffect_FireSeed_C['Get Predicted Target'] = function(self, PredictedTarget) end
---@param MyComp UPrimitiveComponent
---@param Other AActor
---@param OtherComp UPrimitiveComponent
---@param bSelfMoved boolean
---@param HitLocation FVector
---@param HitNormal FVector
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_FireSeed_C:ReceiveHit(MyComp, Other, OtherComp, bSelfMoved, HitLocation, HitNormal, NormalImpulse, Hit) end
function ABP_SkillEffect_FireSeed_C:Explosion() end
function ABP_SkillEffect_FireSeed_C:ReceiveBeginPlay() end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_SkillEffect_FireSeed_C:BndEvt__BP_SkillEffect_FireSeed_ExplosionTrigger_K2Node_ComponentBoundEvent_0_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_SkillEffect_FireSeed_C:BndEvt__BP_SkillEffect_FireSeed_DisableHomingTrigger_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
---@param DeltaSecond double
function ABP_SkillEffect_FireSeed_C:FadeOutEffect(DeltaSecond) end
function ABP_SkillEffect_FireSeed_C:OnHitGround() end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_FireSeed_C:BndEvt__BP_SkillEffect_FireSeed_MovementSphereRoot_K2Node_ComponentBoundEvent_2_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param EntryPoint int32
function ABP_SkillEffect_FireSeed_C:ExecuteUbergraph_BP_SkillEffect_FireSeed(EntryPoint) end


