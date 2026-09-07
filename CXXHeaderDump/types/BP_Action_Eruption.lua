---@meta

---@class UBP_Action_Eruption_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
local UBP_Action_Eruption_C = {}

---@param AttachOnly boolean
UBP_Action_Eruption_C['Adjust Effect Rot Pitch to Target'] = function(self, AttachOnly) end
---@param Location FVector
function UBP_Action_Eruption_C:GetPredictedTargetLocation(Location) end
function UBP_Action_Eruption_C:OnBeginAction() end
---@param DeltaTime float
function UBP_Action_Eruption_C:TickAction(DeltaTime) end
---@param EntryPoint int32
function UBP_Action_Eruption_C:ExecuteUbergraph_BP_Action_Eruption(EntryPoint) end


