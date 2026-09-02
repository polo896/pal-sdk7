---@meta

---@class ABP_SkillEffect_Tremor_Rock_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Capsule UCapsuleComponent
---@field ProjectileMovement UProjectileMovementComponent
---@field Niagara UNiagaraComponent
---@field EffectDuration double
---@field BaseSpeed double
---@field RandSpeedRange float
---@field MinRockScale double
---@field MaxRockScale double
---@field CurrentScale double
local ABP_SkillEffect_Tremor_Rock_C = {}

function ABP_SkillEffect_Tremor_Rock_C:ReceiveBeginPlay() end
function ABP_SkillEffect_Tremor_Rock_C:OnBreakAction() end
---@param DeltaSecond double
function ABP_SkillEffect_Tremor_Rock_C:FadeOutEffect(DeltaSecond) end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_Tremor_Rock_C:BndEvt__BP_SkillEffectDragonMeteorBullet2_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_SkillEffect_Tremor_Rock_C:BndEvt__BP_SkillEffectDragonMeteorBullet2_Capsule_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
---@param EntryPoint int32
function ABP_SkillEffect_Tremor_Rock_C:ExecuteUbergraph_BP_SkillEffect_Tremor_Rock(EntryPoint) end


