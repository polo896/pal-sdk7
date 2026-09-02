---@meta

---@class UWBP_ItemChest_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Default_In UWidgetAnimation
---@field CircularThrobber_69 UCircularThrobber
---@field Overlay_WaitRep UOverlay
---@field WBP_IngameMenu_Chest UWBP_IngameMenu_Chest_C
---@field WBP_PalCommonWindow UWBP_PalCommonWindow_C
---@field InventoryModel UBP_PalInventoryModel_C
---@field LeftFocusInput FPalDataTableRowName_UIInputAction
---@field RightFocusInput FPalDataTableRowName_UIInputAction
---@field FastGetInput FPalDataTableRowName_UIInputAction
---@field CachedLastFocusedInventorySlot UPalItemSlot
---@field CachedLastFocusedTargetContainerSlot UPalItemSlot
---@field AllGetInput FPalDataTableRowName_UIInputAction
---@field DisplayInventoryType TArray<EPalPlayerInventoryType>
---@field RefillInput FPalDataTableRowName_UIInputAction
---@field TargetContainerId FPalContainerId
---@field SortInput FPalDataTableRowName_UIInputAction
---@field ChestSettingInput FPalDataTableRowName_UIInputAction
local UWBP_ItemChest_C = {}

---@param Result boolean
function UWBP_ItemChest_C:IsEnableSortButton(Result) end
function UWBP_ItemChest_C:SetupSortButton() end
function UWBP_ItemChest_C:PlayItemMoveSound() end
function UWBP_ItemChest_C:RequestStopReplication() end
function UWBP_ItemChest_C:RequestStartReplication() end
---@param ConcreteModel UPalMapObjectItemChestModel
function UWBP_ItemChest_C:OnUpdatePrivateLockPlayerUId(ConcreteModel) end
function UWBP_ItemChest_C:Sort() end
function UWBP_ItemChest_C:Refill() end
---@return UWidget
function UWBP_ItemChest_C:BP_GetDesiredFocusTarget() end
function UWBP_ItemChest_C:AllGet() end
function UWBP_ItemChest_C:FastMove() end
function UWBP_ItemChest_C:Setup() end
function UWBP_ItemChest_C:OnSetup() end
function UWBP_ItemChest_C:Construct() end
function UWBP_ItemChest_C:ChangeFocus_Inv_Pad() end
function UWBP_ItemChest_C:ChangeFocus_Chest_Pad() end
function UWBP_ItemChest_C:BndEvt__WBP_ItemChest_WBP_IngameMenu_Chest_K2Node_ComponentBoundEvent_3_OnClickedQuickMoveButton__DelegateSignature() end
function UWBP_ItemChest_C:BndEvt__WBP_ItemChest_WBP_IngameMenu_Chest_K2Node_ComponentBoundEvent_8_OnClickedInventorySortButton__DelegateSignature() end
---@param SlotButton UWBP_PalItemSlotButtonBase_C
function UWBP_ItemChest_C:BndEvt__WBP_ItemChest_WBP_IngameMenu_Chest_K2Node_ComponentBoundEvent_9_OnHoveredInventorySlot__DelegateSignature(SlotButton) end
function UWBP_ItemChest_C:BndEvt__WBP_ItemChest_WBP_IngameMenu_Chest_K2Node_ComponentBoundEvent_12_OnClickedTargetContainerSortButton__DelegateSignature() end
function UWBP_ItemChest_C:BndEvt__WBP_ItemChest_WBP_IngameMenu_Chest_K2Node_ComponentBoundEvent_13_OnUnhoveredInventorySlot__DelegateSignature() end
---@param SlotButton UWBP_PalItemSlotButtonBase_C
function UWBP_ItemChest_C:BndEvt__WBP_ItemChest_WBP_IngameMenu_Chest_K2Node_ComponentBoundEvent_14_OnHoveredTargetContainerSlot__DelegateSignature(SlotButton) end
function UWBP_ItemChest_C:BndEvt__WBP_ItemChest_WBP_IngameMenu_Chest_K2Node_ComponentBoundEvent_15_OnUnhoveredTargetContainerSlot__DelegateSignature() end
function UWBP_ItemChest_C:BndEvt__WBP_ItemChest_WBP_IngameMenu_Chest_K2Node_ComponentBoundEvent_16_OnClickedCloseButton__DelegateSignature() end
function UWBP_ItemChest_C:OnClose() end
---@param AccessInterface TScriptInterface<IPalMapObjectItemContainerAccessInterface>
function UWBP_ItemChest_C:OnReadyItemContainer(AccessInterface) end
function UWBP_ItemChest_C:Destruct() end
function UWBP_ItemChest_C:BndEvt__WBP_ItemChest_WBP_IngameMenu_Chest_K2Node_ComponentBoundEvent_0_OnClickFilterSettingButton__DelegateSignature() end
function UWBP_ItemChest_C:OpenChestSetting() end
---@param EntryPoint int32
function UWBP_ItemChest_C:ExecuteUbergraph_WBP_ItemChest(EntryPoint) end


