---@meta

---@class UWBP_SkillFruitFarm_C : UPalUISkillFruitFarm
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Default_In UWidgetAnimation
---@field CheckBox_Transport UCheckBox
---@field HorizontalBox_ProductSlot UHorizontalBox
---@field HorizontalBox_TransportCheckBox UHorizontalBox
---@field Overlay_WaitRep UOverlay
---@field Text_FilterContent UBP_PalTextBlock_C
---@field Text_TargetContainerName UBP_PalTextBlock_C
---@field WBP_Common_Inventory UWBP_Common_Inventory_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WBP_PalCommonWindow UWBP_PalCommonWindow_C
---@field WBP_PalInGameMenuItemSlotButton_FruitSlot UWBP_PalInGameMenuItemSlotButton_C
---@field WBP_PalInvisibleButton_QuickMove UWBP_PalInvisibleButton_C
---@field WBP_PalInvisibleButton_TransportCheck UWBP_PalInvisibleButton_C
---@field InventoryModel UBP_PalInventoryModel_C
---@field LeftFocusInput FPalDataTableRowName_UIInputAction
---@field RightFocusInput FPalDataTableRowName_UIInputAction
local UWBP_SkillFruitFarm_C = {}

---@param Navigation EUINavigation
---@return UWidget
function UWBP_SkillFruitFarm_C:CustomNavi_ToFruitSlot(Navigation) end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_SkillFruitFarm_C:CustomNavi_ToCloseButton(Navigation) end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_SkillFruitFarm_C:CustomNavi_ToGetAllButton(Navigation) end
---@param ButtonBase UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_SkillFruitFarm_C:OnRightClickedProductSlot(ButtonBase, PressType) end
---@param Widget UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_SkillFruitFarm_C:OnClickedProductSlot(Widget, PressType) end
function UWBP_SkillFruitFarm_C:RequestStopReplication() end
function UWBP_SkillFruitFarm_C:RequestStartReplication() end
---@return UWidget
function UWBP_SkillFruitFarm_C:BP_GetDesiredFocusTarget() end
function UWBP_SkillFruitFarm_C:Setup() end
function UWBP_SkillFruitFarm_C:OnSetup() end
function UWBP_SkillFruitFarm_C:Construct() end
function UWBP_SkillFruitFarm_C:ChangeFocus_Inv_Pad() end
function UWBP_SkillFruitFarm_C:ChangeFocus_Chest_Pad() end
function UWBP_SkillFruitFarm_C:OnClose() end
---@param AccessInterface TScriptInterface<IPalMapObjectItemContainerAccessInterface>
function UWBP_SkillFruitFarm_C:OnReadyItemContainer(AccessInterface) end
function UWBP_SkillFruitFarm_C:Destruct() end
function UWBP_SkillFruitFarm_C:BndEvt__WBP_SkillFruitFarm_WBP_Common_Inventory_K2Node_ComponentBoundEvent_0_OnClickedInventorySortButton__DelegateSignature() end
---@param Slot UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_SkillFruitFarm_C:BndEvt__WBP_SkillFruitFarm_WBP_Common_Inventory_K2Node_ComponentBoundEvent_1_OnRightClickSlot__DelegateSignature(Slot, PressType) end
---@param Button UCommonButtonBase
function UWBP_SkillFruitFarm_C:BndEvt__WBP_SkillFruitFarm_WBP_PalInvisibleButton_QuickMove_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_SkillFruitFarm_C:BndEvt__WBP_SkillFruitFarm_WBP_Menu_btn_K2Node_ComponentBoundEvent_4_OnButtonClicked__DelegateSignature() end
---@param Widget UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_SkillFruitFarm_C:BndEvt__WBP_SkillFruitFarm_WBP_PalInGameMenuItemSlotButton_FruitSlot_K2Node_ComponentBoundEvent_6_OnClickedButton__DelegateSignature(Widget, PressType) end
---@param ButtonBase UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_SkillFruitFarm_C:BndEvt__WBP_SkillFruitFarm_WBP_PalInGameMenuItemSlotButton_FruitSlot_K2Node_ComponentBoundEvent_7_OnRightClickedButton__DelegateSignature(ButtonBase, PressType) end
---@param Button UCommonButtonBase
function UWBP_SkillFruitFarm_C:BndEvt__WBP_SkillFruitFarm_WBP_PalInvisibleButton_TransportCheck_K2Node_ComponentBoundEvent_8_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_SkillFruitFarm_C:ExecuteUbergraph_WBP_SkillFruitFarm(EntryPoint) end


