---@meta

---@class UWBP_AssignBoard_WorkListBase_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field MyAssignInfo FPalUIBaseCampWorkFixedAssignInfo
---@field OnSelected FWBP_AssignBoard_WorkListBase_COnSelected
---@field OnHovered FWBP_AssignBoard_WorkListBase_COnHovered
---@field OnUnhovered FWBP_AssignBoard_WorkListBase_COnUnhovered
---@field IsFirstSetup boolean
local UWBP_AssignBoard_WorkListBase_C = {}

---@param TargetWidget UWidget
function UWBP_AssignBoard_WorkListBase_C:GetFocusTarget(TargetWidget) end
function UWBP_AssignBoard_WorkListBase_C:Unbind() end
function UWBP_AssignBoard_WorkListBase_C:NotifySelect() end
---@param AssignInfo FPalUIBaseCampWorkFixedAssignInfo
function UWBP_AssignBoard_WorkListBase_C:GetAssignInfo(AssignInfo) end
function UWBP_AssignBoard_WorkListBase_C:Setup() end
---@param AssignInfo FPalUIBaseCampWorkFixedAssignInfo
function UWBP_AssignBoard_WorkListBase_C:SetAssignInfo(AssignInfo) end
function UWBP_AssignBoard_WorkListBase_C:AnmEvent_Select() end
function UWBP_AssignBoard_WorkListBase_C:AnmEvent_Unselect() end
function UWBP_AssignBoard_WorkListBase_C:AnmEvent_Enable() end
function UWBP_AssignBoard_WorkListBase_C:AnmEvent_DIsable() end
---@param EntryPoint int32
function UWBP_AssignBoard_WorkListBase_C:ExecuteUbergraph_WBP_AssignBoard_WorkListBase(EntryPoint) end
---@param Widget UWBP_AssignBoard_WorkListBase_C
function UWBP_AssignBoard_WorkListBase_C:OnUnhovered__DelegateSignature(Widget) end
---@param Widget UWBP_AssignBoard_WorkListBase_C
function UWBP_AssignBoard_WorkListBase_C:OnHovered__DelegateSignature(Widget) end
---@param Widget UWBP_AssignBoard_WorkListBase_C
function UWBP_AssignBoard_WorkListBase_C:OnSelected__DelegateSignature(Widget) end


