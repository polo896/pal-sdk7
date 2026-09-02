---@meta

---@class UWBP_Trading_Item_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Canvas_Caution UCanvasPanel
---@field Canvas_InventoryStorage UCanvasPanel
---@field Canvas_Sell UCanvasPanel
---@field Canvas_SellList UCanvasPanel
---@field Canvas_SellSetting UCanvasPanel
---@field CheckBox UCheckBox
---@field HorizontalBox_ItemStocknum UHorizontalBox
---@field Image_ItemSlot_Add_Cost UImage
---@field Image_ItemSlot_Add_Product UImage
---@field Image_StoreHover UImage
---@field PalEditableTextBox_CostNum UPalEditableTextBox
---@field PalEditableTextBox_ProductNum UPalEditableTextBox
---@field Text_ItemStockNum UBP_PalTextBlock_C
---@field Text_StoreManage UBP_PalTextBlock_C
---@field WBP_CommonButton_Cancel UWBP_CommonButton_1_C
---@field WBP_CommonButton_Confirm UWBP_CommonButton_C
---@field WBP_IngameMenu_Chest UWBP_IngameMenu_Chest_C
---@field WBP_ItemInfo_ForItemBooth UWBP_ItemInfo_ForItemBooth_C
---@field WBP_ItemSlot_Cost UWBP_PalInGameMenuItemSlotButton_C
---@field WBP_ItemSlot_Product UWBP_PalInGameMenuItemSlotButton_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WBP_PalInvisibleButton_Lock_CheckBox UWBP_PalInvisibleButton_C
---@field WBP_PalInvisibleButton_Minus UWBP_PalInvisibleButton_C
---@field WBP_PalInvisibleButton_Minus_1 UWBP_PalInvisibleButton_C
---@field WBP_PalInvisibleButton_Plus UWBP_PalInvisibleButton_C
---@field WBP_PalInvisibleButton_Plus_1 UWBP_PalInvisibleButton_C
---@field WBP_PalInvisibleButton_Sort_TargetContainer UWBP_PalInvisibleButton_C
---@field WBP_PalItemScrollList UWBP_PalItemScrollList_C
---@field WBP_Trading_Item_List UWBP_Trading_Item_List_C
---@field WBP_Trading_Item_List_1 UWBP_Trading_Item_List_C
---@field WBP_Trading_Item_List_2 UWBP_Trading_Item_List_C
---@field WBP_Trading_Item_List_3 UWBP_Trading_Item_List_C
---@field WBP_Trading_Item_List_4 UWBP_Trading_Item_List_C
---@field ItemBoothModel UPalMapObjectItemBoothModel
---@field InventoryModel UBP_PalInventoryModel_C
---@field TradingList TArray<UWBP_Trading_Item_List_C>
---@field Confirmable boolean
---@field CurrentTradeInfo FPalItemBoothTradeInfo
---@field LastProductNum FText
---@field LastCostNum FText
---@field StoreContainerActionBindings TArray<FPalUIActionBindData>
---@field LastFocusInInventory boolean
---@field EditingIndex int32
---@field SelectingProduct boolean
---@field DelayUnhoverTimer FTimerHandle
local UWBP_Trading_Item_C = {}

