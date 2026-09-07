---@meta

---@class UBP_UniqueAction_Sekhmet_RollingScratch_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ['Montage List'] TArray<FReserveMontage>
---@field MaxMoveTime double
---@field MoveEndTimer FTimerHandle
---@field Moving boolean
---@field EnableRotate boolean
---@field MoveSpeed double
---@field MoveTime double
---@field CurrentMoveTime double
---@field OriginalLocation FVector
---@field CurveMoveYAxis UCurveFloat
---@field OriginalRelativeLocation FVector
---@field AttackMove boolean
local UBP_UniqueAction_Sekhmet_RollingScratch_C = {}

---@param DeltaTime float
function UBP_UniqueAction_Sekhmet_RollingScratch_C:TickAction(DeltaTime) end
---@param EnableMove boolean
function UBP_UniqueAction_Sekhmet_RollingScratch_C:SwitchMoveState(EnableMove) end
---@param NotifyName FName
function UBP_UniqueAction_Sekhmet_RollingScratch_C:OnNotifyEnd_2C19DA884F70A8DC8007E59838536646(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_Sekhmet_RollingScratch_C:OnNotifyBegin_2C19DA884F70A8DC8007E59838536646(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_Sekhmet_RollingScratch_C:OnInterrupted_2C19DA884F70A8DC8007E59838536646(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_Sekhmet_RollingScratch_C:OnBlendOut_2C19DA884F70A8DC8007E59838536646(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_Sekhmet_RollingScratch_C:OnCompleted_2C19DA884F70A8DC8007E59838536646(NotifyName) end
function UBP_UniqueAction_Sekhmet_RollingScratch_C:OnBeginAction() end
function UBP_UniqueAction_Sekhmet_RollingScratch_C:OnEndAction() end
function UBP_UniqueAction_Sekhmet_RollingScratch_C:ActEndAttack() end
---@param Montage UAnimMontage
---@param NotifyName FName
function UBP_UniqueAction_Sekhmet_RollingScratch_C:OnNotifyBegin(Montage, NotifyName) end
---@param EntryPoint int32
function UBP_UniqueAction_Sekhmet_RollingScratch_C:ExecuteUbergraph_BP_UniqueAction_Sekhmet_RollingScratch(EntryPoint) end


