---@meta

---@class UWBP_PalConvertItemMenu_RecipeSlotButton_C : UPalUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Rarity UWidgetAnimation
---@field Anm_Select UWidgetAnimation
---@field Base UImage
---@field CanvasPanel_Num UCanvasPanel
---@field CanvasPanelRarety UCanvasPanel
---@field FocusBase UImage
---@field FocusFrame UImage
---@field Frame_Focus_Flare UImage
---@field Image_Disable UImage
---@field Image_None UImage
---@field Image_RarityLine UImage
---@field Text_Num UBP_PalTextBlock_C
---@field WBP_InventoryEquipment_PalIcon UWBP_InventoryEquipment_PalIcon_C
---@field WBP_PalInGameMenuItemIcon UWBP_PalInGameMenuItemIcon_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnClickSlot FWBP_PalConvertItemMenu_RecipeSlotButton_COnClickSlot
---@field RecipeID FName
---@field OnHoveredSlot FWBP_PalConvertItemMenu_RecipeSlotButton_COnHoveredSlot
---@field OnUnhoveredSlot FWBP_PalConvertItemMenu_RecipeSlotButton_COnUnhoveredSlot
---@field Selected boolean
---@field MatMap TMap<FName, int32>
---@field ['Product ItemId'] FName
---@field UpdateSufficientTimer FTimerHandle
local UWBP_PalConvertItemMenu_RecipeSlotButton_C = {}

---@param ProductId FName
---@param ProductItemId FName
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:SetupProductItemInfo(ProductId, ProductItemId) end
---@param CropDataId FName
---@param CropItemId FName
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:SetupFarmCropInfo(CropDataId, CropItemId) end
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:UpdateSufficient() end
---@param ItemId FName
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:SetPalGearIcon(ItemId) end
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:SetUnselect() end
---@param RecipeID FName
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:GetRecipeId(RecipeID) end
---@param RecipeID FName
---@param MatInfo TArray<FPalStaticItemIdAndNum>
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:Setup(RecipeID, MatInfo) end
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:BP_OnEntryReleased() end
---@param bIsExpanded boolean
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:BP_OnItemExpansionChanged(bIsExpanded) end
---@param bIsSelected boolean
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:BP_OnItemSelectionChanged(bIsSelected) end
---@param ListItemObject UObject
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:OnListItemObjectSet(ListItemObject) end
---@param Button UCommonButtonBase
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:BndEvt__WBP_PalConvertItemMenu_RecipeSlotButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:BndEvt__WBP_PalConvertItemMenu_RecipeSlotButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_4_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:BndEvt__WBP_PalConvertItemMenu_RecipeSlotButton_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_5_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:Destruct() end
---@param EntryPoint int32
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:ExecuteUbergraph_WBP_PalConvertItemMenu_RecipeSlotButton(EntryPoint) end
---@param SelfWidget UWBP_PalConvertItemMenu_RecipeSlotButton_C
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:OnUnhoveredSlot__DelegateSignature(SelfWidget) end
---@param SelfWidget UWBP_PalConvertItemMenu_RecipeSlotButton_C
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:OnHoveredSlot__DelegateSignature(SelfWidget) end
---@param SelfWidget UWBP_PalConvertItemMenu_RecipeSlotButton_C
function UWBP_PalConvertItemMenu_RecipeSlotButton_C:OnClickSlot__DelegateSignature(SelfWidget) end


