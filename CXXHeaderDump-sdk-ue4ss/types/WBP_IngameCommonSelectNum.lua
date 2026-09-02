---@meta

---@class UWBP_IngameCommonSelectNum_C : UPalUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Canvas_SelectNum UCanvasPanel
---@field Image_3 UImage
---@field Image_4 UImage
---@field Image_Frame UImage
---@field Image_Infinite UImage
---@field SizeBox_1 USizeBox
---@field SizeBox_10 USizeBox
---@field SizeBox_100 USizeBox
---@field SizeBox_1000 USizeBox
---@field SizeBox_10000 USizeBox
---@field SizeBox_100000 USizeBox
---@field SizeBox_1000000 USizeBox
---@field SizeBox_10000000 USizeBox
---@field SizeBox_100000000 USizeBox
---@field SizeBox_1000000000 USizeBox
---@field SizeBox_LeftDoubleArrow USizeBox
---@field SizeBox_LeftDoubleArrow_KeyGuide USizeBox
---@field SizeBox_RightDoubleArrow USizeBox
---@field SizeBox_RightDoubleArrow_KeyGuide USizeBox
---@field Text_1 UBP_PalTextBlock_C
---@field Text_10 UBP_PalTextBlock_C
---@field Text_100 UBP_PalTextBlock_C
---@field Text_1000 UBP_PalTextBlock_C
---@field Text_10000 UBP_PalTextBlock_C
---@field Text_100000 UBP_PalTextBlock_C
---@field Text_1000000 UBP_PalTextBlock_C
---@field Text_10000000 UBP_PalTextBlock_C
---@field Text_100000000 UBP_PalTextBlock_C
---@field Text_1000000000 UBP_PalTextBlock_C
---@field WBP_IngameMenu_WorkSpace_NumArrow_Left_Double UWBP_IngameMenu_WorkSpace_NumArrow_C
---@field WBP_IngameMenu_WorkSpace_NumArrow_Left_Single UWBP_IngameMenu_WorkSpace_NumArrow_C
---@field WBP_IngameMenu_WorkSpace_NumArrow_Right_Double UWBP_IngameMenu_WorkSpace_NumArrow_C
---@field WBP_IngameMenu_WorkSpace_NumArrow_Right_Single UWBP_IngameMenu_WorkSpace_NumArrow_C
---@field WBP_IngameMenu_WorkSpace_Slider UWBP_IngameMenu_WorkSpace_Slider_C
---@field WBP_PalKeyGuideIcon_1 UWBP_PalKeyGuideIcon_C
---@field WBP_PalKeyGuideIcon_2 UWBP_PalKeyGuideIcon_C
---@field MinDisplayDigit int32
---@field NumTextArray TArray<UBP_PalTextBlock_C>
---@field SizeBoxArray TArray<USizeBox>
---@field DoubleArrowNum int32
---@field nowNum int64
---@field RightDoubleArrowInputHandle FPalUIActionBindData
---@field LeftDoubleArrowInputHandle FPalUIActionBindData
---@field RightArrowInputHandle FPalUIActionBindData
---@field LeftArrowInputHandle FPalUIActionBindData
---@field ['Max Num'] int64
---@field OnUpdateNum FWBP_IngameCommonSelectNum_COnUpdateNum
---@field MaxSelectInputHandle FPalUIActionBindData
---@field MinNum int64
local UWBP_IngameCommonSelectNum_C = {}

function UWBP_IngameCommonSelectNum_C:SetupInputAction() end
---@param ToRed boolean
function UWBP_IngameCommonSelectNum_C:SetNumColor(ToRed) end
function UWBP_IngameCommonSelectNum_C:UpdateArrowVisibility() end
function UWBP_IngameCommonSelectNum_C:OnTriggerMaxSelect_ForPad() end
---@param MaxNum int64
---@param MinNum int64
UWBP_IngameCommonSelectNum_C['Set Min Max Num'] = function(self, MaxNum, MinNum) end
function UWBP_IngameCommonSelectNum_C:OnTriggerLeftArrow_ForPad() end
UWBP_IngameCommonSelectNum_C['On Trigger Right Arrow for Pad'] = function(self, ) end
function UWBP_IngameCommonSelectNum_C:OnTriggerLeftDoubleArrow_ForPad() end
function UWBP_IngameCommonSelectNum_C:OnTriggerRightDoubleArrow_ForPad() end
---@param Num int64
function UWBP_IngameCommonSelectNum_C:AddNum(Num) end
---@param Num int64
function UWBP_IngameCommonSelectNum_C:GetNowSelectedNum(Num) end
---@param DIsplayDigitNum int32
function UWBP_IngameCommonSelectNum_C:UpdateDigit(DIsplayDigitNum) end
---@param bNewInputType ECommonInputType
function UWBP_IngameCommonSelectNum_C:OnInputMethodChangedeVENT(bNewInputType) end
---@param NewNum int64
---@param GroupCount int32
---@param CallDelegate boolean
function UWBP_IngameCommonSelectNum_C:SetNum(NewNum, GroupCount, CallDelegate) end
function UWBP_IngameCommonSelectNum_C:Construct() end
function UWBP_IngameCommonSelectNum_C:OnInitialized() end
---@param Progress int32
function UWBP_IngameCommonSelectNum_C:BndEvt__WBP_IngameCommonSelectNum_WBP_IngameMenu_WorkSpace_NumArrow_Right_K2Node_ComponentBoundEvent_0_OnClicked__DelegateSignature(Progress) end
---@param Progress int32
function UWBP_IngameCommonSelectNum_C:BndEvt__WBP_IngameCommonSelectNum_WBP_IngameMenu_WorkSpace_NumArrow_Left_K2Node_ComponentBoundEvent_1_OnClicked__DelegateSignature(Progress) end
---@param Progress int32
function UWBP_IngameCommonSelectNum_C:BndEvt__WBP_IngameCommonSelectNum_WBP_IngameMenu_WorkSpace_NumArrow_Right_Double_K2Node_ComponentBoundEvent_2_OnClicked__DelegateSignature(Progress) end
---@param Progress int32
function UWBP_IngameCommonSelectNum_C:BndEvt__WBP_IngameCommonSelectNum_WBP_IngameMenu_WorkSpace_NumArrow_Left_Double_K2Node_ComponentBoundEvent_3_OnClicked__DelegateSignature(Progress) end
---@param NewCount int64
function UWBP_IngameCommonSelectNum_C:BndEvt__WBP_IngameCommonSelectNum_WBP_IngameMenu_WorkSpace_Slider_K2Node_ComponentBoundEvent_5_OnValueChanged__DelegateSignature(NewCount) end
function UWBP_IngameCommonSelectNum_C:SetMax() end
---@param InVisibility ESlateVisibility
function UWBP_IngameCommonSelectNum_C:OnVisibilityChangedEvent(InVisibility) end
---@param EntryPoint int32
function UWBP_IngameCommonSelectNum_C:ExecuteUbergraph_WBP_IngameCommonSelectNum(EntryPoint) end
---@param Num int64
function UWBP_IngameCommonSelectNum_C:OnUpdateNum__DelegateSignature(Num) end


