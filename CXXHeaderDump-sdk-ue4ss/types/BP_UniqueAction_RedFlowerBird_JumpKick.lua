---@meta

---@class UBP_UniqueAction_RedFlowerBird_JumpKick_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field EnableMove boolean
---@field MoveSpeed double
---@field CurrentDirect FVector
local UBP_UniqueAction_RedFlowerBird_JumpKick_C = {}

---@param EnableMove boolean
UBP_UniqueAction_RedFlowerBird_JumpKick_C['Switch Move State'] = function(self, EnableMove) end
---@param NotifyName FName
function UBP_UniqueAction_RedFlowerBird_JumpKick_C:OnNotifyEnd_CBEDBCF5417DAF8DD25D2D8309D267DA(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_RedFlowerBird_JumpKick_C:OnNotifyBegin_CBEDBCF5417DAF8DD25D2D8309D267DA(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_RedFlowerBird_JumpKick_C:OnInterrupted_CBEDBCF5417DAF8DD25D2D8309D267DA(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_RedFlowerBird_JumpKick_C:OnBlendOut_CBEDBCF5417DAF8DD25D2D8309D267DA(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_RedFlowerBird_JumpKick_C:OnCompleted_CBEDBCF5417DAF8DD25D2D8309D267DA(NotifyName) end
function UBP_UniqueAction_RedFlowerBird_JumpKick_C:OnBeginAction() end
function UBP_UniqueAction_RedFlowerBird_JumpKick_C:OnEndAction() end
---@param DeltaTime float
function UBP_UniqueAction_RedFlowerBird_JumpKick_C:TickAction(DeltaTime) end
---@param EntryPoint int32
function UBP_UniqueAction_RedFlowerBird_JumpKick_C:ExecuteUbergraph_BP_UniqueAction_RedFlowerBird_JumpKick(EntryPoint) end


