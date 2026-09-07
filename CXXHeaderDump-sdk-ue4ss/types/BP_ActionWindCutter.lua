---@meta

---@class UBP_ActionWindCutter_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WhenRiddenGeneralParams FSkillEffectSpawnParameter
local UBP_ActionWindCutter_C = {}

---@param Bullet AActor
function UBP_ActionWindCutter_C:TEST(Bullet) end
---@param Effect APalSkillEffectBase
function UBP_ActionWindCutter_C:OnSpawnEffect(Effect) end
---@param Bullet AActor
function UBP_ActionWindCutter_C:OnSpawnBullet(Bullet) end
---@param EntryPoint int32
function UBP_ActionWindCutter_C:ExecuteUbergraph_BP_ActionWindCutter(EntryPoint) end


