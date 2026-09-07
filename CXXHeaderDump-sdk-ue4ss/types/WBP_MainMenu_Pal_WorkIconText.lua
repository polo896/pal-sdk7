---@meta

---@class UWBP_MainMenu_Pal_WorkIconText_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_PalTextBlock_C UBP_PalTextBlock_C
---@field CanvasPanel_2 UCanvasPanel
---@field Horizontal_Gauge UHorizontalBox
---@field HorizontalBox_0 UHorizontalBox
---@field Text_Title UBP_PalTextBlock_C
---@field WBP_MainMenu_Pal_WorkGauge UWBP_MainMenu_Pal_WorkGauge_C
---@field WBP_MainMenu_Pal_WorkGauge_1 UWBP_MainMenu_Pal_WorkGauge_C
---@field WBP_MainMenu_Pal_WorkGauge_2 UWBP_MainMenu_Pal_WorkGauge_C
---@field WBP_MainMenu_Pal_WorkGauge_3 UWBP_MainMenu_Pal_WorkGauge_C
---@field WBP_MainMenu_Pal_WorkGauge_4 UWBP_MainMenu_Pal_WorkGauge_C
---@field WBP_MainMenu_Pal_WorkGauge_5 UWBP_MainMenu_Pal_WorkGauge_C
---@field WBP_MainMenu_Pal_WorkGauge_6 UWBP_MainMenu_Pal_WorkGauge_C
---@field WBP_MainMenu_Pal_WorkGauge_7 UWBP_MainMenu_Pal_WorkGauge_C
---@field WBP_MainMenu_Pal_WorkGauge_8 UWBP_MainMenu_Pal_WorkGauge_C
---@field WBP_MainMenu_Pal_WorkGauge_9 UWBP_MainMenu_Pal_WorkGauge_C
---@field WBP_MainMenu_Pal_WorkIcon UWBP_MainMenu_Pal_WorkIcon_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field Gauge_Array TArray<UWBP_MainMenu_Pal_WorkGauge_C>
---@field NewVar UWBP_MainMenu_Pal_FoodAmountIcon_C
---@field Suitability EPalWorkSuitability
---@field OnHovered FWBP_MainMenu_Pal_WorkIconText_COnHovered
---@field OnUnhovered FWBP_MainMenu_Pal_WorkIconText_COnUnhovered
local UWBP_MainMenu_Pal_WorkIconText_C = {}

---@param Suitability EPalWorkSuitability
---@param Rank int32
---@param RankBonus int32
---@param PassiveRankBonus int32
UWBP_MainMenu_Pal_WorkIconText_C['Set Suitability'] = function(self, Suitability, Rank, RankBonus, PassiveRankBonus) end
function UWBP_MainMenu_Pal_WorkIconText_C:AnmEvent_OffToOn() end
function UWBP_MainMenu_Pal_WorkIconText_C:AnmEvent_ForceOff() end
---@param Button UCommonButtonBase
function UWBP_MainMenu_Pal_WorkIconText_C:BndEvt__WBP_MainMenu_Pal_WorkIconText_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_1_CommonButtonBaseClicked__DelegateSignature(Button) end
---@param Button UCommonButtonBase
function UWBP_MainMenu_Pal_WorkIconText_C:BndEvt__WBP_MainMenu_Pal_WorkIconText_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_2_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_MainMenu_Pal_WorkIconText_C:OnInitialized() end
---@param EntryPoint int32
function UWBP_MainMenu_Pal_WorkIconText_C:ExecuteUbergraph_WBP_MainMenu_Pal_WorkIconText(EntryPoint) end
function UWBP_MainMenu_Pal_WorkIconText_C:OnUnhovered__DelegateSignature() end
---@param Widget UWBP_MainMenu_Pal_WorkIconText_C
function UWBP_MainMenu_Pal_WorkIconText_C:OnHovered__DelegateSignature(Widget) end


