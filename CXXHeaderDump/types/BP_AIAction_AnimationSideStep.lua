---@meta

---@class UBP_AIAction_AnimationSideStep_C : UPalAIActionBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field SideWalkProbability double
---@field SelfActor APalCharacter
---@field PlayAction UPalActionBase
---@field HasSideStepped boolean
local UBP_AIAction_AnimationSideStep_C = {}

---@param PalBlackBoard UBP_PalAIBlackboard_Common_C
function UBP_AIAction_AnimationSideStep_C:GetSelfPalBlackBoard(PalBlackBoard) end
---@param IsRight boolean
---@param StepLocation FVector
function UBP_AIAction_AnimationSideStep_C:GetStepLocation(IsRight, StepLocation) end
---@param IsRight boolean
---@param actionClass TSubclassOf<UPalActionBase>
function UBP_AIAction_AnimationSideStep_C:GetPlayAction(IsRight, actionClass) end
---@param IsRight boolean
---@param Montage UAnimMontage
function UBP_AIAction_AnimationSideStep_C:GetPlayMontage(IsRight, Montage) end
---@param Location FVector
---@param CanStep boolean
---@param IsRight boolean
function UBP_AIAction_AnimationSideStep_C:FindStepLocation(Location, CanStep, IsRight) end
---@param ControlledPawn APawn
function UBP_AIAction_AnimationSideStep_C:ActionStart(ControlledPawn) end
---@param action UPawnAction
---@param WithResult EPawnActionResult::Type
function UBP_AIAction_AnimationSideStep_C:OnChildActionFinished(action, WithResult) end
---@param ControlledPawn APawn
function UBP_AIAction_AnimationSideStep_C:ActionAbort(ControlledPawn) end
---@param ControlledPawn APawn
---@param WithResult EPawnActionResult::Type
function UBP_AIAction_AnimationSideStep_C:ActionFinished(ControlledPawn, WithResult) end
---@param ControlledPawn APawn
function UBP_AIAction_AnimationSideStep_C:ActionPause(ControlledPawn) end
---@param ControlledPawn APawn
---@param DeltaSeconds float
function UBP_AIAction_AnimationSideStep_C:ActionTick(ControlledPawn, DeltaSeconds) end
---@param EntryPoint int32
function UBP_AIAction_AnimationSideStep_C:ExecuteUbergraph_BP_AIAction_AnimationSideStep(EntryPoint) end


