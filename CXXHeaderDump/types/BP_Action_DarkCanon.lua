---@meta

---@class UBP_Action_DarkCanon_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
local UBP_Action_DarkCanon_C = {}

---@param Effect APalSkillEffectBase
function UBP_Action_DarkCanon_C:OnSpawnEffect(Effect) end
function UBP_Action_DarkCanon_C:OnBeginAction() end
---@param DeltaTime float
function UBP_Action_DarkCanon_C:TickAction(DeltaTime) end
---@param EntryPoint int32
function UBP_Action_DarkCanon_C:ExecuteUbergraph_BP_Action_DarkCanon(EntryPoint) end


