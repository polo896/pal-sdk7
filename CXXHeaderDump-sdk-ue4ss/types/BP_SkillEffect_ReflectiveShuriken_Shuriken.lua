---@meta

---@class ABP_SkillEffect_ReflectiveShuriken_Shuriken_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field FoliageDetector USphereComponent
---@field ProjectileMovement UProjectileMovementComponent
---@field Niagara UNiagaraComponent
---@field Box UBoxComponent
---@field Life double
---@field Speed double
---@field SearchDistance double
---@field LastTarget AActor
---@field MaxReflectCount int32
---@field CurrentReflectCount int32
---@field EnableTreeReflect boolean
---@field DetectedInstanceIDs TArray<int32>
---@field DetectedFoliageISMC UPalFoliageISMComponentBase
---@field LastBodyIndex int32
---@field PowerDecrease double
local ABP_SkillEffect_ReflectiveShuriken_Shuriken_C = {}

---@param FoliageISM UPalFoliageISMComponentBase
---@param Location FVector
---@param Finded boolean
ABP_SkillEffect_ReflectiveShuriken_Shuriken_C['Get Nearest Foliage Location'] = function(self, FoliageISM, Location, Finded) end
function ABP_SkillEffect_ReflectiveShuriken_Shuriken_C:FindReflectTarget() end
function ABP_SkillEffect_ReflectiveShuriken_Shuriken_C:UserConstructionScript() end
function ABP_SkillEffect_ReflectiveShuriken_Shuriken_C:CancelShoot() end
function ABP_SkillEffect_ReflectiveShuriken_Shuriken_C:ReceiveBeginPlay() end
function ABP_SkillEffect_ReflectiveShuriken_Shuriken_C:StartFade() end
---@param Defencer AActor
---@param DamageInfo FPalDamageInfo
---@param HitCount int32
---@param AttackerComponent UPrimitiveComponent
function ABP_SkillEffect_ReflectiveShuriken_Shuriken_C:OnAttack(Defencer, DamageInfo, HitCount, AttackerComponent) end
---@param DeltaSecond double
function ABP_SkillEffect_ReflectiveShuriken_Shuriken_C:FadeOutEffect(DeltaSecond) end
---@param TargetLocation FVector
function ABP_SkillEffect_ReflectiveShuriken_Shuriken_C:ShootBullet(TargetLocation) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_SkillEffect_ReflectiveShuriken_Shuriken_C:BndEvt__BP_SkillEffect_ReflectiveShuriken_Shuriken_Box_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
---@param TargetLocation FVector
function ABP_SkillEffect_ReflectiveShuriken_Shuriken_C:DelayReflect(TargetLocation) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_SkillEffect_ReflectiveShuriken_Shuriken_C:BndEvt__BP_SkillEffect_ReflectiveShuriken_Shuriken_FoliageDetector_K2Node_ComponentBoundEvent_3_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
function ABP_SkillEffect_ReflectiveShuriken_Shuriken_C:BndEvt__BP_SkillEffect_ReflectiveShuriken_Shuriken_FoliageDetector_K2Node_ComponentBoundEvent_4_ComponentEndOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex) end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_ReflectiveShuriken_Shuriken_C:BndEvt__BP_SkillEffect_ReflectiveShuriken_Shuriken_MovementSphereRoot_K2Node_ComponentBoundEvent_8_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param EntryPoint int32
function ABP_SkillEffect_ReflectiveShuriken_Shuriken_C:ExecuteUbergraph_BP_SkillEffect_ReflectiveShuriken_Shuriken(EntryPoint) end


