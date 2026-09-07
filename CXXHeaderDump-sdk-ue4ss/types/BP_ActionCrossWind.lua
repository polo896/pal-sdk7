---@meta

---@class UBP_ActionCrossWind_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field FirstSpawn boolean
---@field OffsetAngle double
---@field OffsetDistance double
local UBP_ActionCrossWind_C = {}

---@param Effect APalSkillEffectBase
function UBP_ActionCrossWind_C:OnSpawnEffect(Effect) end
function UBP_ActionCrossWind_C:OnBeginAction() end
---@param EntryPoint int32
function UBP_ActionCrossWind_C:ExecuteUbergraph_BP_ActionCrossWind(EntryPoint) end


