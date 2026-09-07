---@meta

---@class UBP_Action_Unique_Anubis_GroundPunch_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field DefaultJumpZ double
---@field JumpZVelocity double
---@field GravityRate double
---@field flagName_0 FName
---@field State EAction_Anubis_GroundPunchState::Type
---@field TargetLocation FVector2D
---@field StartLocation FVector2D
---@field MovementTimer double
---@field MovementTime double
---@field StateChangeVelocityZ double
---@field StateChangeGroundRange double
---@field AdditionalTargetingTime double
---@field OmenEffect UNiagaraComponent
local UBP_Action_Unique_Anubis_GroundPunch_C = {}

function UBP_Action_Unique_Anubis_GroundPunch_C:StopMontage() end
function UBP_Action_Unique_Anubis_GroundPunch_C:ActivateOmenEffect() end
---@param DeltaTime double
UBP_Action_Unique_Anubis_GroundPunch_C['Update Effect Location'] = function(self, DeltaTime) end
UBP_Action_Unique_Anubis_GroundPunch_C['Set Target Location'] = function(self, ) end
function UBP_Action_Unique_Anubis_GroundPunch_C:TerminateMovementState() end
---@param DeltaTime double
function UBP_Action_Unique_Anubis_GroundPunch_C:MovementActor(DeltaTime) end
---@param NotifyName FName
function UBP_Action_Unique_Anubis_GroundPunch_C:OnNotifyEnd_3EAF69114CDC3D3144F4EBB8A4E9DFF5(NotifyName) end
---@param NotifyName FName
function UBP_Action_Unique_Anubis_GroundPunch_C:OnNotifyBegin_3EAF69114CDC3D3144F4EBB8A4E9DFF5(NotifyName) end
---@param NotifyName FName
function UBP_Action_Unique_Anubis_GroundPunch_C:OnInterrupted_3EAF69114CDC3D3144F4EBB8A4E9DFF5(NotifyName) end
---@param NotifyName FName
function UBP_Action_Unique_Anubis_GroundPunch_C:OnBlendOut_3EAF69114CDC3D3144F4EBB8A4E9DFF5(NotifyName) end
---@param NotifyName FName
function UBP_Action_Unique_Anubis_GroundPunch_C:OnCompleted_3EAF69114CDC3D3144F4EBB8A4E9DFF5(NotifyName) end
---@param DeltaTime float
function UBP_Action_Unique_Anubis_GroundPunch_C:TickAction(DeltaTime) end
function UBP_Action_Unique_Anubis_GroundPunch_C:OnEndAction() end
function UBP_Action_Unique_Anubis_GroundPunch_C:OnBeginAction() end
---@param EntryPoint int32
function UBP_Action_Unique_Anubis_GroundPunch_C:ExecuteUbergraph_BP_Action_Unique_Anubis_GroundPunch(EntryPoint) end


