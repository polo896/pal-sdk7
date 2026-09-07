---@meta

---@class UWBP_Altar_SelectItem_Button_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_NormalToFocus UWidgetAnimation
---@field Frame_Focus_Flare UImage
---@field Image_Button_Base UImage
---@field Image_Button_Dot UImage
---@field Image_Button_Dot_1 UImage
---@field Image_Button_Dot_2 UImage
---@field Image_Button_Dot_3 UImage
---@field Image_Button_Frame UImage
---@field Image_Button_Frame_1 UImage
---@field RichText_ItemInfo UBP_PalRichTextBlock_C
---@field Text_ItemNum UBP_PalTextBlock_C
---@field Text_StageName UBP_PalTextBlock_C
---@field WBP_PalInGameMenuItemIcon UWBP_PalInGameMenuItemIcon_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnClickSlot FWBP_Altar_SelectItem_Button_COnClickSlot
---@field OnHoveredSlot FWBP_Altar_SelectItem_Button_COnHoveredSlot
---@field OnUnhoveredSlot FWBP_Altar_SelectItem_Button_COnUnhoveredSlot
---@field Selected boolean
---@field TargetInfo FPalUIRaidBossStoneInfo
local UWBP_Altar_SelectItem_Button_C = {}

---@param Info FPalUIRaidBossStoneInfo
function UWBP_Altar_SelectItem_Button_C:Setup(Info) end
---@param Button UCommonButtonBase
function UWBP_Altar_SelectItem_Button_C:BndEvt__WBP_Altar_SelectItem_Button_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Altar_SelectItem_Button_C:BndEvt__WBP_Altar_SelectItem_Button_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Altar_SelectItem_Button_C:BndEvt__WBP_Altar_SelectItem_Button_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_Altar_SelectItem_Button_C:ExecuteUbergraph_WBP_Altar_SelectItem_Button(EntryPoint) end
---@param SelfSlot UWBP_Altar_SelectItem_Button_C
function UWBP_Altar_SelectItem_Button_C:OnUnhoveredSlot__DelegateSignature(SelfSlot) end
---@param SelfSlot UWBP_Altar_SelectItem_Button_C
function UWBP_Altar_SelectItem_Button_C:OnHoveredSlot__DelegateSignature(SelfSlot) end
---@param SelfSlot UWBP_Altar_SelectItem_Button_C
function UWBP_Altar_SelectItem_Button_C:OnClickSlot__DelegateSignature(SelfSlot) end


