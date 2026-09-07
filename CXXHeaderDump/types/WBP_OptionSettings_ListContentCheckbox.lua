---@meta

---@class UWBP_OptionSettings_ListContentCheckbox_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ButtonToggle_Mac UWBP_PalInvisibleButton_C
---@field ButtonToggle_PS5 UWBP_PalInvisibleButton_C
---@field ButtonToggle_Steam UWBP_PalInvisibleButton_C
---@field ButtonToggle_Xbox UWBP_PalInvisibleButton_C
---@field CheckBox_Mac UPalCheckBox
---@field CheckBox_PS5 UPalCheckBox
---@field CheckBox_Steam UPalCheckBox
---@field CheckBox_Xbox UPalCheckBox
---@field HorizontalBox_Mac UHorizontalBox
---@field HorizontalBox_PS5 UHorizontalBox
---@field HorizontalBox_Steam UHorizontalBox
---@field HorizontalBox_Xbox UHorizontalBox
---@field OnClickedCheckButton FWBP_OptionSettings_ListContentCheckbox_COnClickedCheckButton
local UWBP_OptionSettings_ListContentCheckbox_C = {}

---@param IsSteam boolean
---@param IsXbox boolean
---@param IsPS5 boolean
---@param IsMac boolean
function UWBP_OptionSettings_ListContentCheckbox_C:Setup(IsSteam, IsXbox, IsPS5, IsMac) end
---@param Checked boolean
function UWBP_OptionSettings_ListContentCheckbox_C:SetCheckButtonSteam(Checked) end
---@param Checked boolean
function UWBP_OptionSettings_ListContentCheckbox_C:SetCheckButtonXbox(Checked) end
---@param Checked boolean
function UWBP_OptionSettings_ListContentCheckbox_C:SetCheckButtonPS5(Checked) end
---@param Button UCommonButtonBase
function UWBP_OptionSettings_ListContentCheckbox_C:BndEvt__WBP_OptionSettings_ListContentCheckbox_ButtonToggle_PS5_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_OptionSettings_ListContentCheckbox_C:BndEvt__WBP_OptionSettings_ListContentCheckbox_ButtonToggle_Xbox_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_OptionSettings_ListContentCheckbox_C:BndEvt__WBP_OptionSettings_ListContentCheckbox_ButtonToggle_Steam_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_OptionSettings_ListContentCheckbox_C:BndEvt__WBP_OptionSettings_ListContentCheckbox_ButtonToggle_Mac_K2Node_ComponentBoundEvent_3_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Checked boolean
function UWBP_OptionSettings_ListContentCheckbox_C:SetCheckButtonMac(Checked) end
---@param EntryPoint int32
function UWBP_OptionSettings_ListContentCheckbox_C:ExecuteUbergraph_WBP_OptionSettings_ListContentCheckbox(EntryPoint) end
function UWBP_OptionSettings_ListContentCheckbox_C:OnClickedCheckButton__DelegateSignature() end


