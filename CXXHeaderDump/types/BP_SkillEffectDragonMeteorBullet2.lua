---@meta

---@class ABP_SkillEffectDragonMeteorBullet2_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Sphere USphereComponent
---@field PalProjectileMovement UPalProjectileMovementComponent
---@field Capsule UCapsuleComponent
---@field Niagara UNiagaraComponent
---@field Life float
local ABP_SkillEffectDragonMeteorBullet2_C = {}

---@param Target AActor
---@param Success boolean
function ABP_SkillEffectDragonMeteorBullet2_C:SetHomingTarget(Target, Success) end
function ABP_SkillEffectDragonMeteorBullet2_C:ReceiveBeginPlay() end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffectDragonMeteorBullet2_C:BndEvt__BP_SkillEffectDragonMeteorBullet2_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_SkillEffectDragonMeteorBullet2_C:BndEvt__BP_SkillEffectDragonMeteorBullet2_Capsule_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
function ABP_SkillEffectDragonMeteorBullet2_C:LifeEnd() end
---@param EntryPoint int32
function ABP_SkillEffectDragonMeteorBullet2_C:ExecuteUbergraph_BP_SkillEffectDragonMeteorBullet2(EntryPoint) end


