---@meta

---@class UBP_UniqueAction_LegendDeer_RadiantPurge_Otomo_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ['Montage List'] TArray<FReserveMontage>
---@field State Enum_RadiantPurge_State::Type
---@field ChargeTime double
---@field CurrentTimer FTimerHandle
---@field ActTime float
---@field OriginalLocation FVector
---@field JumpHeight double
---@field CurrentOffsetAlpha float
---@field Landing boolean
---@field BallEffect ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Ball_C
---@field Ball_Height double
local UBP_UniqueAction_LegendDeer_RadiantPurge_Otomo_C = {}

---@param DeltaTime float
function UBP_UniqueAction_LegendDeer_RadiantPurge_Otomo_C:TickAction(DeltaTime) end
---@param montageList TArray<FReserveMontage>
function UBP_UniqueAction_LegendDeer_RadiantPurge_Otomo_C:GetMontageListByState(montageList) end
---@param NotifyName FName
function UBP_UniqueAction_LegendDeer_RadiantPurge_Otomo_C:OnNotifyEnd_53B9EC8A4DCE6F86D0C02BB1828E2148(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_LegendDeer_RadiantPurge_Otomo_C:OnNotifyBegin_53B9EC8A4DCE6F86D0C02BB1828E2148(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_LegendDeer_RadiantPurge_Otomo_C:OnInterrupted_53B9EC8A4DCE6F86D0C02BB1828E2148(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_LegendDeer_RadiantPurge_Otomo_C:OnBlendOut_53B9EC8A4DCE6F86D0C02BB1828E2148(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_LegendDeer_RadiantPurge_Otomo_C:OnCompleted_53B9EC8A4DCE6F86D0C02BB1828E2148(NotifyName) end
function UBP_UniqueAction_LegendDeer_RadiantPurge_Otomo_C:OnBeginAction() end
function UBP_UniqueAction_LegendDeer_RadiantPurge_Otomo_C:OnEndAction() end
function UBP_UniqueAction_LegendDeer_RadiantPurge_Otomo_C:Act() end
function UBP_UniqueAction_LegendDeer_RadiantPurge_Otomo_C:ActEnd() end
---@param Montage UAnimMontage
---@param bInterrupted boolean
function UBP_UniqueAction_LegendDeer_RadiantPurge_Otomo_C:OnMontageEnd(Montage, bInterrupted) end
---@param Montage UAnimMontage
---@param NotifyName FName
function UBP_UniqueAction_LegendDeer_RadiantPurge_Otomo_C:OnMontageNotify(Montage, NotifyName) end
---@param EntryPoint int32
function UBP_UniqueAction_LegendDeer_RadiantPurge_Otomo_C:ExecuteUbergraph_BP_UniqueAction_LegendDeer_RadiantPurge_Otomo(EntryPoint) end


