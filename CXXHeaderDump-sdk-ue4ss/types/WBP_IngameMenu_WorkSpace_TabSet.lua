---@meta

---@class UWBP_IngameMenu_WorkSpace_TabSet_C : UWBP_PanelWidgetChildrenSelectorBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field HorizontalBox_Inner UHorizontalBox
---@field WBP_IngameMenu_WorkSpace_Category UWBP_IngameMenu_WorkSpace_Category_C
---@field WBP_IngameMenu_WorkSpace_Category_1 UWBP_IngameMenu_WorkSpace_Category_C
---@field WBP_IngameMenu_WorkSpace_Category_2 UWBP_IngameMenu_WorkSpace_Category_C
---@field WBP_IngameMenu_WorkSpace_Category_3 UWBP_IngameMenu_WorkSpace_Category_C
---@field WBP_IngameMenu_WorkSpace_Category_4 UWBP_IngameMenu_WorkSpace_Category_C
---@field WBP_IngameMenu_WorkSpace_Category_5 UWBP_IngameMenu_WorkSpace_Category_C
---@field WBP_IngameMenu_WorkSpace_Category_6 UWBP_IngameMenu_WorkSpace_Category_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field WBP_PalInvisibleButton_86 UWBP_PalInvisibleButton_C
---@field WBP_PalKeyGuideIcon UWBP_PalKeyGuideIcon_C
---@field WBP_PalKeyGuideIcon_78 UWBP_PalKeyGuideIcon_C
local UWBP_IngameMenu_WorkSpace_TabSet_C = {}

---@param Widget UWBP_IngameMenu_WorkSpace_Category_C
function UWBP_IngameMenu_WorkSpace_TabSet_C:OnClickedCategoryButton(Widget) end
---@param Index int32
---@param TabWidget UWBP_IngameMenu_WorkSpace_Category_C
function UWBP_IngameMenu_WorkSpace_TabSet_C:GetTabWidgetByIndex(Index, TabWidget) end
---@param OldIndex int32
---@param NewIndex int32
---@param FocusTargetWidget UWidget
function UWBP_IngameMenu_WorkSpace_TabSet_C:OnChandeFocusIndex(OldIndex, NewIndex, FocusTargetWidget) end
---@param PanelWidget UPanelWidget
function UWBP_IngameMenu_WorkSpace_TabSet_C:RegisterPanelWidget(PanelWidget) end
function UWBP_IngameMenu_WorkSpace_TabSet_C:Construct() end
function UWBP_IngameMenu_WorkSpace_TabSet_C:OnInitialized() end
---@param Button UCommonButtonBase
function UWBP_IngameMenu_WorkSpace_TabSet_C:BndEvt__WBP_IngameMenu_WorkSpace_TabSet_WBP_PalInvisibleButton_86_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_IngameMenu_WorkSpace_TabSet_C:BndEvt__WBP_IngameMenu_WorkSpace_TabSet_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_3_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_IngameMenu_WorkSpace_TabSet_C:ExecuteUbergraph_WBP_IngameMenu_WorkSpace_TabSet(EntryPoint) end


