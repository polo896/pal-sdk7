---@meta

---@class UBP_UniqueAction_BlueSkyDragon_DrainStorm_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ['Montage List'] TArray<FReserveMontage>
---@field StormEffect ABP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_C
---@field PullTime float
local UBP_UniqueAction_BlueSkyDragon_DrainStorm_C = {}

function UBP_UniqueAction_BlueSkyDragon_DrainStorm_C:OnBeginAction() end
function UBP_UniqueAction_BlueSkyDragon_DrainStorm_C:OnEndAction() end
---@param Montage UAnimMontage
---@param bInterrupted boolean
function UBP_UniqueAction_BlueSkyDragon_DrainStorm_C:OnMontageEnd(Montage, bInterrupted) end
---@param Montage UAnimMontage
---@param NotifyName FName
function UBP_UniqueAction_BlueSkyDragon_DrainStorm_C:OnMontageNotify(Montage, NotifyName) end
---@param EntryPoint int32
function UBP_UniqueAction_BlueSkyDragon_DrainStorm_C:ExecuteUbergraph_BP_UniqueAction_BlueSkyDragon_DrainStorm(EntryPoint) end


