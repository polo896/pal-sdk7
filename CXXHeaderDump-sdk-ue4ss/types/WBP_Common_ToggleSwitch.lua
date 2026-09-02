---@meta

---@class UWBP_Common_ToggleSwitch_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Off_ON UWidgetAnimation
---@field Image_260 UImage
---@field Image_Base_Off UImage
---@field Image_Base_On UImage
---@field Image_Shadow UImage
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnToggleClicked FWBP_Common_ToggleSwitch_COnToggleClicked
local UWBP_Common_ToggleSwitch_C = {}

---@param bIsOn boolean
---@param bImmediate boolean
function UWBP_Common_ToggleSwitch_C:SetToggleState(bIsOn, bImmediate) end
---@param Button UCommonButtonBase
UWBP_Common_ToggleSwitch_C['OnButtonBaseClicked_イベント'] = function(self, Button) end
function UWBP_Common_ToggleSwitch_C:Construct() end
---@param EntryPoint int32
function UWBP_Common_ToggleSwitch_C:ExecuteUbergraph_WBP_Common_ToggleSwitch(EntryPoint) end
function UWBP_Common_ToggleSwitch_C:OnToggleClicked__DelegateSignature() end


