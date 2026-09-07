---@meta

---@class UBP_Action_Coop_RevivePlayer_LookAtBase_C : UPalActionBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Timer double
---@field MaxTime double
---@field flagName FName
---@field EyeType EPalFacialEyeType
local UBP_Action_Coop_RevivePlayer_LookAtBase_C = {}

---@param Enable boolean
function UBP_Action_Coop_RevivePlayer_LookAtBase_C:ChangeFace(Enable) end
function UBP_Action_Coop_RevivePlayer_LookAtBase_C:OnBeginAction() end
---@param DeltaTime float
function UBP_Action_Coop_RevivePlayer_LookAtBase_C:TickAction(DeltaTime) end
function UBP_Action_Coop_RevivePlayer_LookAtBase_C:OnEndAction() end
---@param EntryPoint int32
function UBP_Action_Coop_RevivePlayer_LookAtBase_C:ExecuteUbergraph_BP_Action_Coop_RevivePlayer_LookAtBase(EntryPoint) end


