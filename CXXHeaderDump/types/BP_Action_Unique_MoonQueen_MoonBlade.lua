---@meta

---@class UBP_Action_Unique_MoonQueen_MoonBlade_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field MoonBladeMode EAction_MoonQueenMoonBladeModeType::Type
---@field SocketName FName
---@field HorizontalOffsetPosition double
---@field IsRotating boolean
---@field MontageArray TArray<FReserveMontage>
---@field SelfRotateSpeed double
---@field TimerHandles TArray<FTimerHandle>
---@field NewVar int32
---@field BladeNames TArray<FName>
local UBP_Action_Unique_MoonQueen_MoonBlade_C = {}

---@param BladeName FName
UBP_Action_Unique_MoonQueen_MoonBlade_C['Create Moon Blade'] = function(self, BladeName) end
---@param Name FName
---@param RotationX double
function UBP_Action_Unique_MoonQueen_MoonBlade_C:GetLocationZOffset(Name, RotationX) end
---@param Name FName
---@param RotationX double
function UBP_Action_Unique_MoonQueen_MoonBlade_C:GetRotationX(Name, RotationX) end
function UBP_Action_Unique_MoonQueen_MoonBlade_C:StopMontage() end
---@param Montages TArray<FReserveMontage>
---@param Length double
function UBP_Action_Unique_MoonQueen_MoonBlade_C:CalcMontageLength(Montages, Length) end
---@param Motages TArray<FReserveMontage>
function UBP_Action_Unique_MoonQueen_MoonBlade_C:GetMontageArray(Motages) end
---@param Instance ABP_SkillEffect_Unique_MoonQueen_MoonBlade_C
function UBP_Action_Unique_MoonQueen_MoonBlade_C:SpawnMoonBlade(Instance) end
function UBP_Action_Unique_MoonQueen_MoonBlade_C:OnBeginAction() end
function UBP_Action_Unique_MoonQueen_MoonBlade_C:MoonBladeVertical() end
function UBP_Action_Unique_MoonQueen_MoonBlade_C:MoonBladeHorizontal() end
function UBP_Action_Unique_MoonQueen_MoonBlade_C:OnEndAction() end
---@param DeltaTime float
function UBP_Action_Unique_MoonQueen_MoonBlade_C:TickAction(DeltaTime) end
---@param Montage UAnimMontage
---@param NotifyName FName
function UBP_Action_Unique_MoonQueen_MoonBlade_C:OnMontageNotify(Montage, NotifyName) end
---@param Montage UAnimMontage
---@param bInterrupted boolean
function UBP_Action_Unique_MoonQueen_MoonBlade_C:OnMontageEnd(Montage, bInterrupted) end
---@param EntryPoint int32
function UBP_Action_Unique_MoonQueen_MoonBlade_C:ExecuteUbergraph_BP_Action_Unique_MoonQueen_MoonBlade(EntryPoint) end


