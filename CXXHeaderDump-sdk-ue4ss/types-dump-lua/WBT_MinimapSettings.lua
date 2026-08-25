---@meta

---@class UWBT_MinimapSettings_C : UPalActivatableWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field btnCancel UButton
---@field btnReset UButton
---@field btnSave UButton
---@field MinimapSettingsHeader UTextBlock
---@field ScrollBox UScrollBox
---@field TextBlock_1 UTextBlock
---@field TextBlock_127 UTextBlock
---@field TextBlock_313 UTextBlock
---@field VerticalBox UVerticalBox
---@field MyModActor UObject
---@field ModActorRef AModActor_C
local UWBT_MinimapSettings_C = {}

function UWBT_MinimapSettings_C:ResetSettingsRows() end
function UWBT_MinimapSettings_C:SaveSettingsRows() end
function UWBT_MinimapSettings_C:BuildSettingsRows() end
---@param Row UWBP_SettingsRow_Keybind_C
---@param ActionName FName
---@param Output FInputActionKeyMapping
function UWBT_MinimapSettings_C:BuildKeyMapping(Row, ActionName, Output) end
---@param Label FText
---@param Output UWBP_SettingsRow_Header_C
function UWBT_MinimapSettings_C:CreateHeaderRow(Label, Output) end
---@param Label FText
---@param Description FText
---@param InSelectedKey FInputChord
---@param Output UWBP_SettingsRow_Keybind_C
UWBT_MinimapSettings_C['Create Keybind Row'] = function(self, Label, Description, InSelectedKey, Output) end
---@param Reference FText
---@param Description FText
---@param MinValue float
---@param MaxValue float
---@param Value float
---@param Step_Size float
---@param Output UWBP_SettingsRow_Slider_C
function UWBT_MinimapSettings_C:CreateSliderRow(Reference, Description, MinValue, MaxValue, Value, Step_Size, Output) end
---@param Label FText
---@param Description FText
---@param bIsOn boolean
---@param Output UWBP_SettingsRow_Toggle_C
function UWBT_MinimapSettings_C:CreateToggleRow(Label, Description, bIsOn, Output) end
---@param Message FString
function UWBT_MinimapSettings_C:PrintToModLoader(Message) end
function UWBT_MinimapSettings_C:Construct() end
function UWBT_MinimapSettings_C:BndEvt__WBP_MinimapSettings_btnCancel_K2Node_ComponentBoundEvent_1_OnButtonPressedEvent__DelegateSignature() end
function UWBT_MinimapSettings_C:BndEvt__WBP_MinimapSettings_btnSave_K2Node_ComponentBoundEvent_2_OnButtonPressedEvent__DelegateSignature() end
function UWBT_MinimapSettings_C:BndEvt__WBT_MinimapSettings_btnReset_K2Node_ComponentBoundEvent_0_OnButtonPressedEvent__DelegateSignature() end
---@param EntryPoint int32
function UWBT_MinimapSettings_C:ExecuteUbergraph_WBT_MinimapSettings(EntryPoint) end


