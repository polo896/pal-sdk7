---@meta

---@class UBP_UniqueAction_KamitsukiV2_Base_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field EnableRotate boolean
---@field MoveCurve1 UCurveVector
---@field MoveCurve2 UCurveVector
---@field ActMove1 boolean
---@field ActMove2 boolean
---@field ['Max Speed Multiply'] double
---@field MoveTimer double
---@field ForwardMoveMultiplier double
---@field Montage_Attack UAnimMontage
local UBP_UniqueAction_KamitsukiV2_Base_C = {}

---@param DeltaTime float
function UBP_UniqueAction_KamitsukiV2_Base_C:TickAction(DeltaTime) end
---@param IsMoveable boolean
function UBP_UniqueAction_KamitsukiV2_Base_C:SwitchMoveState(IsMoveable) end
---@param NotifyName FName
function UBP_UniqueAction_KamitsukiV2_Base_C:OnNotifyEnd_717AC8E745DCAE9D4CF200946CC26917(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_KamitsukiV2_Base_C:OnNotifyBegin_717AC8E745DCAE9D4CF200946CC26917(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_KamitsukiV2_Base_C:OnInterrupted_717AC8E745DCAE9D4CF200946CC26917(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_KamitsukiV2_Base_C:OnBlendOut_717AC8E745DCAE9D4CF200946CC26917(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_KamitsukiV2_Base_C:OnCompleted_717AC8E745DCAE9D4CF200946CC26917(NotifyName) end
function UBP_UniqueAction_KamitsukiV2_Base_C:OnEndAction() end
function UBP_UniqueAction_KamitsukiV2_Base_C:OnBeginAction() end
---@param EntryPoint int32
function UBP_UniqueAction_KamitsukiV2_Base_C:ExecuteUbergraph_BP_UniqueAction_KamitsukiV2_Base(EntryPoint) end


