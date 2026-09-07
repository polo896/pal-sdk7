---@meta

---@class ABP_Arrow_C : ABP_AttackBulletBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field SK_Weapon_Arrow_001 USkeletalMeshComponent
---@field IsHitAble boolean
---@field DamageRate double
---@field BigTrail boolean
---@field Stung boolean
---@field PalSoundSlotClass TSubclassOf<UPalSoundSlot>
---@field Effect_Trail_S UNiagaraSystem
---@field Effect_Trail_L UNiagaraSystem
---@field TrailActor ABP_CommonTrailActor_C
---@field TrailFadeOutTime double
---@field TrailFadeOutCurve UCurveFloat
local ABP_Arrow_C = {}

---@param HitComp UPrimitiveComponent
---@param Hit_Result FHitResult
function ABP_Arrow_C:SpawnExplosion(HitComp, Hit_Result) end
---@param HitComp UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param Hit FHitResult
function ABP_Arrow_C:OnHitToActor(HitComp, OtherActor, OtherComp, Hit) end
---@param Point FVector
function ABP_Arrow_C:ShowHitEffect(Point) end
---@param Rate double
---@param BigTrail boolean
function ABP_Arrow_C:SetBulletSpeedRate(Rate, BigTrail) end
---@param OtherActor AActor
---@param HitPoint FVector
function ABP_Arrow_C:CreateStungArrow(OtherActor, HitPoint) end
---@param HitComp UPrimitiveComponent
---@param OtherCharacter AActor
---@param OtherComp UPrimitiveComponent
---@param Hit FHitResult
function ABP_Arrow_C:OnDestroy(HitComp, OtherCharacter, OtherComp, Hit) end
function ABP_Arrow_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function ABP_Arrow_C:ReceiveTick(DeltaSeconds) end
---@param EndPlayReason EEndPlayReason::Type
function ABP_Arrow_C:ReceiveEndPlay(EndPlayReason) end
---@param EntryPoint int32
function ABP_Arrow_C:ExecuteUbergraph_BP_Arrow(EntryPoint) end


