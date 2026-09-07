---@meta

---@class UBP_AIAction_Teleport_C : UPalAIActionBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field TeleProbability double
---@field TeleportTargetDistance double
local UBP_AIAction_Teleport_C = {}

function UBP_AIAction_Teleport_C:TeleportFailedAction() end
---@param action UPalActionBase
function UBP_AIAction_Teleport_C:ActionBindProcess(action) end
function UBP_AIAction_Teleport_C:AfterTeleportAction() end
---@param Success boolean
function UBP_AIAction_Teleport_C:IsTeleportCondition(Success) end
---@param CurrentLocation FVector
---@param TargetLocation FVector
function UBP_AIAction_Teleport_C:ActTeleport(CurrentLocation, TargetLocation) end
---@param Success boolean
---@param Value TSubclassOf<UPalActionBase>
function UBP_AIAction_Teleport_C:GetActionClass(Success, Value) end
---@param ControlledPawn APawn
function UBP_AIAction_Teleport_C:ActionStart(ControlledPawn) end
---@param action UPawnAction
---@param WithResult EPawnActionResult::Type
function UBP_AIAction_Teleport_C:OnChildActionFinished(action, WithResult) end
function UBP_AIAction_Teleport_C:OnActionEnd() end
---@param EntryPoint int32
function UBP_AIAction_Teleport_C:ExecuteUbergraph_BP_AIAction_Teleport(EntryPoint) end


