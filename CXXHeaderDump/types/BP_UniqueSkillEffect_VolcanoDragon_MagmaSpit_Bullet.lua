---@meta

---@class ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Sphere USphereComponent
---@field Niagara UNiagaraComponent
---@field PalProjectileMovement UPalProjectileMovementComponent
---@field LaunchAngle double
---@field MaxLife double
---@field OnMagmaSpawned FBP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_COnMagmaSpawned
local ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_C = {}

---@param SpitClass TSubclassOf<ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Magma_C>
function ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_C:GetSpitClass(SpitClass) end
---@param Direct FVector
---@param Velocity FVector
function ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_C:CalcInitialVelocity(Direct, Velocity) end
function ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_C:ReceiveBeginPlay() end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_C:BndEvt__BP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param DeltaSecond double
function ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_C:FadeOutEffect(DeltaSecond) end
---@param Location FVector
function ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_C:SetTargetLocation(Location) end
function ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_C:LifeEnd() end
function ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_C:DoFadeEffect() end
---@param EntryPoint int32
function ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_C:ExecuteUbergraph_BP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet(EntryPoint) end
---@param MagmaActor ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Magma_C
function ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_C:OnMagmaSpawned__DelegateSignature(MagmaActor) end


