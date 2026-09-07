---@meta

---@class ABP_HomingMissile_AntiAirLauncher_C : ABP_HomingMissile_MissileLauncher_NPC_C
local ABP_HomingMissile_AntiAirLauncher_C = {}

---@param ExplosionClass TSubclassOf<ABP_ExplosionAttackBase_C>
function ABP_HomingMissile_AntiAirLauncher_C:GetExplosionClass(ExplosionClass) end
---@param PalCharacter APalCharacter
ABP_HomingMissile_AntiAirLauncher_C['Find Target Actor'] = function(self, PalCharacter) end


