---@meta

---@class ABP_UniqueRideWeapon_RapidBase_C : APalUniqueRideWeaponBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field DefaultSceneRoot USceneComponent
---@field ShootHandle FTimerHandle
local ABP_UniqueRideWeapon_RapidBase_C = {}

---@param Time double
function ABP_UniqueRideWeapon_RapidBase_C:GetShootInterval(Time) end
function ABP_UniqueRideWeapon_RapidBase_C:ShootBulletBP() end
function ABP_UniqueRideWeapon_RapidBase_C:OnPullTrigger() end
---@param bCanShootOnRelease boolean
function ABP_UniqueRideWeapon_RapidBase_C:OnReleaseTrigger(bCanShootOnRelease) end
---@param EntryPoint int32
function ABP_UniqueRideWeapon_RapidBase_C:ExecuteUbergraph_BP_UniqueRideWeapon_RapidBase(EntryPoint) end


