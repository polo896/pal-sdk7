---@meta

---@class UWBP_Altar_SelectItem_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WBP_PalCommonScrollList_Button UWBP_PalCommonScrollList_C
---@field WBP_PalCommonWindow UWBP_PalCommonWindow_C
---@field OnClickedCloseButton FWBP_Altar_SelectItem_COnClickedCloseButton
local UWBP_Altar_SelectItem_C = {}

---@param Widget UWidget
function UWBP_Altar_SelectItem_C:GetTopFocusTarget(Widget) end
function UWBP_Altar_SelectItem_C:BndEvt__WBP_Altar_SelectItem_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
---@param EntryPoint int32
function UWBP_Altar_SelectItem_C:ExecuteUbergraph_WBP_Altar_SelectItem(EntryPoint) end
function UWBP_Altar_SelectItem_C:OnClickedCloseButton__DelegateSignature() end


