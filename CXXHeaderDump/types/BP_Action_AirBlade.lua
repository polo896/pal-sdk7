---@meta

---@class UBP_Action_AirBlade_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BladeLife double
---@field IntervalAngle double
---@field BladeCount int32
local UBP_Action_AirBlade_C = {}

function UBP_Action_AirBlade_C:OnStartProcessAnimation() end
---@param EntryPoint int32
function UBP_Action_AirBlade_C:ExecuteUbergraph_BP_Action_AirBlade(EntryPoint) end


