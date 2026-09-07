---@meta

---@class UBP_Action_ChargeCanon_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ImpactRadius double
---@field bShowPredictLocation boolean
local UBP_Action_ChargeCanon_C = {}

---@param Location FVector
function UBP_Action_ChargeCanon_C:GetPredictedTargetLocation(Location) end
---@param Effect APalSkillEffectBase
function UBP_Action_ChargeCanon_C:OnSpawnEffect(Effect) end
function UBP_Action_ChargeCanon_C:OnBeginAction() end
---@param DeltaTime float
function UBP_Action_ChargeCanon_C:TickAction(DeltaTime) end
---@param EntryPoint int32
function UBP_Action_ChargeCanon_C:ExecuteUbergraph_BP_Action_ChargeCanon(EntryPoint) end


