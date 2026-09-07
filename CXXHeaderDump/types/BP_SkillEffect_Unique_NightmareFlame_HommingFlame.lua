---@meta

---@class ABP_SkillEffect_Unique_NightmareFlame_HommingFlame_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field PalProjectileMovement UPalProjectileMovementComponent
---@field DamageCollision USphereComponent
---@field Niagara UNiagaraComponent
---@field InitialSpeed double
---@field EffectDuration float
local ABP_SkillEffect_Unique_NightmareFlame_HommingFlame_C = {}

---@return FVector
function ABP_SkillEffect_Unique_NightmareFlame_HommingFlame_C:GetCurrentTargetLocation() end
function ABP_SkillEffect_Unique_NightmareFlame_HommingFlame_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function ABP_SkillEffect_Unique_NightmareFlame_HommingFlame_C:ReceiveTick(DeltaSeconds) end
---@param DeltaSecond double
function ABP_SkillEffect_Unique_NightmareFlame_HommingFlame_C:FadeOutEffect(DeltaSecond) end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_Unique_NightmareFlame_HommingFlame_C:BndEvt__BP_SkillEffect_FlareArrow_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param Defencer AActor
---@param DamageInfo FPalDamageInfo
---@param HitCount int32
---@param AttackerComponent UPrimitiveComponent
function ABP_SkillEffect_Unique_NightmareFlame_HommingFlame_C:BndEvt__BP_SkillEffect_FlareArrow_AttackFilter_K2Node_ComponentBoundEvent_1_OnAttackDelegate__DelegateSignature(Defencer, DamageInfo, HitCount, AttackerComponent) end
function ABP_SkillEffect_Unique_NightmareFlame_HommingFlame_C:StartFade() end
---@param EntryPoint int32
function ABP_SkillEffect_Unique_NightmareFlame_HommingFlame_C:ExecuteUbergraph_BP_SkillEffect_Unique_NightmareFlame_HommingFlame(EntryPoint) end


