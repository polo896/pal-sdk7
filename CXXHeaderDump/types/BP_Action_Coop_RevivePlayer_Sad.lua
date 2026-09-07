---@meta

---@class UBP_Action_Coop_RevivePlayer_Sad_C : UBP_Action_Coop_RevivePlayer_LookAtBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field MinTime float
---@field ReviveLocationOffset FVector
local UBP_Action_Coop_RevivePlayer_Sad_C = {}

---@return FVector
function UBP_Action_Coop_RevivePlayer_Sad_C:CalcReviveLocation() end
function UBP_Action_Coop_RevivePlayer_Sad_C:OnBeginAction() end
function UBP_Action_Coop_RevivePlayer_Sad_C:OnEndAction() end
---@param DeltaTime float
function UBP_Action_Coop_RevivePlayer_Sad_C:TickAction(DeltaTime) end
---@param EntryPoint int32
function UBP_Action_Coop_RevivePlayer_Sad_C:ExecuteUbergraph_BP_Action_Coop_RevivePlayer_Sad(EntryPoint) end


