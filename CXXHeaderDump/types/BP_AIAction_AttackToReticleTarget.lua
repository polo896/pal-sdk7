---@meta

---@class UBP_AIAction_AttackToReticleTarget_C : UPalAIActionBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ControlledPawn APawn
---@field OwnerCharacter APalCharacter
---@field PartnerSkillParam UPalPartnerSkillParameterComponent
---@field PlayerCharacter APalCharacter
---@field IsAborted boolean
---@field TargetCharacter APalCharacter
---@field FindTargetElapedTime double
---@field FindTargetTimeLimit double
---@field IsTargetFound boolean
---@field flagName FName
local UBP_AIAction_AttackToReticleTarget_C = {}

---@param Enable boolean
function UBP_AIAction_AttackToReticleTarget_C:SetEnableReticleTargetFlag(Enable) end
---@param Result boolean
function UBP_AIAction_AttackToReticleTarget_C:CanFindTarget(Result) end
---@return FText
function UBP_AIAction_AttackToReticleTarget_C:GetSkillName() end
function UBP_AIAction_AttackToReticleTarget_C:AddLogExecute() end
function UBP_AIAction_AttackToReticleTarget_C:AddLogTargetNotFound() end
---@param Target APalCharacter
---@param IsValid boolean
function UBP_AIAction_AttackToReticleTarget_C:IsTargetValid(Target, IsValid) end
function UBP_AIAction_AttackToReticleTarget_C:FinishAction() end
---@param IsFound boolean
---@param Target APalCharacter
function UBP_AIAction_AttackToReticleTarget_C:FindTarget(IsFound, Target) end
---@param DeltaTime double
function UBP_AIAction_AttackToReticleTarget_C:Tick_ObserveTarget(DeltaTime) end
---@param DeltaTime double
---@param TargetFound boolean
function UBP_AIAction_AttackToReticleTarget_C:Tick_FindTarget(DeltaTime, TargetFound) end
---@param ControlledPawn APawn
function UBP_AIAction_AttackToReticleTarget_C:SetupAction(ControlledPawn) end
---@param ControlledPawn APawn
---@param DeltaSeconds float
function UBP_AIAction_AttackToReticleTarget_C:ActionTick(ControlledPawn, DeltaSeconds) end
---@param ControlledPawn APawn
function UBP_AIAction_AttackToReticleTarget_C:ActionStart(ControlledPawn) end
---@param ControlledPawn APawn
function UBP_AIAction_AttackToReticleTarget_C:ActionAbort(ControlledPawn) end
---@param ControlledPawn APawn
---@param WithResult EPawnActionResult::Type
function UBP_AIAction_AttackToReticleTarget_C:ActionFinished(ControlledPawn, WithResult) end
---@param TargetActor AActor
function UBP_AIAction_AttackToReticleTarget_C:OnTargetFound(TargetActor) end
function UBP_AIAction_AttackToReticleTarget_C:OnTargetLost() end
---@param EntryPoint int32
function UBP_AIAction_AttackToReticleTarget_C:ExecuteUbergraph_BP_AIAction_AttackToReticleTarget(EntryPoint) end


