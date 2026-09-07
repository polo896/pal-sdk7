---@meta

---@class UWBP_Arena_RuleListContent_0_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_NormalToFocus UWidgetAnimation
---@field BP_PalTextBlock_Name UBP_PalTextBlock_C
---@field Image_ChangeMark UImage
---@field SizeBox_Button USizeBox
---@field SizeBox_Slider USizeBox
---@field SizeBox_Switch USizeBox
---@field WBP_OptionSettings_ListContentSlider UWBP_OptionSettings_ListContentSlider_C
---@field WBP_OptionSettings_ListContentSwitch UWBP_OptionSettings_ListContentSwitch_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field WBP_Title_WorldSettings_ListButton UWBP_Title_WorldSettings_ListButton_C
---@field SettingName FDataTableRowHandle
---@field ['Is Changeable'] boolean
---@field OnContentHovered FWBP_Arena_RuleListContent_0_COnContentHovered
---@field ['Change Value'] double
---@field OnContentUnhovered FWBP_Arena_RuleListContent_0_COnContentUnhovered
local UWBP_Arena_RuleListContent_0_C = {}

---@param Navigation EUINavigation
---@return UWidget
UWBP_Arena_RuleListContent_0_C['Custom Navigation ToRight'] = function(self, Navigation) end
---@param Navigation EUINavigation
---@return UWidget
UWBP_Arena_RuleListContent_0_C['Custom Navigation ToLeft'] = function(self, Navigation) end
---@param IsChangeable boolean
function UWBP_Arena_RuleListContent_0_C:SetChangeable(IsChangeable) end
function UWBP_Arena_RuleListContent_0_C:SetChangedFlag() end
---@param OnClickEvent FSetupButtonOnClickEvent
---@param ButtonText FText
function UWBP_Arena_RuleListContent_0_C:SetupButton(OnClickEvent, ButtonText) end
---@param Value int32
---@param Min int32
---@param Max int32
---@param Event FSetupSlider_IntEvent
---@param ChangeValue double
function UWBP_Arena_RuleListContent_0_C:SetupSlider_Int(Value, Min, Max, Event, ChangeValue) end
---@param Value double
---@param Min double
---@param Max double
---@param Event FSetupSliderEvent
---@param ChangeValue double
function UWBP_Arena_RuleListContent_0_C:SetupSlider(Value, Min, Max, Event, ChangeValue) end
---@param IsTure boolean
---@param OnSwitchEvent FSetupSwitchOnSwitchEvent
function UWBP_Arena_RuleListContent_0_C:SetupSwitch(IsTure, OnSwitchEvent) end
function UWBP_Arena_RuleListContent_0_C:AnmEvent_Focus() end
function UWBP_Arena_RuleListContent_0_C:AnmEvent_Normal() end
function UWBP_Arena_RuleListContent_0_C:Construct() end
---@param Button UCommonButtonBase
function UWBP_Arena_RuleListContent_0_C:BndEvt__WBP_Arena_RuleListContent_0_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Arena_RuleListContent_0_C:BndEvt__WBP_Arena_RuleListContent_0_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Arena_RuleListContent_0_C:BndEvt__WBP_Arena_RuleListContent_0_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_3_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_Arena_RuleListContent_0_C:ExecuteUbergraph_WBP_Arena_RuleListContent_0(EntryPoint) end
function UWBP_Arena_RuleListContent_0_C:OnContentUnhovered__DelegateSignature() end
---@param Button UWidget
function UWBP_Arena_RuleListContent_0_C:OnContentHovered__DelegateSignature(Button) end


