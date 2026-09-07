---@meta

---@class UWBP_Title_DeleteWorldWindow_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Image_57 UImage
---@field PalEditableTextBox_144 UPalEditableTextBox
---@field WBP_CommonButton_Cancel UWBP_CommonButton_C
---@field WBP_CommonButton_Confirm UWBP_CommonButton_C
---@field WBP_PalCommonWindow UWBP_PalCommonWindow_C
local UWBP_Title_DeleteWorldWindow_C = {}

---@param bResult boolean
function UWBP_Title_DeleteWorldWindow_C:OnClosedDeleteCheckDialog(bResult) end
function UWBP_Title_DeleteWorldWindow_C:OpenCheckDialog() end
---@return UWidget
function UWBP_Title_DeleteWorldWindow_C:BP_GetDesiredFocusTarget() end
---@param IsEnable boolean
function UWBP_Title_DeleteWorldWindow_C:SetEnableConfirmButton(IsEnable) end
function UWBP_Title_DeleteWorldWindow_C:Construct() end
function UWBP_Title_DeleteWorldWindow_C:OnSetup() end
function UWBP_Title_DeleteWorldWindow_C:BndEvt__WBP_CharaCre_PlayerNameEdit_WBP_CommonButton_K2Node_ComponentBoundEvent_2_OnClicked__DelegateSignature() end
function UWBP_Title_DeleteWorldWindow_C:BndEvt__WBP_Title_DeleteWorldWindow_WBP_CommonButton_Cancel_K2Node_ComponentBoundEvent_3_OnClicked__DelegateSignature() end
---@param Text FText
function UWBP_Title_DeleteWorldWindow_C:BndEvt__WBP_Title_DeleteWorldWindow_PalEditableTextBox_144_K2Node_ComponentBoundEvent_4_OnEditableTextBoxChangedEvent__DelegateSignature(Text) end
---@param Text FText
---@param CommitMethod ETextCommit::Type
function UWBP_Title_DeleteWorldWindow_C:BndEvt__WBP_Title_DeleteWorldWindow_PalEditableTextBox_144_K2Node_ComponentBoundEvent_5_OnEditableTextBoxCommittedEvent__DelegateSignature(Text, CommitMethod) end
---@param EntryPoint int32
function UWBP_Title_DeleteWorldWindow_C:ExecuteUbergraph_WBP_Title_DeleteWorldWindow(EntryPoint) end


