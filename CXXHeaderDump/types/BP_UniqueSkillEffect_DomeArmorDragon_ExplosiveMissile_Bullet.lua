---@meta

---@class ABP_UniqueSkillEffect_DomeArmorDragon_ExplosiveMissile_Bullet_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field PalProjectileMovement UPalProjectileMovementComponent
---@field Capsule UCapsuleComponent
---@field Niagara UNiagaraComponent
---@field MaxLife float
---@field HomingStrength float
---@field DetonateDistance double
local ABP_UniqueSkillEffect_DomeArmorDragon_ExplosiveMissile_Bullet_C = {}

function ABP_UniqueSkillEffect_DomeArmorDragon_ExplosiveMissile_Bullet_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function ABP_UniqueSkillEffect_DomeArmorDragon_ExplosiveMissile_Bullet_C:ReceiveTick(DeltaSeconds) end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_UniqueSkillEffect_DomeArmorDragon_ExplosiveMissile_Bullet_C:BndEvt__BP_UniqueSkillEffect_DomeArmorDragon_ExplosiveMissile_Bullet_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_UniqueSkillEffect_DomeArmorDragon_ExplosiveMissile_Bullet_C:BndEvt__BP_UniqueSkillEffect_DomeArmorDragon_ExplosiveMissile_Bullet_Capsule_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
function ABP_UniqueSkillEffect_DomeArmorDragon_ExplosiveMissile_Bullet_C:Explode() end
---@param DeltaSecond double
function ABP_UniqueSkillEffect_DomeArmorDragon_ExplosiveMissile_Bullet_C:FadeOutEffect(DeltaSecond) end
---@param EntryPoint int32
function ABP_UniqueSkillEffect_DomeArmorDragon_ExplosiveMissile_Bullet_C:ExecuteUbergraph_BP_UniqueSkillEffect_DomeArmorDragon_ExplosiveMissile_Bullet(EntryPoint) end


