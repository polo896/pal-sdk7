---@meta

---@class UWBP_Title_WorldSettings_NameWindow_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Image_57 UImage
---@field PalEditableTextBox_0 UPalEditableTextBox
---@field WBP_CommonButton UWBP_CommonButton_C
---@field WBP_PalCommonWindow UWBP_PalCommonWindow_C
---@field ['Default Input Name'] FString
local UWBP_Title_WorldSettings_NameWindow_C = {}

---@return UWidget
function UWBP_Title_WorldSettings_NameWindow_C:BP_GetDesiredFocusTarget() end
function UWBP_Title_WorldSettings_NameWindow_C:OnSetup() end
---@param Text FText
---@param CommitMethod ETextCommit::Type
function UWBP_Title_WorldSettings_NameWindow_C:BndEvt__WBP_Title_WorldSettings_NameWindow_PalEditableTextBox_0_K2Node_ComponentBoundEvent_4_OnEditableTextBoxCommittedEvent__DelegateSignature(Text, CommitMethod) end
function UWBP_Title_WorldSettings_NameWindow_C:BndEvt__WBP_Title_WorldSettings_NameWindow_WBP_CommonButton_K2Node_ComponentBoundEvent_5_OnClicked__DelegateSignature() end
---@param Text FText
function UWBP_Title_WorldSettings_NameWindow_C:BndEvt__WBP_Title_WorldSettings_NameWindow_PalEditableTextBox_0_K2Node_ComponentBoundEvent_6_OnEditableTextBoxChangedEvent__DelegateSignature(Text) end
---@param EntryPoint int32
function UWBP_Title_WorldSettings_NameWindow_C:ExecuteUbergraph_WBP_Title_WorldSettings_NameWindow(EntryPoint) end


