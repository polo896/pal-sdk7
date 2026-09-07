---@meta

---@class UBP_AIAction_RoundStep_C : UPalAIActionBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field SideWalkProbability double
---@field SelfActor APalCharacter
---@field PlayAction UPalActionBase
---@field HasRoundStepped boolean
---@field MaxStepCount int32
---@field IsRightStep boolean
---@field RoundStepHistoryCache TArray<boolean>
local UBP_AIAction_RoundStep_C = {}

---@param IsMax boolean
function UBP_AIAction_RoundStep_C:IsStepCountMax(IsMax) end
---@param IsRight boolean
function UBP_AIAction_RoundStep_C:IsFirstCheckRight(IsRight) end
---@param PalBlackBoard UBP_PalAIBlackboard_Common_C
function UBP_AIAction_RoundStep_C:GetSelfPalBlackBoard(PalBlackBoard) end
---@param IsRight boolean
---@param StepLocation FVector
function UBP_AIAction_RoundStep_C:GetStepLocation(IsRight, StepLocation) end
---@param IsRight boolean
---@param actionClass TSubclassOf<UPalActionBase>
function UBP_AIAction_RoundStep_C:GetPlayAction(IsRight, actionClass) end
---@param IsRight boolean
---@param Montage UAnimMontage
function UBP_AIAction_RoundStep_C:GetPlayMontage(IsRight, Montage) end
---@param Location FVector
---@param CanStep boolean
---@param IsRight boolean
function UBP_AIAction_RoundStep_C:FindStepLocation(Location, CanStep, IsRight) end
---@param ControlledPawn APawn
function UBP_AIAction_RoundStep_C:ActionStart(ControlledPawn) end
---@param action UPawnAction
---@param WithResult EPawnActionResult::Type
function UBP_AIAction_RoundStep_C:OnChildActionFinished(action, WithResult) end
---@param ControlledPawn APawn
function UBP_AIAction_RoundStep_C:ActionAbort(ControlledPawn) end
---@param ControlledPawn APawn
---@param WithResult EPawnActionResult::Type
function UBP_AIAction_RoundStep_C:ActionFinished(ControlledPawn, WithResult) end
---@param ControlledPawn APawn
function UBP_AIAction_RoundStep_C:ActionPause(ControlledPawn) end
---@param ControlledPawn APawn
---@param DeltaSeconds float
function UBP_AIAction_RoundStep_C:ActionTick(ControlledPawn, DeltaSeconds) end
---@param EntryPoint int32
function UBP_AIAction_RoundStep_C:ExecuteUbergraph_BP_AIAction_RoundStep(EntryPoint) end


