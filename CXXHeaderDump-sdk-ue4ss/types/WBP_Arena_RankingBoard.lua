---@meta

---@class UWBP_Arena_RankingBoard_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_In UWidgetAnimation
---@field ScrollBox_0 UScrollBox
---@field WBP_Arena_RankingBoard_List_Player UWBP_Arena_RankingBoard_List_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field LastHoveredIndex int32
local UWBP_Arena_RankingBoard_C = {}

---@param RankingInfo FPalArenaWorldRankingRecord
function UWBP_Arena_RankingBoard_C:OnLocalPlayerInfoReplicated(RankingInfo) end
---@param Widget UWidget
function UWBP_Arena_RankingBoard_C:OnListHovered(Widget) end
---@param Navigation EUINavigation
---@return UWidget
UWBP_Arena_RankingBoard_C['Do Custom Navigation_Left'] = function(self, Navigation) end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_Arena_RankingBoard_C:DoCustomNavigation_Right(Navigation) end
---@return UWidget
function UWBP_Arena_RankingBoard_C:BP_GetDesiredFocusTarget() end
function UWBP_Arena_RankingBoard_C:Setup() end
function UWBP_Arena_RankingBoard_C:Finished_0CE00FEB491F3446724290B53E54505B() end
function UWBP_Arena_RankingBoard_C:BndEvt__WBP_Arena_RankingBoard_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
function UWBP_Arena_RankingBoard_C:OnSetup() end
function UWBP_Arena_RankingBoard_C:Construct() end
function UWBP_Arena_RankingBoard_C:CloseAnm() end
---@param EntryPoint int32
function UWBP_Arena_RankingBoard_C:ExecuteUbergraph_WBP_Arena_RankingBoard(EntryPoint) end


