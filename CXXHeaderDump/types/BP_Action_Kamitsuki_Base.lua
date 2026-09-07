---@meta

---@class UBP_Action_Kamitsuki_Base_C : UPalActionWazaBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field IsEndCheck boolean
---@field StartAttackTime double
---@field EndAttackTime double
---@field RotatSpeed double
---@field Montage_Attack UAnimMontage
local UBP_Action_Kamitsuki_Base_C = {}

---@param Position FVector
function UBP_Action_Kamitsuki_Base_C:GetTargetPosition(Position) end
---@param Speed double
function UBP_Action_Kamitsuki_Base_C:Lookat(Speed) end
---@param NotifyName FName
function UBP_Action_Kamitsuki_Base_C:OnNotifyEnd_C5D2F3BD42F3F92B66AD4FBA6EBC1D6B(NotifyName) end
---@param NotifyName FName
function UBP_Action_Kamitsuki_Base_C:OnNotifyBegin_C5D2F3BD42F3F92B66AD4FBA6EBC1D6B(NotifyName) end
---@param NotifyName FName
function UBP_Action_Kamitsuki_Base_C:OnInterrupted_C5D2F3BD42F3F92B66AD4FBA6EBC1D6B(NotifyName) end
---@param NotifyName FName
function UBP_Action_Kamitsuki_Base_C:OnBlendOut_C5D2F3BD42F3F92B66AD4FBA6EBC1D6B(NotifyName) end
---@param NotifyName FName
function UBP_Action_Kamitsuki_Base_C:OnCompleted_C5D2F3BD42F3F92B66AD4FBA6EBC1D6B(NotifyName) end
---@param DeltaTime float
function UBP_Action_Kamitsuki_Base_C:TickAction(DeltaTime) end
function UBP_Action_Kamitsuki_Base_C:OnBeginAction() end
function UBP_Action_Kamitsuki_Base_C:OnEndAction() end
---@param EntryPoint int32
function UBP_Action_Kamitsuki_Base_C:ExecuteUbergraph_BP_Action_Kamitsuki_Base(EntryPoint) end


