---@meta

---@class UWBP_Common_Inventory_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Canvas_Inventory UCanvasPanel
---@field WBP_PalInvisibleButton_Sort_Inventory UWBP_PalInvisibleButton_C
---@field WBP_PalPlayerInventoryScrollList UWBP_PalPlayerInventoryScrollList_C
---@field WBP_PlayerInventoryWeightInfo UWBP_PlayerInventoryWeightInfo_C
---@field Model UBP_PalInventoryModel_C
---@field OnClickedInventorySortButton FWBP_Common_Inventory_COnClickedInventorySortButton
---@field OnHoveredInventorySlot FWBP_Common_Inventory_COnHoveredInventorySlot
---@field OnUnhoveredInventorySlot FWBP_Common_Inventory_COnUnhoveredInventorySlot
---@field OnLeftClickSlot FWBP_Common_Inventory_COnLeftClickSlot
---@field OnRightClickSlot FWBP_Common_Inventory_COnRightClickSlot
local UWBP_Common_Inventory_C = {}

---@param Widget UWidget
function UWBP_Common_Inventory_C:GetInventoryLastHoveredFocusTarget(Widget) end
---@param FocusTarget UWidget
function UWBP_Common_Inventory_C:GetInventoryTopFocustTarget(FocusTarget) end
---@param ButtonBase UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_Common_Inventory_C:OnLeftClickedTargetContainerSlot(ButtonBase, PressType) end
---@param Model UBP_PalInventoryModel_C
function UWBP_Common_Inventory_C:Setup(Model) end
---@param displayTypesB TArray<EPalItemTypeB>
function UWBP_Common_Inventory_C:FilteringInventoryByInventoryTypeB(displayTypesB) end
---@param displayTypesA TArray<EPalItemTypeA>
function UWBP_Common_Inventory_C:FilteringInventoryByInventoryTypeA(displayTypesA) end
---@param inventoryType TArray<EPalPlayerInventoryType>
function UWBP_Common_Inventory_C:FilteringInventoryByInventoryType(inventoryType) end
---@param Button UCommonButtonBase
function UWBP_Common_Inventory_C:BndEvt__WBP_IngameMenu_Chest_WBP_PalInvisibleButton_Sort_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param ButtonBase UWBP_PalItemSlotButtonBase_C
function UWBP_Common_Inventory_C:BndEvt__WBP_IngameMenu_Chest_WBP_PalPlayerInventoryScrollList_K2Node_ComponentBoundEvent_4_OnHoveredSlot__DelegateSignature(ButtonBase) end
---@param ButtonBase UWBP_PalItemSlotButtonBase_C
function UWBP_Common_Inventory_C:BndEvt__WBP_IngameMenu_Chest_WBP_PalPlayerInventoryScrollList_K2Node_ComponentBoundEvent_5_OnEndHoveredSlot__DelegateSignature(ButtonBase) end
---@param ButtonBase UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_Common_Inventory_C:BndEvt__WBP_Common_Inventory_WBP_PalPlayerInventoryScrollList_K2Node_ComponentBoundEvent_8_OnLeftClickedSlot__DelegateSignature(ButtonBase, PressType) end
---@param ButtonBase UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_Common_Inventory_C:BndEvt__WBP_Common_Inventory_WBP_PalPlayerInventoryScrollList_K2Node_ComponentBoundEvent_1_OnRightClickedSlot__DelegateSignature(ButtonBase, PressType) end
function UWBP_Common_Inventory_C:Destruct() end
---@param EntryPoint int32
function UWBP_Common_Inventory_C:ExecuteUbergraph_WBP_Common_Inventory(EntryPoint) end
---@param Slot UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_Common_Inventory_C:OnRightClickSlot__DelegateSignature(Slot, PressType) end
---@param Slot UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_Common_Inventory_C:OnLeftClickSlot__DelegateSignature(Slot, PressType) end
function UWBP_Common_Inventory_C:OnUnhoveredInventorySlot__DelegateSignature() end
---@param SlotButton UWBP_PalItemSlotButtonBase_C
function UWBP_Common_Inventory_C:OnHoveredInventorySlot__DelegateSignature(SlotButton) end
function UWBP_Common_Inventory_C:OnClickedInventorySortButton__DelegateSignature() end


