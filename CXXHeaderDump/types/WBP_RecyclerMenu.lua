---@meta

---@class UWBP_RecyclerMenu_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Canvas_ItemNum UCanvasPanel
---@field Canvas_ProductStorage UCanvasPanel
---@field CircleGauge_Progress UImage
---@field Horizontal_WorkBoost UHorizontalBox
---@field Image_CautionIcon UImage
---@field Image_Icon UImage
---@field Image_ItemNum_Base UImage
---@field ProgressBar_BoostTimer UProgressBar
---@field ScrollList_Boost_Itemslots UWBP_PalItemScrollList_C
---@field ScrollList_Relic_Itemslots UWBP_PalItemScrollList_C
---@field Text_Head UBP_PalTextBlock_C
---@field Text_ItemName UBP_PalTextBlock_C
---@field Text_ItemNum_Max UBP_PalTextBlock_C
---@field Text_ItemNum_Now UBP_PalTextBlock_C
---@field Text_WorkBoostNum UBP_PalTextBlock_C
---@field WBP_Common_Inventory UWBP_Common_Inventory_C
---@field WBP_Common_ToggleSwitch_Power UWBP_Common_ToggleSwitch_C
---@field WBP_Common_ToggleSwitch_Supply UWBP_Common_ToggleSwitch_C
---@field WBP_CommonButton_Filter UWBP_CommonButton_1_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WBP_PalCommonItemIcon UWBP_PalCommonItemIcon_C
---@field WBP_PalInvisibleButton_QuickMove UWBP_PalInvisibleButton_C
---@field WBP_PalInvisibleButton_Sort_TargetContainer UWBP_PalInvisibleButton_C
---@field WBP_PalKeyGuideIcon UWBP_PalKeyGuideIcon_C
---@field WBP_PalKeyGuideIcon_1 UWBP_PalKeyGuideIcon_C
---@field UIModel UPalUIMapObjectRecyclerModel
---@field OnClickClosedButton FWBP_RecyclerMenu_COnClickClosedButton
---@field OnClickedTargetContainerSortButton FWBP_RecyclerMenu_COnClickedTargetContainerSortButton
---@field OnHoveredTargetContainerSlot FWBP_RecyclerMenu_COnHoveredTargetContainerSlot
---@field OnUnhoveredTargetContainerSlot FWBP_RecyclerMenu_COnUnhoveredTargetContainerSlot
---@field InventoryModel UBP_PalInventoryModel_C
---@field CurrentWorkProgress UPalWorkProgress
local UWBP_RecyclerMenu_C = {}

---@param WorkProgress UPalWorkProgress
function UWBP_RecyclerMenu_C:OnReflectWorkAmount(WorkProgress) end
---@param ButtonBase UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_RecyclerMenu_C:OnLeftClickedTargetContainerSlot_Boost(ButtonBase, PressType) end
---@param ButtonBase UWBP_PalItemSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_RecyclerMenu_C:OnLeftClickedTargetContainerSlot_Relic(ButtonBase, PressType) end
---@param bIsOn boolean
---@param bImmediate boolean
function UWBP_RecyclerMenu_C:SetPowerToggleState(bIsOn, bImmediate) end
---@param RelicItemId FName
function UWBP_RecyclerMenu_C:SetCurrentRecycleItem(RelicItemId) end
---@param bVisible boolean
function UWBP_RecyclerMenu_C:SetCautionVisible(bVisible) end
---@param Name FText
function UWBP_RecyclerMenu_C:SetBuildObjectName(Name) end
---@param bActive boolean
---@param RemainingRate float
---@param SpeedMultiplier float
function UWBP_RecyclerMenu_C:SetBoostState(bActive, RemainingRate, SpeedMultiplier) end
---@param WorkProgress UPalWorkProgress
function UWBP_RecyclerMenu_C:SetupWork(WorkProgress) end
---@param BoostContainer UPalItemContainer
function UWBP_RecyclerMenu_C:SetupBoostSlots(BoostContainer) end
---@param RelicContainer UPalItemContainer
function UWBP_RecyclerMenu_C:SetupRelicSlots(RelicContainer) end
function UWBP_RecyclerMenu_C:SetupInventory() end
---@param InUIModel UPalUIMapObjectRecyclerModel
function UWBP_RecyclerMenu_C:SetUIModel(InUIModel) end
function UWBP_RecyclerMenu_C:BndEvt__WBP_RecyclerMenu_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
function UWBP_RecyclerMenu_C:BndEvt__WBP_RecyclerMenu_WBP_Common_ToggleSwitch_Power_K2Node_ComponentBoundEvent_1_OnToggleClicked__DelegateSignature() end
---@param Button UCommonButtonBase
function UWBP_RecyclerMenu_C:BndEvt__WBP_RecyclerMenu_WBP_PalInvisibleButton_QuickMove_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_RecyclerMenu_C:BndEvt__WBP_RecyclerMenu_WBP_PalInvisibleButton_Sort_TargetContainer_K2Node_ComponentBoundEvent_3_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_RecyclerMenu_C:BndEvt__WBP_RecyclerMenu_WBP_Common_ToggleSwitch_Supply_K2Node_ComponentBoundEvent_4_OnToggleClicked__DelegateSignature() end
function UWBP_RecyclerMenu_C:BndEvt__WBP_RecyclerMenu_WBP_Common_Inventory_K2Node_ComponentBoundEvent_6_OnClickedInventorySortButton__DelegateSignature() end
function UWBP_RecyclerMenu_C:BndEvt__WBP_RecyclerMenu_WBP_CommonButton_Filter_K2Node_ComponentBoundEvent_7_OnClicked__DelegateSignature() end
---@param EntryPoint int32
function UWBP_RecyclerMenu_C:ExecuteUbergraph_WBP_RecyclerMenu(EntryPoint) end
function UWBP_RecyclerMenu_C:OnUnhoveredTargetContainerSlot__DelegateSignature() end
function UWBP_RecyclerMenu_C:OnHoveredTargetContainerSlot__DelegateSignature() end
function UWBP_RecyclerMenu_C:OnClickedTargetContainerSortButton__DelegateSignature() end
function UWBP_RecyclerMenu_C:OnClickClosedButton__DelegateSignature() end


