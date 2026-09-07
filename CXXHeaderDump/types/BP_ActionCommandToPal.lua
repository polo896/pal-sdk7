---@meta

---@class UBP_ActionCommandToPal_C : UBP_ActionSimpleMonoMontage_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field TargetRotation FRotator
---@field ElapsedTime double
---@field CurrentRotation FRotator
local UBP_ActionCommandToPal_C = {}

function UBP_ActionCommandToPal_C:OnBeginAction() end
function UBP_ActionCommandToPal_C:OnEndAction() end
---@param DeltaTime float
function UBP_ActionCommandToPal_C:TickAction(DeltaTime) end
---@param EntryPoint int32
function UBP_ActionCommandToPal_C:ExecuteUbergraph_BP_ActionCommandToPal(EntryPoint) end


