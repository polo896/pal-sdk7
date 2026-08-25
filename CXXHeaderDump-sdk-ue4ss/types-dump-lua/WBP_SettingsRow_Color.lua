---@meta

---@class UWBP_SettingsRow_Color_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Hue_Slider USlider
---@field Label UTextBlock
---@field Preview UBorder
---@field Saturation_Slider USlider
---@field TextBlock UTextBlock
---@field Value_Slider USlider
---@field SettingKey FString
---@field SatGradientMID UMaterialInstanceDynamic
---@field ValGradientMID UMaterialInstanceDynamic
local UWBP_SettingsRow_Color_C = {}

---@param Value float
function UWBP_SettingsRow_Color_C:BndEvt__WBP_SettingsRow_Color_Hue_Slider_K2Node_ComponentBoundEvent_0_OnFloatValueChangedEvent__DelegateSignature(Value) end
---@param Value float
function UWBP_SettingsRow_Color_C:BndEvt__WBP_SettingsRow_Color_Saturation_Slider_K2Node_ComponentBoundEvent_1_OnFloatValueChangedEvent__DelegateSignature(Value) end
---@param Value float
function UWBP_SettingsRow_Color_C:BndEvt__WBP_SettingsRow_Color_Value_Slider_K2Node_ComponentBoundEvent_2_OnFloatValueChangedEvent__DelegateSignature(Value) end
function UWBP_SettingsRow_Color_C:InitGradientMIDs() end
function UWBP_SettingsRow_Color_C:RefreshGradientTint() end
---@param EntryPoint int32
function UWBP_SettingsRow_Color_C:ExecuteUbergraph_WBP_SettingsRow_Color(EntryPoint) end


