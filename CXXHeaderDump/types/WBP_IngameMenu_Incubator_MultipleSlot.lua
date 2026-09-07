---@meta

---@class UWBP_IngameMenu_Incubator_MultipleSlot_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_PalTextBlock_EggName UBP_PalTextBlock_C
---@field BP_PalTextBlock_Empty UBP_PalTextBlock_C
---@field Canvas_EggSeted UCanvasPanel
---@field Overlay_Complete UOverlay
---@field ProgressBar UProgressBar
---@field Text_Timer UBP_PalTextBlock_C
---@field WBP_PalInGameMenuItemSlotButton UWBP_PalInGameMenuItemSlotButton_C
---@field ['Work Progress'] UPalWorkProgress
---@field OnRightClickEggSlot FWBP_IngameMenu_Incubator_MultipleSlot_COnRightClickEggSlot
---@field TargetSlot UPalItemSlot
---@field OnLeftClickEggSlot FWBP_IngameMenu_Incubator_MultipleSlot_COnLeftClickEggSlot
local UWBP_IngameMenu_Incubator_MultipleSlot_C = {}

---@param Slot UPalItemSlot
function UWBP_IngameMenu_Incubator_MultipleSlot_C:OnSlotContentUpdate(Slot) end
---@param WorkProgress UPalWorkProgress
UWBP_IngameMenu_Incubator_MultipleSlot_C['On Update Work Amount'] = function(self, WorkProgress) end
function UWBP_IngameMenu_Incubator_MultipleSlot_C:SetEmpty() end
---@param WorkProgress UPalWorkProgress
function UWBP_IngameMenu_Incubator_MultipleSlot_C:SetupEgg(WorkProgress) end
function UWBP_IngameMenu_Incubator_MultipleSlot_C:Unbind() end
---@param ButtonBase UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_IngameMenu_Incubator_MultipleSlot_C:BndEvt__WBP_IngameMenu_Incubator_MultipleSlot_WBP_PalInGameMenuItemSlotButton_K2Node_ComponentBoundEvent_0_OnRightClickedButton__DelegateSignature(ButtonBase, PressType) end
function UWBP_IngameMenu_Incubator_MultipleSlot_C:Construct() end
---@param Widget UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_IngameMenu_Incubator_MultipleSlot_C:BndEvt__WBP_IngameMenu_Incubator_MultipleSlot_WBP_PalInGameMenuItemSlotButton_K2Node_ComponentBoundEvent_1_OnClickedButton__DelegateSignature(Widget, PressType) end
---@param TargetSlot UPalItemSlot
function UWBP_IngameMenu_Incubator_MultipleSlot_C:SetSlot(TargetSlot) end
---@param EntryPoint int32
function UWBP_IngameMenu_Incubator_MultipleSlot_C:ExecuteUbergraph_WBP_IngameMenu_Incubator_MultipleSlot(EntryPoint) end
---@param TargetSlot UPalItemSlot
function UWBP_IngameMenu_Incubator_MultipleSlot_C:OnLeftClickEggSlot__DelegateSignature(TargetSlot) end
---@param TargetSlot UPalItemSlot
function UWBP_IngameMenu_Incubator_MultipleSlot_C:OnRightClickEggSlot__DelegateSignature(TargetSlot) end


