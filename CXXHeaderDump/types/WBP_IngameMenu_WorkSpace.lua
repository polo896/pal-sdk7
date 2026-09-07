---@meta

---@class UWBP_IngameMenu_WorkSpace_C : UPalUIPaldex
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Rarity UWidgetAnimation
---@field Anm_Tips_InOut UWidgetAnimation
---@field BP_PalTextBlock_C_77 UBP_PalTextBlock_C
---@field BP_PalTextBlock_Name UBP_PalTextBlock_C
---@field BP_PalTextBlock_NoRecipe UBP_PalTextBlock_C
---@field BP_PalTextBlock_Num UBP_PalTextBlock_C
---@field Canvas_ItemIcon UCanvasPanel
---@field Canvas_ProductPlan UCanvasPanel
---@field Canvas_Select UCanvasPanel
---@field CanvasPanel_ItemNum UCanvasPanel
---@field CanvasPanelIcon UCanvasPanel
---@field CheckBox UCheckBox
---@field CommonTileView_146 UCommonTileView
---@field FrameFlare UImage
---@field Holizontal_ManMonth_Text UHorizontalBox
---@field HorizontalBox_ProductNum UHorizontalBox
---@field HorizontalBox_SearchName UCanvasPanel
---@field HorizontalBox_TransportCheckBox UHorizontalBox
---@field Image_10 UImage
---@field Image_99 UImage
---@field Image_365 UImage
---@field Image_Icon UImage
---@field Image_Icon_Shadow UImage
---@field Image_ItemNum_Base UImage
---@field Image_Line UImage
---@field Image_Rarity UImage
---@field Image_Rarity_1 UImage
---@field PalEditableTextBox_Search UPalEditableTextBox
---@field PalRetainerBox_150 UPalRetainerBox
---@field Text_FilterContent UBP_PalTextBlock_C
---@field Text_ItemNumValue UBP_PalTextBlock_C
---@field Text_ManMonth_Value UBP_PalTextBlock_C
---@field WBP_Ingame_WorkSpace_ProductTab UWBP_Ingame_WorkSpace_ProductTab_C
---@field WBP_IngameCommonSelectNum UWBP_IngameCommonSelectNum_C
---@field WBP_IngameMenu_StartButton UWBP_IngameMenu_WorkSpace_StartButton_C
---@field WBP_IngameMenu_WorkSpace_TabSet UWBP_IngameMenu_WorkSpace_TabSet_C
---@field WBP_InventoryEquipment_ItemInfo_Tecnology UWBP_InventoryEquipment_ItemInfo_Tecnology_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WBP_PalInGameMenuItemIcon UWBP_PalInGameMenuItemIcon_C
---@field WBP_PalInvisibleButton_SerchName UWBP_PalInvisibleButton_C
---@field WBP_PalInvisibleButton_TransportCheck UWBP_PalInvisibleButton_C
---@field ['Convert Item Model'] UBP_PalUIConvertItemModel_C
---@field CurrentProductAmount int32
---@field InputActionName_Max FName
---@field IsSelectingProductNumFlag boolean
---@field LastSelectedSlot UWBP_PalConvertItemMenu_RecipeSlotButton_C
---@field InputActionName_Start FName
---@field InputActionName_Cancel FName
---@field TmpComtrollableBlueprintInfo TArray<FPalStaticItemIdAndNum>
---@field UpdateRecipeTimer FTimerHandle
---@field InputActionName_CanTransportOut FName
---@field InputAction_NextCategory FDataTableRowHandle
---@field InputAction_PrevCategory FDataTableRowHandle
---@field ActionHandle_NextCategory FPalUIActionBindData
---@field ActionHandle_PrevCategory FPalUIActionBindData
---@field HintTextMsgID FDataTableRowHandle
---@field CurrentFilteringItemTypeA TArray<EPalItemTypeA>
---@field CurrentExcludeItemTypeB TArray<EPalItemTypeA>
---@field bIsFiltered boolean
---@field CachedRecipeIds TArray<FName>
---@field RecipeSlorButtonMap TMap<FName, UWBP_PalConvertItemMenu_RecipeSlotButton_C>
---@field EntryDataMap TMap<FName, UBP_RecipeSlotButtonEntryData_C>
---@field LastHoveredEntryItem UBP_RecipeSlotButtonEntryData_C
---@field FirstRecipeID FName
local UWBP_IngameMenu_WorkSpace_C = {}

