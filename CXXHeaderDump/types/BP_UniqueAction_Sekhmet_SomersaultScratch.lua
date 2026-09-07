---@meta

---@class UBP_UniqueAction_Sekhmet_SomersaultScratch_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field EnableRotate boolean
---@field Moving boolean
---@field MoveTime double
---@field MoveCurve UCurveFloat
---@field MoveSpeed float
local UBP_UniqueAction_Sekhmet_SomersaultScratch_C = {}

---@param EnableMove boolean
function UBP_UniqueAction_Sekhmet_SomersaultScratch_C:SwitchMoveState(EnableMove) end
---@param NotifyName FName
function UBP_UniqueAction_Sekhmet_SomersaultScratch_C:OnNotifyEnd_713F230C485A5E4BE0A049958D65196A(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_Sekhmet_SomersaultScratch_C:OnNotifyBegin_713F230C485A5E4BE0A049958D65196A(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_Sekhmet_SomersaultScratch_C:OnInterrupted_713F230C485A5E4BE0A049958D65196A(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_Sekhmet_SomersaultScratch_C:OnBlendOut_713F230C485A5E4BE0A049958D65196A(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_Sekhmet_SomersaultScratch_C:OnCompleted_713F230C485A5E4BE0A049958D65196A(NotifyName) end
function UBP_UniqueAction_Sekhmet_SomersaultScratch_C:OnBeginAction() end
function UBP_UniqueAction_Sekhmet_SomersaultScratch_C:OnEndAction() end
---@param DeltaTime float
function UBP_UniqueAction_Sekhmet_SomersaultScratch_C:TickAction(DeltaTime) end
---@param EntryPoint int32
function UBP_UniqueAction_Sekhmet_SomersaultScratch_C:ExecuteUbergraph_BP_UniqueAction_Sekhmet_SomersaultScratch(EntryPoint) end


