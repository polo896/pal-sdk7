---@meta

---@class UWBP_Arena_TopMenuButton_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_NormalToFocus UWidgetAnimation
---@field Anm_FocusLoop UWidgetAnimation
---@field Canvas_Lock UCanvasPanel
---@field Image_Add UImage
---@field Image_Add_1 UImage
---@field Image_Button UImage
---@field Image_Button_Add UImage
---@field PalRetainerBox_117 UPalRetainerBox
---@field Text_ButtonName UBP_PalTextBlock_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnArenaButtonClicked FWBP_Arena_TopMenuButton_COnArenaButtonClicked
---@field isFocused boolean
---@field OnArenaButtonHovered FWBP_Arena_TopMenuButton_COnArenaButtonHovered
---@field OnArenaButtonUnhovered FWBP_Arena_TopMenuButton_COnArenaButtonUnhovered
---@field AnmTime double
---@field ['Is Lock'] boolean
local UWBP_Arena_TopMenuButton_C = {}

---@param Type int32
function UWBP_Arena_TopMenuButton_C:Setup(Type) end
---@param IsLock boolean
function UWBP_Arena_TopMenuButton_C:SetLock(IsLock) end
function UWBP_Arena_TopMenuButton_C:Finished_F552AADE467C2B4C78B4C5AEAA55800C() end
function UWBP_Arena_TopMenuButton_C:AnmEvent_Focus() end
function UWBP_Arena_TopMenuButton_C:AnmEvent_Normal() end
function UWBP_Arena_TopMenuButton_C:AnmEvent_NormalImmediate() end
function UWBP_Arena_TopMenuButton_C:Construct() end
---@param Button UCommonButtonBase
function UWBP_Arena_TopMenuButton_C:BndEvt__WBP_Arena_TopMenuButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Arena_TopMenuButton_C:BndEvt__WBP_Arena_TopMenuButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Arena_TopMenuButton_C:BndEvt__WBP_Arena_TopMenuButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_Arena_TopMenuButton_C:ExecuteUbergraph_WBP_Arena_TopMenuButton(EntryPoint) end
function UWBP_Arena_TopMenuButton_C:OnArenaButtonUnhovered__DelegateSignature() end
function UWBP_Arena_TopMenuButton_C:OnArenaButtonHovered__DelegateSignature() end
function UWBP_Arena_TopMenuButton_C:OnArenaButtonClicked__DelegateSignature() end


