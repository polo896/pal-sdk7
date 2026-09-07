---@meta

---@class UWBP_SettingsRow_Toggle_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field btnOne UButton
---@field btnOneText UTextBlock
---@field btnTwo UButton
---@field btnTwoText UTextBlock
---@field Label UTextBlock
---@field TextBlock UTextBlock
---@field bIsOn boolean
---@field SettingKey FString
local UWBP_SettingsRow_Toggle_C = {}

---@param NewValue boolean
function UWBP_SettingsRow_Toggle_C:SetIsOn(NewValue) end
function UWBP_SettingsRow_Toggle_C:Construct() end
function UWBP_SettingsRow_Toggle_C:BndEvt__WBP_SettingsRow_Toggle_btnOne_K2Node_ComponentBoundEvent_2_OnButtonPressedEvent__DelegateSignature() end
function UWBP_SettingsRow_Toggle_C:BndEvt__WBP_SettingsRow_Toggle_btnTwo_K2Node_ComponentBoundEvent_3_OnButtonPressedEvent__DelegateSignature() end
---@param EntryPoint int32
function UWBP_SettingsRow_Toggle_C:ExecuteUbergraph_WBP_SettingsRow_Toggle(EntryPoint) end


