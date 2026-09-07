---@meta

---@class ABP_BeamLauncher_C : ABP_OverheatRifle_C
local ABP_BeamLauncher_C = {}

function ABP_BeamLauncher_C:StopFireSound() end
function ABP_BeamLauncher_C:PlayFireSound() end
function ABP_BeamLauncher_C:PlayEndFireSound() end
---@param BulletActor APalBullet
function ABP_BeamLauncher_C:OnShoot(BulletActor) end
---@param Time double
function ABP_BeamLauncher_C:GetShootInterval(Time) end


