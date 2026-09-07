---@meta

---@class ABP_ShotgunBase_C : APalWeaponBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Weapon USkeletalMeshComponent
---@field DefaultSceneRoot USceneComponent
---@field ShotInterval double
---@field ScatteredAngle double
---@field CanShootFlag boolean
---@field DirectionForReticle boolean
---@field IsIntervalTimeEnded boolean
---@field MuzzleEffect UNiagaraSystem
---@field ['Max Bullets'] int32
local ABP_ShotgunBase_C = {}

function ABP_ShotgunBase_C:PlayEquipAnim() end
function ABP_ShotgunBase_C:PlayShootAnim() end
---@return float
function ABP_ShotgunBase_C:GetDefaultBlurAngle() end
function ABP_ShotgunBase_C:PlayFireSound() end
---@return float
function ABP_ShotgunBase_C:CalcRange() end
---@return float
function ABP_ShotgunBase_C:CalcAccuracy() end
---@return float
function ABP_ShotgunBase_C:CalcDPS() end
---@param IsShoted boolean
function ABP_ShotgunBase_C:OnshotInternal(IsShoted) end
---@param EjectionTransform FTransform
function ABP_ShotgunBase_C:GetEjectionPort(EjectionTransform) end
---@return FTransform
function ABP_ShotgunBase_C:GetLeftHandTransform() end
---@param TargetLocation FVector
function ABP_ShotgunBase_C:GetTargetPosition(TargetLocation) end
---@param BaseAngle double
---@param BlurAngle double
---@param MaxBullets int32
---@param ShootTransformList TArray<FTransform>
function ABP_ShotgunBase_C:GetShootTransformList(BaseAngle, BlurAngle, MaxBullets, ShootTransformList) end
---@return boolean
function ABP_ShotgunBase_C:IsUseLeftHandAttach() end
---@return FName
function ABP_ShotgunBase_C:GetEquipSocketName() end
---@param Transform FTransform
function ABP_ShotgunBase_C:GetMuzzleTransform(Transform) end
function ABP_ShotgunBase_C:OnShot() end
---@param can boolean
function ABP_ShotgunBase_C:CanShoot(can) end
function ABP_ShotgunBase_C:OnPullTrigger() end
---@param bCanShootOnRelease boolean
function ABP_ShotgunBase_C:OnReleaseTrigger(bCanShootOnRelease) end
function ABP_ShotgunBase_C:CountShotInterval() end
function ABP_ShotgunBase_C:ShootIntervalEvent() end
---@param attachActor AActor
function ABP_ShotgunBase_C:OnAttachWeapon(attachActor) end
---@param action UPalActionBase
function ABP_ShotgunBase_C:StopReloadWhenRoll(action) end
---@param detachActor AActor
function ABP_ShotgunBase_C:OnDetachWeapon(detachActor) end
---@param EntryPoint int32
function ABP_ShotgunBase_C:ExecuteUbergraph_BP_ShotgunBase(EntryPoint) end


