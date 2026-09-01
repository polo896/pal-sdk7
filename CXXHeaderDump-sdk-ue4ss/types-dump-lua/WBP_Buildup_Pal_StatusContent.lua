---@meta

---@class UWBP_Buildup_Pal_StatusContent_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_RankUp UWidgetAnimation
---@field Canvas_Button_Minus1 UCanvasPanel
---@field Canvas_Button_Plus UCanvasPanel
---@field CanvasPanel_0 UCanvasPanel
---@field HorizontalBox_Gauge UHorizontalBox
---@field IconItem UImage
---@field IconStatus UImage
---@field itemNum UCanvasPanel
---@field StatusArrow UImage
---@field Text_BuildupStoneNum UBP_PalTextBlock_C
---@field Text_StatusNeme UBP_PalTextBlock_C
---@field Text_StatusNumAfter UBP_PalTextBlock_C
---@field Text_StatusNumBefore UBP_PalTextBlock_C
---@field WBP_PalInvisibleButton_Minus UWBP_PalInvisibleButton_C
---@field WBP_PalInvisibleButton_Plus UWBP_PalInvisibleButton_C
---@field BuildupGauges TArray<UWBP_Buildup_Gauge_C>
---@field Status EPalCharacterStatusOperationName
---@field Clickable boolean
---@field OnClicked FWBP_Buildup_Pal_StatusContent_COnClicked
---@field ['Current Rank'] int32
---@field TargetRank int32
---@field IsMax boolean
---@field ['Icon Index'] int32
---@field ['Item Count'] int32
---@field ['Individual Param'] UPalIndividualCharacterParameter
---@field PlusTimer FTimerHandle
---@field MinusTimer FTimerHandle
---@field PressedTimer double
---@field LoopHighSpeed boolean
local UWBP_Buildup_Pal_StatusContent_C = {}

function UWBP_Buildup_Pal_StatusContent_C:SetItemRequireInfo() end
---@param ToRank int32
function UWBP_Buildup_Pal_StatusContent_C:SetSelectRank(ToRank) end
---@param individualParam UPalIndividualCharacterParameter
---@param SetTargetRank int32
function UWBP_Buildup_Pal_StatusContent_C:SetInfo(individualParam, SetTargetRank) end
---@param Status EPalCharacterStatusOperationName
UWBP_Buildup_Pal_StatusContent_C['Get Status'] = function(self, Status) end
---@param Status EPalCharacterStatusOperationName
function UWBP_Buildup_Pal_StatusContent_C:Setup(Status) end
---@param IsEnable boolean
function UWBP_Buildup_Pal_StatusContent_C:SetEnable(IsEnable) end
function UWBP_Buildup_Pal_StatusContent_C:AnmEvent_Rankup() end
function UWBP_Buildup_Pal_StatusContent_C:RestoreAnmEvent() end
---@param Button UCommonButtonBase
function UWBP_Buildup_Pal_StatusContent_C:BndEvt__WBP_Buildup_Pal_StatusContent_WBP_PalInvisibleButton_Plus_K2Node_ComponentBoundEvent_0_OnButtonPressed__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Buildup_Pal_StatusContent_C:BndEvt__WBP_Buildup_Pal_StatusContent_WBP_PalInvisibleButton_Plus_K2Node_ComponentBoundEvent_1_OnButtonReleased__DelegateSignature(Button) end
function UWBP_Buildup_Pal_StatusContent_C:StatusPlus() end
function UWBP_Buildup_Pal_StatusContent_C:StatusMinus() end
---@param Button UCommonButtonBase
function UWBP_Buildup_Pal_StatusContent_C:BndEvt__WBP_Buildup_Pal_StatusContent_WBP_PalInvisibleButton_Minus_K2Node_ComponentBoundEvent_2_OnButtonPressed__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_Buildup_Pal_StatusContent_C:BndEvt__WBP_Buildup_Pal_StatusContent_WBP_PalInvisibleButton_Minus_K2Node_ComponentBoundEvent_5_OnButtonReleased__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_Buildup_Pal_StatusContent_C:ExecuteUbergraph_WBP_Buildup_Pal_StatusContent(EntryPoint) end
---@param Status EPalCharacterStatusOperationName
---@param TargetRank int32
function UWBP_Buildup_Pal_StatusContent_C:OnClicked__DelegateSignature(Status, TargetRank) end


