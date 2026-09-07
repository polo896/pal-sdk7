---@meta

---@class UWBP_Arena_RuleSetting_PalListButton_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_AllowToBan UWidgetAnimation
---@field Anm_NormalToFocus UWidgetAnimation
---@field CanvasPanel_PalIcon UCanvasPanel
---@field Image_Unknown UImage
---@field Text_PalName UBP_PalTextBlock_C
---@field WBP_PalCommonCharacterIcon UWBP_PalCommonCharacterIcon_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnButtonClicked FWBP_Arena_RuleSetting_PalListButton_COnButtonClicked
---@field ['Character Id'] FName
---@field CurrentHidding boolean
local UWBP_Arena_RuleSetting_PalListButton_C = {}

---@param ShouldHide boolean
function UWBP_Arena_RuleSetting_PalListButton_C:SetHide(ShouldHide) end
---@param CharacterID FName
function UWBP_Arena_RuleSetting_PalListButton_C:Setup(CharacterID) end
function UWBP_Arena_RuleSetting_PalListButton_C:AnmEvent_Focus() end
function UWBP_Arena_RuleSetting_PalListButton_C:AnmEvent_NoFocus() end
function UWBP_Arena_RuleSetting_PalListButton_C:AnmEvent_Enable() end
function UWBP_Arena_RuleSetting_PalListButton_C:AnmEvent_Ban() end
function UWBP_Arena_RuleSetting_PalListButton_C:Construct() end
---@param Button UCommonButtonBase
function UWBP_Arena_RuleSetting_PalListButton_C:BndEvt__WBP_Arena_RuleSetting_PalListButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Arena_RuleSetting_PalListButton_C:BndEvt__WBP_Arena_RuleSetting_PalListButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Arena_RuleSetting_PalListButton_C:BndEvt__WBP_Arena_RuleSetting_PalListButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_Arena_RuleSetting_PalListButton_C:ExecuteUbergraph_WBP_Arena_RuleSetting_PalListButton(EntryPoint) end
---@param CharacterID FName
function UWBP_Arena_RuleSetting_PalListButton_C:OnButtonClicked__DelegateSignature(CharacterID) end


