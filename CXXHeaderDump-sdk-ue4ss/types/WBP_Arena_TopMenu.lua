---@meta

---@class UWBP_Arena_TopMenu_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_ButtonOut UWidgetAnimation
---@field Anm_MenuInOut UWidgetAnimation
---@field Anm_Out UWidgetAnimation
---@field Anm_In UWidgetAnimation
---@field Canvas_MenuGuideText UCanvasPanel
---@field Canvas_Wait UCanvasPanel
---@field Text_MenuGuide UBP_PalTextBlock_C
---@field WBP_Arena_PlayerRank UWBP_Arena_PlayerRank_C
---@field WBP_Arena_TopMenuButton_PvP UWBP_Arena_TopMenuButton_C
---@field WBP_Arena_TopMenuButton_Solo UWBP_Arena_TopMenuButton_C
---@field WBP_Arena_TopMenuButton_Spectate UWBP_Arena_TopMenuButton_C
---@field Entrance APalArenaEntrance
---@field LastFocusIndex int32
---@field MenuOut boolean
---@field LastAction EPalArenaMenuActionType
local UWBP_Arena_TopMenu_C = {}

---@return UWidget
function UWBP_Arena_TopMenu_C:BP_GetDesiredFocusTarget() end
---@param Index int32
---@param IsEnable boolean
function UWBP_Arena_TopMenu_C:ChangeInfo(Index, IsEnable) end
function UWBP_Arena_TopMenu_C:CancelAction() end
---@param ActionType EPalArenaMenuActionType
UWBP_Arena_TopMenu_C['Top Menu Action'] = function(self, ActionType) end
function UWBP_Arena_TopMenu_C:Setup() end
function UWBP_Arena_TopMenu_C:Finished_55E66A6745B17F175A5608B05FCBDDC7() end
function UWBP_Arena_TopMenu_C:AnmEvent_In() end
function UWBP_Arena_TopMenu_C:AnmEvent_Out() end
function UWBP_Arena_TopMenu_C:AnmEvent_MenuOut() end
function UWBP_Arena_TopMenu_C:AnmEvent_MenuIn() end
function UWBP_Arena_TopMenu_C:OnInitialized() end
function UWBP_Arena_TopMenu_C:OnSetup() end
function UWBP_Arena_TopMenu_C:Construct() end
function UWBP_Arena_TopMenu_C:BndEvt__WBP_Arena_TopMenu_WBP_Arena_TopMenuButton_Solo_K2Node_ComponentBoundEvent_0_OnArenaButtonClicked__DelegateSignature() end
function UWBP_Arena_TopMenu_C:BndEvt__WBP_Arena_TopMenu_WBP_Arena_TopMenuButton_PvP_K2Node_ComponentBoundEvent_1_OnArenaButtonClicked__DelegateSignature() end
function UWBP_Arena_TopMenu_C:BndEvt__WBP_Arena_TopMenu_WBP_Arena_TopMenuButton_Spectate_K2Node_ComponentBoundEvent_2_OnArenaButtonClicked__DelegateSignature() end
function UWBP_Arena_TopMenu_C:BndEvt__WBP_Arena_TopMenu_WBP_Arena_TopMenuButton_Solo_K2Node_ComponentBoundEvent_3_OnArenaButtonHovered__DelegateSignature() end
function UWBP_Arena_TopMenu_C:BndEvt__WBP_Arena_TopMenu_WBP_Arena_TopMenuButton_Solo_K2Node_ComponentBoundEvent_4_OnArenaButtonUnhovered__DelegateSignature() end
function UWBP_Arena_TopMenu_C:BndEvt__WBP_Arena_TopMenu_WBP_Arena_TopMenuButton_PvP_K2Node_ComponentBoundEvent_5_OnArenaButtonHovered__DelegateSignature() end
function UWBP_Arena_TopMenu_C:BndEvt__WBP_Arena_TopMenu_WBP_Arena_TopMenuButton_PvP_K2Node_ComponentBoundEvent_6_OnArenaButtonUnhovered__DelegateSignature() end
function UWBP_Arena_TopMenu_C:BndEvt__WBP_Arena_TopMenu_WBP_Arena_TopMenuButton_Spectate_K2Node_ComponentBoundEvent_7_OnArenaButtonHovered__DelegateSignature() end
function UWBP_Arena_TopMenu_C:BndEvt__WBP_Arena_TopMenu_WBP_Arena_TopMenuButton_Spectate_K2Node_ComponentBoundEvent_8_OnArenaButtonUnhovered__DelegateSignature() end
---@param bResult boolean
function UWBP_Arena_TopMenu_C:EmptyEvent(bResult) end
---@param JoinMatch boolean
function UWBP_Arena_TopMenu_C:RrequestEnterArena(JoinMatch) end
function UWBP_Arena_TopMenu_C:OnClosed() end
---@param EntryPoint int32
function UWBP_Arena_TopMenu_C:ExecuteUbergraph_WBP_Arena_TopMenu(EntryPoint) end


