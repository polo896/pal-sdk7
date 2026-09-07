---@meta

---@class ABP_UniqueRideWeapon_MultiMissile_C : ABP_UniqueRideWeapon_RapidBase_C
---@field SM_Missile7 UStaticMeshComponent
---@field SM_Missile13 UStaticMeshComponent
---@field SM_Missile12 UStaticMeshComponent
---@field SM_Missile11 UStaticMeshComponent
---@field SM_Missile10 UStaticMeshComponent
---@field SM_Missile9 UStaticMeshComponent
---@field SM_Missile8 UStaticMeshComponent
---@field SM_Missile6 UStaticMeshComponent
---@field SM_Missile5 UStaticMeshComponent
---@field SM_Missile4 UStaticMeshComponent
---@field SM_Missile3 UStaticMeshComponent
---@field SM_Missile2 UStaticMeshComponent
---@field SM_Missile1 UStaticMeshComponent
---@field SM_Missile UStaticMeshComponent
---@field SM_MultiMissle_Launcher_R UStaticMeshComponent
---@field SM_MultiMissle_Launcher_L UStaticMeshComponent
---@field MuzzleList TArray<FFMissileMuzzleList>
---@field MuzzleIndex int32
---@field ShotIntervalTimerHandle FTimerHandle
---@field MissileBlur double
local ABP_UniqueRideWeapon_MultiMissile_C = {}

---@param OutMesh TArray<UMeshComponent>
function ABP_UniqueRideWeapon_MultiMissile_C:GetAllMeshComponent(OutMesh) end
function ABP_UniqueRideWeapon_MultiMissile_C:ShootBulletBP() end
---@param Time double
function ABP_UniqueRideWeapon_MultiMissile_C:GetShootInterval(Time) end
function ABP_UniqueRideWeapon_MultiMissile_C:ShootMiso() end