---@param Widget UWidget
function UWBP_IngameMenu_WorkSpace_C:GetLastHoveredFocusTarget(Widget) end
---@param ItemId FName
---@param bIsMatch boolean
function UWBP_IngameMenu_WorkSpace_C:IsMatchItemName(ItemId, bIsMatch) end
function UWBP_IngameMenu_WorkSpace_C:RefleshFIltering() end
---@param EntryObject UObject
---@param Widget UWBP_PalConvertItemMenu_RecipeSlotButton_C
function UWBP_IngameMenu_WorkSpace_C:EntryToWidget(EntryObject, Widget) end
function UWBP_IngameMenu_WorkSpace_C:ToggleCanTransportOut() end
function UWBP_IngameMenu_WorkSpace_C:StartProduce() end
function UWBP_IngameMenu_WorkSpace_C:SetMaxProductCount() end
---@param RecipeIds TArray<FName>
UWBP_IngameMenu_WorkSpace_C['Initialize Entry Data'] = function(self, RecipeIds) end
function UWBP_IngameMenu_WorkSpace_C:WBP_IngameMenu_WorkSpace_AutoGenFunc() end
function UWBP_IngameMenu_WorkSpace_C:OnInputAction_PrevCategory() end
function UWBP_IngameMenu_WorkSpace_C:OnInputAction_NextCategory() end
function UWBP_IngameMenu_WorkSpace_C:RegisterChangeCategoryInputAction() end
---@param TabWidget UWBP_IngameMenu_WorkSpace_Category_C
function UWBP_IngameMenu_WorkSpace_C:OnChangedCategory(TabWidget) end
---@param InputType ECommonInputType
function UWBP_IngameMenu_WorkSpace_C:InputMethodChanged(InputType) end
---@param bOn boolean
function UWBP_IngameMenu_WorkSpace_C:OnUpdateCanTransportOut(bOn) end
---@param RecipeIDArray TArray<FName>
---@param FilteredArray TArray<FName>
function UWBP_IngameMenu_WorkSpace_C:FilteringRecipe(RecipeIDArray, FilteredArray) end
function UWBP_IngameMenu_WorkSpace_C:OnCancelInput() end
---@param IsSelecting boolean
function UWBP_IngameMenu_WorkSpace_C:IsSelectingProductNum(IsSelecting) end
---@param Recipes TArray<FName>
---@param WorkBenchId FName
---@param FilteredRecipes TArray<FName>
function UWBP_IngameMenu_WorkSpace_C:FilterSkillUnlocker(Recipes, WorkBenchId, FilteredRecipes) end
---@return UWidget
function UWBP_IngameMenu_WorkSpace_C:BP_GetDesiredFocusTarget() end
UWBP_IngameMenu_WorkSpace_C['Update Recipe Detail'] = function(self, ) end
---@param Slot UWBP_PalConvertItemMenu_RecipeSlotButton_C
function UWBP_IngameMenu_WorkSpace_C:OnUnhoveredRecipeSlot(Slot) end
---@param Slot UWBP_PalConvertItemMenu_RecipeSlotButton_C
function UWBP_IngameMenu_WorkSpace_C:OnHoveredRecipeSlot(Slot) end
---@param Slot UWBP_PalConvertItemMenu_RecipeSlotButton_C
function UWBP_IngameMenu_WorkSpace_C:OnClickedRecipeSlot(Slot) end
function UWBP_IngameMenu_WorkSpace_C:Setup() end
function UWBP_IngameMenu_WorkSpace_C:OnSetup() end
function UWBP_IngameMenu_WorkSpace_C:BndEvt__WBP_IngameMenu_WorkSpace_WBP_IngameMenu_StartButton_K2Node_ComponentBoundEvent_2_OnClicked__DelegateSignature() end
function UWBP_IngameMenu_WorkSpace_C:BndEvt__WBP_InGameMainMenu_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
function UWBP_IngameMenu_WorkSpace_C:Destruct() end
---@param Button UCommonButtonBase
function UWBP_IngameMenu_WorkSpace_C:BndEvt__WBP_IngameMenu_WorkSpace_WBP_PalInvisibleButton_TransportCheck_K2Node_ComponentBoundEvent_8_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_IngameMenu_WorkSpace_C:Construct() end
---@param Num int64
function UWBP_IngameMenu_WorkSpace_C:BndEvt__WBP_IngameMenu_WorkSpace_WBP_IngameCommonSelectNum_K2Node_ComponentBoundEvent_5_OnUpdateNum__DelegateSignature(Num) end
---@param OldIndex int32
---@param NewIndex int32
---@param FocusTargetWidget UWidget
function UWBP_IngameMenu_WorkSpace_C:BndEvt__WBP_IngameMenu_WorkSpace_WBP_IngameMenu_WorkSpace_TabSet_K2Node_ComponentBoundEvent_1_OnChangedFocusIndex__DelegateSignature(OldIndex, NewIndex, FocusTargetWidget) end
---@param Button UCommonButtonBase
function UWBP_IngameMenu_WorkSpace_C:BndEvt__WBP_IngameMenu_WorkSpace_WBP_PalInvisibleButton_SerchName_K2Node_ComponentBoundEvent_3_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Text FText
---@param CommitMethod ETextCommit::Type
function UWBP_IngameMenu_WorkSpace_C:BndEvt__WBP_IngameMenu_WorkSpace_PalEditableTextBox_Search_K2Node_ComponentBoundEvent_4_OnEditableTextBoxCommittedEvent__DelegateSignature(Text, CommitMethod) end
---@param Item UObject
---@param Widget UUserWidget
function UWBP_IngameMenu_WorkSpace_C:BndEvt__WBP_IngameMenu_WorkSpace_CommonTileView_146_K2Node_ComponentBoundEvent_6_OnListEntryInitializedDynamic__DelegateSignature(Item, Widget) end
---@param Widget UUserWidget
function UWBP_IngameMenu_WorkSpace_C:BndEvt__WBP_IngameMenu_WorkSpace_CommonTileView_146_K2Node_ComponentBoundEvent_9_OnListEntryReleasedDynamic__DelegateSignature(Widget) end
---@param EntryPoint int32
function UWBP_IngameMenu_WorkSpace_C:ExecuteUbergraph_WBP_IngameMenu_WorkSpace(EntryPoint) end


