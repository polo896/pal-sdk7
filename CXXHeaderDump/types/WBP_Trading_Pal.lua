---@meta

---@class UWBP_Trading_Pal_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Canvas_Caution UCanvasPanel
---@field Canvas_SellList UCanvasPanel
---@field Canvas_SellSetting UCanvasPanel
---@field CheckBox_PrivateLock UCheckBox
---@field HorizontalBox_Lock_1 UHorizontalBox
---@field HorizontalBox_SellSetting_Head UHorizontalBox
---@field HorizontalBoxSellListHead_ UHorizontalBox
---@field Image_ItemSlot_Add UImage
---@field Image_PalSlot_Add UImage
---@field PalEditableTextBox_CostNum UPalEditableTextBox
---@field WBP_BoxPalList_Party UWBP_BoxPalList_Party_C
---@field WBP_CommonButton_Cancel UWBP_CommonButton_1_C
---@field WBP_CommonButton_Confirm UWBP_CommonButton_C
---@field WBP_IngameMenu_PalBox_PalDetail UWBP_IngameMenu_PalBox_PalDetail_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WBP_PalCommonCharacterSlotButton_Edit UWBP_PalCommonCharacterSlotButton_C
---@field WBP_PalInGameMenuItemSlotButton_Cost UWBP_PalInGameMenuItemSlotButton_C
---@field WBP_PalInvisibleButton_Lock UWBP_PalInvisibleButton_C
---@field WBP_PalInvisibleButton_Minus UWBP_PalInvisibleButton_C
---@field WBP_PalInvisibleButton_Plus UWBP_PalInvisibleButton_C
---@field WBP_Trading_Item_List UWBP_Trading_Item_List_C
---@field WBP_Trading_Item_List_1 UWBP_Trading_Item_List_C
---@field WBP_Trading_Item_List_2 UWBP_Trading_Item_List_C
---@field WBP_Trading_Item_List_3 UWBP_Trading_Item_List_C
---@field WBP_Trading_Item_List_4 UWBP_Trading_Item_List_C
---@field PalBoothModel UPalMapObjectPalBoothModel
---@field PartyPalSlots TArray<UWBP_PalCommonCharacterSlotButton_C>
---@field CachedLastHoveredSlot UWBP_PalCharacterSlotButtonBase_C
---@field ViewDetailInputHandle FPalUIActionBindData
---@field TradingList TArray<UWBP_Trading_Item_List_C>
---@field CurrentTradeInfo FPalPalBoothTradeInfo
---@field LastCostNum FText
---@field Confirmable boolean
---@field EditingIndex int32
---@field SelectingProduct boolean
---@field hoverdSlotType EPalBoxHoveredSlotType::Type
---@field LastHoveredTradePalHandle UPalIndividualCharacterHandle
---@field EnableEdit boolean
---@field FavoriteShortcutInput FPalDataTableRowName_UIInputAction
---@field FavoriteInputHandle FPalUIActionBindData
local UWBP_Trading_Pal_C = {}

