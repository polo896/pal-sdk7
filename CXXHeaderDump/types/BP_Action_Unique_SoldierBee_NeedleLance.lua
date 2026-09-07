---@meta

---@class UBP_Action_Unique_SoldierBee_NeedleLance_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field TackleModule UBP_UniqueSkillModule_Tackle_C
---@field SelfRotateSpeed double
---@field EndAttackDistance double
---@field EndEffectClass TSubclassOf<ABP_SkillEffectBase_C>
---@field MinMoveDistance double
---@field StartLocation FVector
local UBP_Action_Unique_SoldierBee_NeedleLance_C = {}

function UBP_Action_Unique_SoldierBee_NeedleLance_C:OnBeginAction() end
function UBP_Action_Unique_SoldierBee_NeedleLance_C:OnEndAction() end
---@param DeltaTime float
function UBP_Action_Unique_SoldierBee_NeedleLance_C:TickAction(DeltaTime) end
function UBP_Action_Unique_SoldierBee_NeedleLance_C:OnModuleCompletedEndMontage() end
---@param Montage UAnimMontage
---@param NotifyName FName
function UBP_Action_Unique_SoldierBee_NeedleLance_C:OnMontageNotify(Montage, NotifyName) end
---@param EntryPoint int32
function UBP_Action_Unique_SoldierBee_NeedleLance_C:ExecuteUbergraph_BP_Action_Unique_SoldierBee_NeedleLance(EntryPoint) end


