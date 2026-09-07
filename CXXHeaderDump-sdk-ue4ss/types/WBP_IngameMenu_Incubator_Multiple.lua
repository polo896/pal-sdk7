---@meta

---@class UWBP_IngameMenu_Incubator_Multiple_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Canvas_Buff UCanvasPanel
---@field Canvas_PowerShortage UCanvasPanel
---@field Text_Buff_Value UBP_PalTextBlock_C
---@field Text_Head UBP_PalTextBlock_C
---@field Text_Status UBP_PalTextBlock_C
---@field WBP_Common_Inventory UWBP_Common_Inventory_C
---@field WBP_CommonButton_OpenAll UWBP_CommonButton_C
---@field WBP_CommonButton_SetAll UWBP_CommonButton_1_C
---@field WBP_Ingame_Incubator_MultipleSlot UWBP_IngameMenu_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_1 UWBP_IngameMenu_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_2 UWBP_IngameMenu_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_3 UWBP_IngameMenu_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_4 UWBP_IngameMenu_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_5 UWBP_IngameMenu_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_6 UWBP_IngameMenu_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_7 UWBP_IngameMenu_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_8 UWBP_IngameMenu_Incubator_MultipleSlot_C
---@field WBP_Ingame_Incubator_MultipleSlot_9 UWBP_IngameMenu_Incubator_MultipleSlot_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field InventoryModel UBP_PalInventoryModel_C
---@field ['Hatching Egg Model'] UPalMapObjectMultiHatchingEggModel
---@field HatchSlots TArray<UWBP_IngameMenu_Incubator_MultipleSlot_C>
---@field BlockGetAll boolean
---@field EnableWaitWorkSync boolean
local UWBP_IngameMenu_Incubator_Multiple_C = {}

function UWBP_IngameMenu_Incubator_Multiple_C:OnEggArrayUpdated() end
---@param WorkeeModule UPalMapObjectWorkeeModule
---@param WorkProgress UPalWorkBase
function UWBP_IngameMenu_Incubator_Multiple_C:OnWorkSynced(WorkeeModule, WorkProgress) end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_IngameMenu_Incubator_Multiple_C:DoCustomNavigation_ToSlot8(Navigation) end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_IngameMenu_Incubator_Multiple_C:DoCustomNavigation_ToSetAll(Navigation) end
---@param HatchedIDs TArray<FPalInstanceID>
function UWBP_IngameMenu_Incubator_Multiple_C:OnMultiHatchComplete(HatchedIDs) end
---@return UWidget
function UWBP_IngameMenu_Incubator_Multiple_C:BP_GetDesiredFocusTarget() end
function UWBP_IngameMenu_Incubator_Multiple_C:FocusRight() end
function UWBP_IngameMenu_Incubator_Multiple_C:FocusLeft() end
---@param TargetSlot UPalItemSlot
function UWBP_IngameMenu_Incubator_Multiple_C:OnLeftClickEggSlot(TargetSlot) end
---@param TargetSlot UPalItemSlot
function UWBP_IngameMenu_Incubator_Multiple_C:OnRightClickEggSlot(TargetSlot) end
---@param ItemContainer UPalItemContainer
function UWBP_IngameMenu_Incubator_Multiple_C:UpdateSlots(ItemContainer) end
---@param Model UPalMapObjectHatchingEggModelBase
UWBP_IngameMenu_Incubator_Multiple_C['Check Get All Enable'] = function(self, Model) end
---@param Ratio double
---@param Persent FText
function UWBP_IngameMenu_Incubator_Multiple_C:RatioToPersentOffsetText(Ratio, Persent) end
---@param Module UPalMapObjectEnergyModule
UWBP_IngameMenu_Incubator_Multiple_C['Update Power Suffcient'] = function(self, Module) end
function UWBP_IngameMenu_Incubator_Multiple_C:SetupHatch() end
function UWBP_IngameMenu_Incubator_Multiple_C:OnSetup() end
function UWBP_IngameMenu_Incubator_Multiple_C:BndEvt__WBP_IngameMenu_Incubator_Multiple_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
function UWBP_IngameMenu_Incubator_Multiple_C:OnInitialized() end
function UWBP_IngameMenu_Incubator_Multiple_C:BndEvt__WBP_IngameMenu_Incubator_Multiple_WBP_CommonButton_SetAll_K2Node_ComponentBoundEvent_1_OnClicked__DelegateSignature() end
function UWBP_IngameMenu_Incubator_Multiple_C:BndEvt__WBP_IngameMenu_Incubator_Multiple_WBP_CommonButton_OpenAll_K2Node_ComponentBoundEvent_2_OnClicked__DelegateSignature() end
function UWBP_IngameMenu_Incubator_Multiple_C:Destruct() end
function UWBP_IngameMenu_Incubator_Multiple_C:BndEvt__WBP_IngameMenu_Incubator_Multiple_WBP_Common_Inventory_K2Node_ComponentBoundEvent_3_OnClickedInventorySortButton__DelegateSignature() end
function UWBP_IngameMenu_Incubator_Multiple_C:OnHatchFailed() end
---@param bResult boolean
function UWBP_IngameMenu_Incubator_Multiple_C:Empty(bResult) end
---@param EntryPoint int32
function UWBP_IngameMenu_Incubator_Multiple_C:ExecuteUbergraph_WBP_IngameMenu_Incubator_Multiple(EntryPoint) end


