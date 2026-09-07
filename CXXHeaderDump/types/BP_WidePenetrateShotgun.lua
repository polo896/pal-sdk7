---@meta

---@class ABP_WidePenetrateShotgun_C : ABP_ShotgunBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ShootingHandle FTimerHandle
local ABP_WidePenetrateShotgun_C = {}

function ABP_WidePenetrateShotgun_C:PlayShootAnim() end
function ABP_WidePenetrateShotgun_C:OnShot() end
function ABP_WidePenetrateShotgun_C:OnPullTrigger() end
---@param bCanShootOnRelease boolean
function ABP_WidePenetrateShotgun_C:OnReleaseTrigger(bCanShootOnRelease) end
---@param InReloadSpeedPlayRate float
function ABP_WidePenetrateShotgun_C:OnReloadStart(InReloadSpeedPlayRate) end
---@param detachActor AActor
function ABP_WidePenetrateShotgun_C:OnDetachWeapon(detachActor) end
---@param EndPlayReason EEndPlayReason::Type
function ABP_WidePenetrateShotgun_C:ReceiveEndPlay(EndPlayReason) end
---@param EntryPoint int32
function ABP_WidePenetrateShotgun_C:ExecuteUbergraph_BP_WidePenetrateShotgun(EntryPoint) end