---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_Trading_Pal_C:OnSlotUpdate(Slot) end
UWBP_Trading_Pal_C['On Favorite Shortcut'] = function(self, ) end
---@param Slot UPalIndividualCharacterSlot
---@param LastHandle UPalIndividualCharacterHandle
function UWBP_Trading_Pal_C:OnStoreSlotUpdate(Slot, LastHandle) end
UWBP_Trading_Pal_C['Update Sell List'] = function(self, ) end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_Trading_Pal_C:CustomNavigation_ToCancel(Navigation) end
function UWBP_Trading_Pal_C:ToPrevFocus() end
function UWBP_Trading_Pal_C:ToNextFocus() end
---@return UWidget
function UWBP_Trading_Pal_C:BP_GetDesiredFocusTarget() end
UWBP_Trading_Pal_C['Toggle Private Lock'] = function(self, ) end
---@param LockPlayerUId FGuid
function UWBP_Trading_Pal_C:OnPrivateLockChanged(LockPlayerUId) end
---@param StaticItemId FName
function UWBP_Trading_Pal_C:OnClickedCostSelectSlot(StaticItemId) end
---@param EnableBox boolean
---@param EnableParty boolean
UWBP_Trading_Pal_C['Enable Pal Select'] = function(self, EnableBox, EnableParty) end
function UWBP_Trading_Pal_C:OnCancelAction() end
function UWBP_Trading_Pal_C:ToSellListPanel() end
---@param NewNum int32
function UWBP_Trading_Pal_C:SetCostSettingNum(NewNum) end
UWBP_Trading_Pal_C['Validate Current Trade Info'] = function(self, ) end
---@param TradeIndex int32
function UWBP_Trading_Pal_C:OnTradeUnhovered(TradeIndex) end
---@param TradeIndex int32
function UWBP_Trading_Pal_C:OnTradeHovered(TradeIndex) end
---@param TradeIndex int32
function UWBP_Trading_Pal_C:OnClickedRemoveTradeButton(TradeIndex) end
---@param Index int32
function UWBP_Trading_Pal_C:OnTradeEdit(Index) end
function UWBP_Trading_Pal_C:ToSetSellPanel() end
---@param ToSellList boolean
UWBP_Trading_Pal_C['Switch Sell Panel'] = function(self, ToSellList) end
function UWBP_Trading_Pal_C:OnViewDetailInput() end
function UWBP_Trading_Pal_C:OnUnhoverPalSlot() end
---@param Slot UPalIndividualCharacterSlot
---@param UISlot UWBP_PalCharacterSlotButtonBase_C
UWBP_Trading_Pal_C['On Hover Pal Slot'] = function(self, Slot, UISlot) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_Trading_Pal_C:OnUnhoverPartyPalSlot(Slot) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_Trading_Pal_C:OnHoverPartyPalSlot(Slot) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_Trading_Pal_C:OnClickSlot(Slot, PressType) end
function UWBP_Trading_Pal_C:Setup() end
function UWBP_Trading_Pal_C:OnSetup() end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_Trading_Pal_C:BndEvt__WBP_Trading_Pal_WBP_BoxPalList_Party_K2Node_ComponentBoundEvent_0_OnHoverSlot__DelegateSignature(Slot) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_Trading_Pal_C:BndEvt__WBP_Trading_Pal_WBP_BoxPalList_Party_K2Node_ComponentBoundEvent_1_OnUnhoverSlot__DelegateSignature(Slot) end
function UWBP_Trading_Pal_C:Destruct() end
function UWBP_Trading_Pal_C:BndEvt__WBP_Trading_Pal_WBP_Menu_btn_K2Node_ComponentBoundEvent_2_OnButtonClicked__DelegateSignature() end
function UWBP_Trading_Pal_C:OnInitialized() end
---@param Text FText
function UWBP_Trading_Pal_C:BndEvt__WBP_Trading_Item_PalEditableTextBox_CostNum_K2Node_ComponentBoundEvent_12_OnEditableTextBoxChangedEvent__DelegateSignature(Text) end
---@param Text FText
---@param CommitMethod ETextCommit::Type
function UWBP_Trading_Pal_C:BndEvt__WBP_Trading_Item_PalEditableTextBox_CostNum_K2Node_ComponentBoundEvent_13_OnEditableTextBoxCommittedEvent__DelegateSignature(Text, CommitMethod) end
function UWBP_Trading_Pal_C:BndEvt__WBP_Trading_Pal_WBP_CommonButton_Cancel_K2Node_ComponentBoundEvent_3_OnClicked__DelegateSignature() end
---@param Widget UWBP_PalCharacterSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_Trading_Pal_C:BndEvt__WBP_Trading_Pal_WBP_PalCommonCharacterSlotButton_Edit_K2Node_ComponentBoundEvent_4_OnClickedButton__DelegateSignature(Widget, PressType) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_Trading_Pal_C:BndEvt__WBP_Trading_Pal_WBP_BoxPalList_Party_K2Node_ComponentBoundEvent_5_OnCreatedNewSlot__DelegateSignature(Slot) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_Trading_Pal_C:BndEvt__WBP_Trading_Pal_WBP_BoxPalList_Party_K2Node_ComponentBoundEvent_6_OnLeftClickedSlot__DelegateSignature(Slot, PressType) end
---@param Widget UWBP_PalCharacterSlotButtonBase_C
function UWBP_Trading_Pal_C:BndEvt__WBP_Trading_Pal_WBP_PalCommonCharacterSlotButton_Edit_K2Node_ComponentBoundEvent_7_OnHoveredButton__DelegateSignature(Widget) end
---@param Widget UWBP_PalCharacterSlotButtonBase_C
function UWBP_Trading_Pal_C:BndEvt__WBP_Trading_Pal_WBP_PalCommonCharacterSlotButton_Edit_K2Node_ComponentBoundEvent_8_OnUnhoveredButton__DelegateSignature(Widget) end
---@param Widget UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_Trading_Pal_C:BndEvt__WBP_Trading_Pal_WBP_PalInGameMenuItemSlotButton_Cost_K2Node_ComponentBoundEvent_9_OnClickedButton__DelegateSignature(Widget, PressType) end
---@param Button UCommonButtonBase
function UWBP_Trading_Pal_C:BndEvt__WBP_Trading_Pal_WBP_PalInvisibleButton_Plus_K2Node_ComponentBoundEvent_10_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Trading_Pal_C:BndEvt__WBP_Trading_Pal_WBP_PalInvisibleButton_Minus_K2Node_ComponentBoundEvent_11_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_Trading_Pal_C:BndEvt__WBP_Trading_Pal_WBP_CommonButton_Confirm_K2Node_ComponentBoundEvent_14_OnClicked__DelegateSignature() end
---@param Button UCommonButtonBase
function UWBP_Trading_Pal_C:BndEvt__WBP_Trading_Pal_WBP_PalInvisibleButton_Lock_K2Node_ComponentBoundEvent_15_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param IsDesignTime boolean
function UWBP_Trading_Pal_C:PreConstruct(IsDesignTime) end
---@param EntryPoint int32
function UWBP_Trading_Pal_C:ExecuteUbergraph_WBP_Trading_Pal(EntryPoint) end


