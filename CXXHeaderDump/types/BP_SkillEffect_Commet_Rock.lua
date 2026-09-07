---@meta

---@class ABP_SkillEffect_Commet_Rock_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ProjectileMovement UProjectileMovementComponent
---@field Niagara UNiagaraComponent
---@field Sphere USphereComponent
---@field GravityScale float
---@field HoldTime double
local ABP_SkillEffect_Commet_Rock_C = {}

---@param Start FVector
---@param End FVector
---@param Location FVector
function ABP_SkillEffect_Commet_Rock_C:GetGroundOrWaterPlaneTrace(Start, End, Location) end
function ABP_SkillEffect_Commet_Rock_C:ReceiveBeginPlay() end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_Commet_Rock_C:BndEvt__BP_SkillEffect_SeedMine_Seed_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
function ABP_SkillEffect_Commet_Rock_C:OnBreakAction() end
function ABP_SkillEffect_Commet_Rock_C:StartFall() end
---@param DeltaSecond double
function ABP_SkillEffect_Commet_Rock_C:FadeOutEffect(DeltaSecond) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_SkillEffect_Commet_Rock_C:BndEvt__BP_SkillEffect_IcicleThrow_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
---@param EntryPoint int32
function ABP_SkillEffect_Commet_Rock_C:ExecuteUbergraph_BP_SkillEffect_Commet_Rock(EntryPoint) end


