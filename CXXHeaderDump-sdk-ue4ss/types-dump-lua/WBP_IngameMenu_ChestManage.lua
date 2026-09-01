---@meta

---@class UWBP_IngameMenu_ChestManage_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Canvas_TargetContainer UCanvasPanel
---@field WBP_Common_Inventory UWBP_Common_Inventory_C
---@field WBP_IngameMenu_ChestManage_TakeOut UWBP_IngameMenu_ChestManage_TakeOut_C
---@field WBP_IngameMenu_ItemSearchList UWBP_IngameMenu_ItemSearchList_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field InventoryModel UBP_PalInventoryModel_C
---@field OnClickedQuickMoveButton FWBP_IngameMenu_ChestManage_COnClickedQuickMoveButton
---@field OnClickedPreferenceButton FWBP_IngameMenu_ChestManage_COnClickedPreferenceButton
---@field DispenserModel UPalUIBaseCampItemDispenserModel
---@field TakeOutPanelEnabled boolean
---@field TakeOutBindedActions TArray<FPalUIActionBindData>
---@field LastFocusListSlot boolean
---@field Updateable boolean
---@field UpdateableTimer FTimerHandle
---@field CurrentInFocusPath boolean
---@field ForceReset boolean
---@field FillableSlotIds TArray<FPalItemSlotId>
local UWBP_IngameMenu_ChestManage_C = {}

---@param ItemAndNum FPalItemAndNum
---@param Num int64
function UWBP_IngameMenu_ChestManage_C:GetItemCount64InBaseCamp(ItemAndNum, Num) end
function UWBP_IngameMenu_ChestManage_C:FocusToFilterButton() end
---@param Slot UWBP_PalItemSlotButtonBase_C
---@param ItemList TArray<FName>
function UWBP_IngameMenu_ChestManage_C:UpdateInventorySlot(Slot, ItemList) end
function UWBP_IngameMenu_ChestManage_C:Refill() end
function UWBP_IngameMenu_ChestManage_C:EnableUpdate() end
function UWBP_IngameMenu_ChestManage_C:Unbind() end
---@param TryFocusItemList boolean
UWBP_IngameMenu_ChestManage_C['Reset Focus'] = function(self, TryFocusItemList) end
---@param Slot UPalItemSlot
function UWBP_IngameMenu_ChestManage_C:UpdateInventoryGreyout(Slot) end
---@param InputType ECommonInputType
function UWBP_IngameMenu_ChestManage_C:InputMethodChanged(InputType) end
function UWBP_IngameMenu_ChestManage_C:OnTakeOutClose() end
---@return UWidget
function UWBP_IngameMenu_ChestManage_C:BP_GetDesiredFocusTarget() end
---@param Model UPalUIBaseCampItemDispenserModel
UWBP_IngameMenu_ChestManage_C['On Camp Item Stack Info Update'] = function(self, Model) end
function UWBP_IngameMenu_ChestManage_C:OnCancelAction() end
---@param Widget UWidget
function UWBP_IngameMenu_ChestManage_C:GetInventoryLastHoveredFocusTarget(Widget) end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_IngameMenu_ChestManage_C:CustomNavi_ToInventorySlot(Navigation) end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_IngameMenu_ChestManage_C:CustomNavi_ToCloseButton(Navigation) end
---@param FocusTarget UWidget
function UWBP_IngameMenu_ChestManage_C:GetInventoryTopFocustTarget(FocusTarget) end
---@param InventoryModel UBP_PalInventoryModel_C
---@param DispenserModel UPalUIBaseCampItemDispenserModel
function UWBP_IngameMenu_ChestManage_C:Setup(InventoryModel, DispenserModel) end
function UWBP_IngameMenu_ChestManage_C:Construct() end
function UWBP_IngameMenu_ChestManage_C:BndEvt__WBP_IngameMenu_Chest_WBP_Menu_btn_K2Node_ComponentBoundEvent_7_OnButtonClicked__DelegateSignature() end
function UWBP_IngameMenu_ChestManage_C:BndEvt__WBP_IngameMenu_ChestManage_WBP_Common_Inventory_K2Node_ComponentBoundEvent_12_OnClickedInventorySortButton__DelegateSignature() end
function UWBP_IngameMenu_ChestManage_C:OnSetup() end
function UWBP_IngameMenu_ChestManage_C:OnClose() end
---@param Slot UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_IngameMenu_ChestManage_C:BndEvt__WBP_IngameMenu_ChestManage_WBP_Common_Inventory_K2Node_ComponentBoundEvent_0_OnRightClickSlot__DelegateSignature(Slot, PressType) end
---@param Slot UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_IngameMenu_ChestManage_C:BndEvt__WBP_IngameMenu_ChestManage_WBP_IngameMenu_ItemSearchList_K2Node_ComponentBoundEvent_1_OnRightClickSlot__DelegateSignature(Slot, PressType) end
function UWBP_IngameMenu_ChestManage_C:BndEvt__WBP_IngameMenu_ChestManage_WBP_IngameMenu_ChestManage_TakeOut_K2Node_ComponentBoundEvent_2_OnTakeOutClosed__DelegateSignature() end
---@param TakeOutId FPalItemId
---@param TakeOutCount int64
function UWBP_IngameMenu_ChestManage_C:BndEvt__WBP_IngameMenu_ChestManage_WBP_IngameMenu_ChestManage_TakeOut_K2Node_ComponentBoundEvent_3_OnTakeOutConfirmed__DelegateSignature(TakeOutId, TakeOutCount) end
function UWBP_IngameMenu_ChestManage_C:Destruct() end
---@param SlotButton UWBP_PalItemSlotButtonBase_C
function UWBP_IngameMenu_ChestManage_C:BndEvt__WBP_IngameMenu_ChestManage_WBP_Common_Inventory_K2Node_ComponentBoundEvent_5_OnHoveredInventorySlot__DelegateSignature(SlotButton) end
function UWBP_IngameMenu_ChestManage_C:BndEvt__WBP_IngameMenu_ChestManage_WBP_IngameMenu_ItemSearchList_K2Node_ComponentBoundEvent_6_OnSlotHovered__DelegateSignature() end
---@param InFocusEvent FFocusEvent
function UWBP_IngameMenu_ChestManage_C:OnAddedToFocusPath(InFocusEvent) end
---@param InFocusEvent FFocusEvent
function UWBP_IngameMenu_ChestManage_C:OnRemovedFromFocusPath(InFocusEvent) end
---@param ItemAndNum FPalItemAndNum
UWBP_IngameMenu_ChestManage_C['Setup Take Out'] = function(self, ItemAndNum) end
---@param EntryPoint int32
function UWBP_IngameMenu_ChestManage_C:ExecuteUbergraph_WBP_IngameMenu_ChestManage(EntryPoint) end
function UWBP_IngameMenu_ChestManage_C:OnClickedPreferenceButton__DelegateSignature() end
function UWBP_IngameMenu_ChestManage_C:OnClickedQuickMoveButton__DelegateSignature() end