---@param Widget UWBP_PalItemSlotButtonBase_C
function UWBP_Trading_Item_C:OnStoreSlotUnhovered(Widget) end
---@param IsHover boolean
function UWBP_Trading_Item_C:SwitchSlotPanelHoverDisplay(IsHover) end
---@param Widget UWBP_PalItemSlotButtonBase_C
function UWBP_Trading_Item_C:OnStoreSlotHovered(Widget) end
---@param Index int32
function UWBP_Trading_Item_C:OnTradeEdit(Index) end
function UWBP_Trading_Item_C:Sort() end
function UWBP_Trading_Item_C:Refill() end
function UWBP_Trading_Item_C:AllGet() end
function UWBP_Trading_Item_C:FocusRight() end
function UWBP_Trading_Item_C:FocusLeft() end
---@param TradeIndex int32
function UWBP_Trading_Item_C:OnTradeUnhovered(TradeIndex) end
---@param TradeIndex int32
function UWBP_Trading_Item_C:OnTradeHovered(TradeIndex) end
---@param LockPlayerUId FGuid
function UWBP_Trading_Item_C:OnPrivateLockChanged(LockPlayerUId) end
UWBP_Trading_Item_C['Toggle Private Lock'] = function(self, ) end
function UWBP_Trading_Item_C:FocusToStoreManage() end
---@param Visible boolean
function UWBP_Trading_Item_C:SwitchStoragePanelVisibility(Visible) end
---@return UWidget
function UWBP_Trading_Item_C:BP_GetDesiredFocusTarget() end
---@param TradeIndex int32
function UWBP_Trading_Item_C:OnClickedRemoveTradeButton(TradeIndex) end
---@param ItemContainer UPalItemContainer
UWBP_Trading_Item_C['On Store Content Updated'] = function(self, ItemContainer) end
UWBP_Trading_Item_C['Update Sell List'] = function(self, ) end
---@param NewNum int32
function UWBP_Trading_Item_C:SetCostSettingNum(NewNum) end
function UWBP_Trading_Item_C:ValidateCurrentTradeInfo() end
---@param StaticItemId FName
function UWBP_Trading_Item_C:OnClickedCostSelectSlot(StaticItemId) end
---@param NewNum int32
function UWBP_Trading_Item_C:SetProductSettingNum(NewNum) end
---@param Slot UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_Trading_Item_C:OnClickedAnyProductSlot(Slot, PressType) end
UWBP_Trading_Item_C['Enable Cost Select'] = function(self, ) end
---@param Enable boolean
UWBP_Trading_Item_C['Enable Product Select'] = function(self, Enable) end
function UWBP_Trading_Item_C:ToSellListPanel() end
function UWBP_Trading_Item_C:ToSetSellPanel() end
---@param ToSellList boolean
function UWBP_Trading_Item_C:SwitchSellPanel(ToSellList) end
function UWBP_Trading_Item_C:Setup() end
function UWBP_Trading_Item_C:OnCancelAction() end
function UWBP_Trading_Item_C:OnSetup() end
function UWBP_Trading_Item_C:Construct() end
---@param Button UCommonButtonBase
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_WBP_PalInvisibleButton_Sort_TargetContainer_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_Trading_Item_C:OnInitialized() end
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_WBP_CommonButton_Cancel_K2Node_ComponentBoundEvent_3_OnClicked__DelegateSignature() end
---@param Widget UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_WBP_ItemSlot_Product_K2Node_ComponentBoundEvent_2_OnClickedButton__DelegateSignature(Widget, PressType) end
---@param Widget UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_WBP_ItemSlot_Cost_K2Node_ComponentBoundEvent_5_OnClickedButton__DelegateSignature(Widget, PressType) end
---@param Button UCommonButtonBase
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_WBP_PalInvisibleButton_Plus_K2Node_ComponentBoundEvent_6_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_WBP_PalInvisibleButton_Minus_K2Node_ComponentBoundEvent_7_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Text FText
---@param CommitMethod ETextCommit::Type
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_PalEditableTextBox_ProductNum_K2Node_ComponentBoundEvent_8_OnEditableTextBoxCommittedEvent__DelegateSignature(Text, CommitMethod) end
---@param Text FText
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_PalEditableTextBox_ProductNum_K2Node_ComponentBoundEvent_9_OnEditableTextBoxChangedEvent__DelegateSignature(Text) end
---@param Button UCommonButtonBase
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_WBP_PalInvisibleButton_Minus_1_K2Node_ComponentBoundEvent_10_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_WBP_PalInvisibleButton_Plus_1_K2Node_ComponentBoundEvent_11_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Text FText
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_PalEditableTextBox_CostNum_K2Node_ComponentBoundEvent_12_OnEditableTextBoxChangedEvent__DelegateSignature(Text) end
---@param Text FText
---@param CommitMethod ETextCommit::Type
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_PalEditableTextBox_CostNum_K2Node_ComponentBoundEvent_13_OnEditableTextBoxCommittedEvent__DelegateSignature(Text, CommitMethod) end
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_WBP_IngameMenu_Chest_K2Node_ComponentBoundEvent_6_OnClickedInventorySortButton__DelegateSignature() end
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_WBP_IngameMenu_Chest_K2Node_ComponentBoundEvent_7_OnClickedQuickMoveButton__DelegateSignature() end
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_WBP_IngameMenu_Chest_K2Node_ComponentBoundEvent_16_OnClickedTargetContainerSortButton__DelegateSignature() end
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_WBP_IngameMenu_Chest_K2Node_ComponentBoundEvent_17_OnClickedCloseButton__DelegateSignature() end
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_WBP_Menu_btn_K2Node_ComponentBoundEvent_18_OnButtonClicked__DelegateSignature() end
---@param Button UCommonButtonBase
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_WBP_PalInvisibleButton_Lock_CheckBox_K2Node_ComponentBoundEvent_19_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param SlotButton UWBP_PalItemSlotButtonBase_C
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_WBP_IngameMenu_Chest_K2Node_ComponentBoundEvent_20_OnHoveredInventorySlot__DelegateSignature(SlotButton) end
---@param SlotButton UWBP_PalItemSlotButtonBase_C
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_WBP_IngameMenu_Chest_K2Node_ComponentBoundEvent_21_OnHoveredTargetContainerSlot__DelegateSignature(SlotButton) end
function UWBP_Trading_Item_C:BndEvt__WBP_Trading_Item_WBP_CommonButton__K2Node_ComponentBoundEvent_0_OnClicked__DelegateSignature() end
function UWBP_Trading_Item_C:DelayUnhoverStorePanel() end
function UWBP_Trading_Item_C:Destruct() end
---@param EntryPoint int32
function UWBP_Trading_Item_C:ExecuteUbergraph_WBP_Trading_Item(EntryPoint) end


