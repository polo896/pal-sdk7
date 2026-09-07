---@meta

---@class ABP_UniqueRideWeapon_Minigun_C : ABP_UniqueRideWeapon_RapidBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field SkeletalMesh_0 USkeletalMeshComponent
---@field IsRotateBarrel boolean
local ABP_UniqueRideWeapon_Minigun_C = {}

function ABP_UniqueRideWeapon_Minigun_C:StopFireLoopSound() end
function ABP_UniqueRideWeapon_Minigun_C:PlayFireLoopSound() end
---@param OutMesh TArray<UMeshComponent>
function ABP_UniqueRideWeapon_Minigun_C:GetAllMeshComponent(OutMesh) end
---@return FTransform
function ABP_UniqueRideWeapon_Minigun_C:GetAmmoEjectTransform() end
---@return TSubclassOf<AActor>
function ABP_UniqueRideWeapon_Minigun_C:GetAmmoClass() end
function ABP_UniqueRideWeapon_Minigun_C:ShootBulletBP() end
---@return float
function ABP_UniqueRideWeapon_Minigun_C:GetBulrAngle() end
---@return TSubclassOf<APalBullet>
function ABP_UniqueRideWeapon_Minigun_C:GetBulletClass() end
---@return UNiagaraSystem
function ABP_UniqueRideWeapon_Minigun_C:GetMuzzleEffect() end
---@return FRotator
function ABP_UniqueRideWeapon_Minigun_C:GetMuzzleRotation() end
---@return FVector
function ABP_UniqueRideWeapon_Minigun_C:GetMuzzleLocation() end
---@param Time double
function ABP_UniqueRideWeapon_Minigun_C:GetShootInterval(Time) end
---@param bCanShootOnRelease boolean
function ABP_UniqueRideWeapon_Minigun_C:OnReleaseTrigger(bCanShootOnRelease) end
function ABP_UniqueRideWeapon_Minigun_C:OnPullTrigger() end
---@param DeltaSeconds float
function ABP_UniqueRideWeapon_Minigun_C:ReceiveTick(DeltaSeconds) end
function ABP_UniqueRideWeapon_Minigun_C:OnPlayFireLoopSound() end
---@param EntryPoint int32
function ABP_UniqueRideWeapon_Minigun_C:ExecuteUbergraph_BP_UniqueRideWeapon_Minigun(EntryPoint) end


