---@meta

---@class UBP_AIAction_Leave_AnimationBackStep_C : UPalAIAction_LeaveBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field EndAble boolean
---@field TurnAble boolean
---@field GoalLocationList TArray<FVector>
---@field JumpFailure boolean
---@field CurrentDistance double
local UBP_AIAction_Leave_AnimationBackStep_C = {}

---@param GoalPos FVector
---@param Success boolean
---@param HitLocation FVector
function UBP_AIAction_Leave_AnimationBackStep_C:CheckReachable(GoalPos, Success, HitLocation) end
---@param Right double
---@param DistanceRate double
---@param BackVector FVector
---@param RightVector FVector
function UBP_AIAction_Leave_AnimationBackStep_C:AddGoalArray(Right, DistanceRate, BackVector, RightVector) end
---@param GoalPos FVector
---@param Success boolean
function UBP_AIAction_Leave_AnimationBackStep_C:FindGoalLocation(GoalPos, Success) end
---@param NotifyName FName
function UBP_AIAction_Leave_AnimationBackStep_C:OnNotifyEnd_5A1B92A34AEA8F9E449C2AAE2F12A51B(NotifyName) end
---@param NotifyName FName
function UBP_AIAction_Leave_AnimationBackStep_C:OnNotifyBegin_5A1B92A34AEA8F9E449C2AAE2F12A51B(NotifyName) end
---@param NotifyName FName
function UBP_AIAction_Leave_AnimationBackStep_C:OnInterrupted_5A1B92A34AEA8F9E449C2AAE2F12A51B(NotifyName) end
---@param NotifyName FName
function UBP_AIAction_Leave_AnimationBackStep_C:OnBlendOut_5A1B92A34AEA8F9E449C2AAE2F12A51B(NotifyName) end
---@param NotifyName FName
function UBP_AIAction_Leave_AnimationBackStep_C:OnCompleted_5A1B92A34AEA8F9E449C2AAE2F12A51B(NotifyName) end
---@param ControlledPawn APawn
function UBP_AIAction_Leave_AnimationBackStep_C:ActionStart(ControlledPawn) end
---@param ControlledPawn APawn
---@param DeltaSeconds float
function UBP_AIAction_Leave_AnimationBackStep_C:ActionTick(ControlledPawn, DeltaSeconds) end
---@param ControlledPawn APawn
function UBP_AIAction_Leave_AnimationBackStep_C:ActionAbort(ControlledPawn) end
---@param ControlledPawn APawn
---@param WithResult EPawnActionResult::Type
function UBP_AIAction_Leave_AnimationBackStep_C:ActionFinished(ControlledPawn, WithResult) end
---@param ControlledPawn APawn
function UBP_AIAction_Leave_AnimationBackStep_C:ActionPause(ControlledPawn) end
---@param action UPawnAction
---@param WithResult EPawnActionResult::Type
function UBP_AIAction_Leave_AnimationBackStep_C:OnChildActionFinished(action, WithResult) end
---@param EntryPoint int32
function UBP_AIAction_Leave_AnimationBackStep_C:ExecuteUbergraph_BP_AIAction_Leave_AnimationBackStep(EntryPoint) end


