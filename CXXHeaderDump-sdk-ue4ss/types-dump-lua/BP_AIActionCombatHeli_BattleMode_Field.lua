---@meta

---@class UBP_AIActionCombatHeli_BattleMode_Field_C : UBP_AIActionCombatHeli_BattleMode_C
---@field BGMDistance double
local UBP_AIActionCombatHeli_BattleMode_Field_C = {}

---@param PlayerCharacter AActor
---@param IsTarget boolean
function UBP_AIActionCombatHeli_BattleMode_Field_C:IsWantedPoliceTargetPlayer(PlayerCharacter, IsTarget) end
---@param TargetActor AActor
---@param Valid boolean
UBP_AIActionCombatHeli_BattleMode_Field_C['Is Valid BGMTarget'] = function(self, TargetActor, Valid) end
---@param TargetActor AActor
---@param Validd boolean
UBP_AIActionCombatHeli_BattleMode_Field_C['IsValid Target'] = function(self, TargetActor, Validd) end
---@param TargetActor AActor
function UBP_AIActionCombatHeli_BattleMode_Field_C:FindTarget(TargetActor) end


