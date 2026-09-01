---@meta

---@class UWBP_SelectItemInventory_C : UPalUISelectItemInventoryBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_Common_Inventory UWBP_Common_Inventory_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field isRequireSelectNum boolean
---@field selectedButton UWBP_PalItemSlotButtonBase_C
---@field InventoryModel UBP_PalInventoryModel_C
---@field BgMsgID FDataTableRowHandle
local UWBP_SelectItemInventory_C = {}

---@param SlotButton UWBP_PalItemSlotButtonBase_C
function UWBP_SelectItemInventory_C:OnUpdatedSlot(SlotButton) end
---@param TargetCharacter APalCharacter
function UWBP_SelectItemInventory_C:BindUsabilityGrayout(TargetCharacter) end
---@param TargetCharacter APalCharacter
---@param SlotButton UWBP_PalItemSlotButtonBase_C
function UWBP_SelectItemInventory_C:ApplyUsabilityGrayout(TargetCharacter, SlotButton) end
---@param TargetCharacter APalCharacter
function UWBP_SelectItemInventory_C:ApplyUsabilityGrayoutAll(TargetCharacter) end
---@param TargetCharacter APalCharacter
function UWBP_SelectItemInventory_C:GetTargetCharacter(TargetCharacter) end
---@return UWidget
function UWBP_SelectItemInventory_C:BP_GetDesiredFocusTarget() end
---@param ButtonBase UWBP_PalItemSlotButtonBase_C
function UWBP_SelectItemInventory_C:OnFocusedSlot(ButtonBase) end
---@param SlotId FPalItemSlotId
---@param selectNum int32
function UWBP_SelectItemInventory_C:ComplateSelect(SlotId, selectNum) end
---@param resultType EPalUISelectNumResult
---@param selectedNum int64
function UWBP_SelectItemInventory_C:OnComplateSelectNum(resultType, selectedNum) end
function UWBP_SelectItemInventory_C:DisplaySelectNumWidget() end
---@param ButtonBase UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_SelectItemInventory_C:OnLeftClicked(ButtonBase, PressType) end
function UWBP_SelectItemInventory_C:OnSetup() end
function UWBP_SelectItemInventory_C:BndEvt__WBP_SelectItemInventory_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
function UWBP_SelectItemInventory_C:Destruct() end
---@param Slot UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_SelectItemInventory_C:BndEvt__WBP_SelectItemInventory_WBP_Common_Inventory_K2Node_ComponentBoundEvent_2_OnLeftClickSlot__DelegateSignature(Slot, PressType) end
---@param EntryPoint int32
function UWBP_SelectItemInventory_C:ExecuteUbergraph_WBP_SelectItemInventory(EntryPoint) end


