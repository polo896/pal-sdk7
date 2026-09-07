---@meta

---@class UBP_UniqueAction_BlueSkyDragon_SweepBreath_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field EnableRotate boolean
---@field RotateReturn boolean
---@field BreathManager ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathManager_C
---@field EnableHeightAdjust boolean
---@field HeightAdjustSpeed double
---@field AccHeight double
---@field OriginalLocation FVector
local UBP_UniqueAction_BlueSkyDragon_SweepBreath_C = {}

---@param DeltaTime double
---@param NoInterp boolean
---@param Rotation FRotator
function UBP_UniqueAction_BlueSkyDragon_SweepBreath_C:GetRotation(DeltaTime, NoInterp, Rotation) end
---@param DeltaTime float
function UBP_UniqueAction_BlueSkyDragon_SweepBreath_C:TickAction(DeltaTime) end
---@param NotifyName FName
function UBP_UniqueAction_BlueSkyDragon_SweepBreath_C:OnNotifyEnd_B748556441A2BBC880E05EA4DE81F2C1(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_BlueSkyDragon_SweepBreath_C:OnNotifyBegin_B748556441A2BBC880E05EA4DE81F2C1(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_BlueSkyDragon_SweepBreath_C:OnInterrupted_B748556441A2BBC880E05EA4DE81F2C1(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_BlueSkyDragon_SweepBreath_C:OnBlendOut_B748556441A2BBC880E05EA4DE81F2C1(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_BlueSkyDragon_SweepBreath_C:OnCompleted_B748556441A2BBC880E05EA4DE81F2C1(NotifyName) end
function UBP_UniqueAction_BlueSkyDragon_SweepBreath_C:OnBeginAction() end
function UBP_UniqueAction_BlueSkyDragon_SweepBreath_C:OnEndAction() end
---@param EntryPoint int32
function UBP_UniqueAction_BlueSkyDragon_SweepBreath_C:ExecuteUbergraph_BP_UniqueAction_BlueSkyDragon_SweepBreath(EntryPoint) end


