---@meta

---@class UBP_UniqueAction_DomeArmorDragon_ExplosiveMissile_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ['Montage List'] TArray<FReserveMontage>
---@field FireCount int32
---@field MaxFireCount int32
---@field EnableRotate boolean
---@field Aiming boolean
---@field BlendAlpha float
local UBP_UniqueAction_DomeArmorDragon_ExplosiveMissile_C = {}

---@param DeltaTime float
function UBP_UniqueAction_DomeArmorDragon_ExplosiveMissile_C:TickAction(DeltaTime) end
---@param Index int32
function UBP_UniqueAction_DomeArmorDragon_ExplosiveMissile_C:Fire(Index) end
---@param NotifyName FName
function UBP_UniqueAction_DomeArmorDragon_ExplosiveMissile_C:OnNotifyEnd_0CD8850C48FAA04E75AC14A2232309E8(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_DomeArmorDragon_ExplosiveMissile_C:OnNotifyBegin_0CD8850C48FAA04E75AC14A2232309E8(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_DomeArmorDragon_ExplosiveMissile_C:OnInterrupted_0CD8850C48FAA04E75AC14A2232309E8(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_DomeArmorDragon_ExplosiveMissile_C:OnBlendOut_0CD8850C48FAA04E75AC14A2232309E8(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_DomeArmorDragon_ExplosiveMissile_C:OnCompleted_0CD8850C48FAA04E75AC14A2232309E8(NotifyName) end
function UBP_UniqueAction_DomeArmorDragon_ExplosiveMissile_C:OnBeginAction() end
function UBP_UniqueAction_DomeArmorDragon_ExplosiveMissile_C:OnEndAction() end
---@param Montage UAnimMontage
---@param NotifyName FName
function UBP_UniqueAction_DomeArmorDragon_ExplosiveMissile_C:OnMontageNotify(Montage, NotifyName) end
function UBP_UniqueAction_DomeArmorDragon_ExplosiveMissile_C:ActEnd() end
---@param EntryPoint int32
function UBP_UniqueAction_DomeArmorDragon_ExplosiveMissile_C:ExecuteUbergraph_BP_UniqueAction_DomeArmorDragon_ExplosiveMissile(EntryPoint) end


