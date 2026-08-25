---@meta

---@class UWBP_Title_MenuButton_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Disable UWidgetAnimation
---@field Anm_push UWidgetAnimation
---@field Anm_focus UWidgetAnimation
---@field Anm_normal UWidgetAnimation
---@field Image_161 UImage
---@field Image_Icon_Appeal UImage
---@field SizeBox_Icon USizeBox
---@field Test_Content UBP_PalTextBlock_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnClicked FWBP_Title_MenuButton_COnClicked
---@field buttonType E_PalUITitleMenuButtonType::Type
---@field MsgIDMap TMap<E_PalUITitleMenuButtonType::Type, FDataTableRowHandle>
local UWBP_Title_MenuButton_C = {}

---@param bEnableAttention boolean
function UWBP_Title_MenuButton_C:SetAttention(bEnableAttention) end
---@param BindedMenuType E_PalUITitleMenuButtonType::Type
function UWBP_Title_MenuButton_C:GetMenuType(BindedMenuType) end
---@param Button UCommonButtonBase
function UWBP_Title_MenuButton_C:BndEvt__WBP_Title_MenuButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Title_MenuButton_C:BndEvt__WBP_Title_MenuButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Title_MenuButton_C:BndEvt__WBP_Title_MenuButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_Title_MenuButton_C:OnInitialized() end
---@param IsDesignTime boolean
function UWBP_Title_MenuButton_C:PreConstruct(IsDesignTime) end
---@param EntryPoint int32
function UWBP_Title_MenuButton_C:ExecuteUbergraph_WBP_Title_MenuButton(EntryPoint) end
function UWBP_Title_MenuButton_C:OnClicked__DelegateSignature() end


