---@meta

---@class UWBP_MinimapSettingsButton_C : UPalActivatableWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field OpenSettingsButton UButton
---@field TextBlock UTextBlock
---@field ActiveSettingsWidget UWBT_MinimapSettings_C
local UWBP_MinimapSettingsButton_C = {}

function UWBP_MinimapSettingsButton_C:Construct() end
function UWBP_MinimapSettingsButton_C:BndEvt__WBP_MinimapSettingsButton_OpenSettingsButton_K2Node_ComponentBoundEvent_1_OnButtonPressedEvent__DelegateSignature() end
---@param EntryPoint int32
function UWBP_MinimapSettingsButton_C:ExecuteUbergraph_WBP_MinimapSettingsButton(EntryPoint) end


