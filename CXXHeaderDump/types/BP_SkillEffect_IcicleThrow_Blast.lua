---@meta

---@class ABP_SkillEffect_IcicleThrow_Blast_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Effect_Fragment UNiagaraComponent
---@field AttackTrigger_Height UBoxComponent
---@field AttackTrigger_Inner USphereComponent
---@field AttackTrigger_Outer USphereComponent
---@field Group_Collision USceneComponent
---@field Effect_Blast UNiagaraComponent
---@field ExpandSpeed double
---@field AttachedAttackCollisions TArray<USphereComponent>
---@field ActorsInTrigger_Inner TArray<AActor>
---@field ActorsInTrigger_Outer TArray<AActor>
---@field ActorsInTrigger_Height TMap<AActor, UPrimitiveComponent>
---@field DrawDebugBlast boolean
---@field StartExpandInnerTrigger boolean
---@field ExpandSpeedRateCurve UCurveFloat
---@field Timer double
---@field CollisionLifetime float
---@field AttackedActors TArray<AActor>
local ABP_SkillEffect_IcicleThrow_Blast_C = {}

---@param DamageInfo FPalDamageInfo
function ABP_SkillEffect_IcicleThrow_Blast_C:DamageInfoCustomOverride(DamageInfo) end
---@param DeltaTime double
function ABP_SkillEffect_IcicleThrow_Blast_C:UpdateTimer(DeltaTime) end
function ABP_SkillEffect_IcicleThrow_Blast_C:CheckAttackTriggers() end
function ABP_SkillEffect_IcicleThrow_Blast_C:DrawDebug() end
---@param DeltaTime double
function ABP_SkillEffect_IcicleThrow_Blast_C:ExpandAttackTrigger(DeltaTime) end
---@param Target AActor
function ABP_SkillEffect_IcicleThrow_Blast_C:DisableAttachedAttackCollision(Target) end
function ABP_SkillEffect_IcicleThrow_Blast_C:DestroyAllAttachedAttackCollisions() end
---@param Target AActor
function ABP_SkillEffect_IcicleThrow_Blast_C:AttachOrEnableAttackCollisionToTarget(Target) end
function ABP_SkillEffect_IcicleThrow_Blast_C:EndBlast() end
function ABP_SkillEffect_IcicleThrow_Blast_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function ABP_SkillEffect_IcicleThrow_Blast_C:ReceiveTick(DeltaSeconds) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_SkillEffect_IcicleThrow_Blast_C:BndEvt__BP_SkillEffect_IcicleThrow_Blast_AttackTrigger_Inner_K2Node_ComponentBoundEvent_0_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_SkillEffect_IcicleThrow_Blast_C:BndEvt__BP_SkillEffect_IcicleThrow_Blast_AttackTrigger_Outer_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
function ABP_SkillEffect_IcicleThrow_Blast_C:BndEvt__BP_SkillEffect_IcicleThrow_Blast_AttackTrigger_Outer_K2Node_ComponentBoundEvent_2_ComponentEndOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
function ABP_SkillEffect_IcicleThrow_Blast_C:BndEvt__BP_SkillEffect_IcicleThrow_Blast_AttackTrigger_Inner_K2Node_ComponentBoundEvent_3_ComponentEndOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_SkillEffect_IcicleThrow_Blast_C:BndEvt__BP_SkillEffect_IcicleThrow_Blast_AttackTrigger_Height_K2Node_ComponentBoundEvent_4_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
function ABP_SkillEffect_IcicleThrow_Blast_C:BndEvt__BP_SkillEffect_IcicleThrow_Blast_AttackTrigger_Height_K2Node_ComponentBoundEvent_5_ComponentEndOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex) end
ABP_SkillEffect_IcicleThrow_Blast_C['カスタムイベント_0'] = function(self, ) end
---@param DeltaSecond double
function ABP_SkillEffect_IcicleThrow_Blast_C:FadeOutEffect(DeltaSecond) end
---@param EntryPoint int32
function ABP_SkillEffect_IcicleThrow_Blast_C:ExecuteUbergraph_BP_SkillEffect_IcicleThrow_Blast(EntryPoint) end


