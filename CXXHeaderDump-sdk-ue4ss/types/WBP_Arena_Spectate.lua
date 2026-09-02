---@meta

---@class UWBP_Arena_Spectate_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ScrollBox_0 UScrollBox
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WBP_NoData UWBP_NoData_C
---@field WBP_PalKeyGuideIconAndText UWBP_PalKeyGuideIconAndText_C
---@field WBP_PalKeyGuideIconAndText_1 UWBP_PalKeyGuideIconAndText_C
---@field Entrance APalArenaEntrance
---@field CachedInfo TArray<FPalArenaSpectateRoomInfo>
---@field RuleActionInput FPalUIActionBindData
---@field SpecActionInput FPalUIActionBindData
---@field LastHoveredIndex int32
local UWBP_Arena_Spectate_C = {}

---@param IsYes boolean
function UWBP_Arena_Spectate_C:ConfirmSpec(IsYes) end
function UWBP_Arena_Spectate_C:StartSpecAction() end
function UWBP_Arena_Spectate_C:ViewRuleAction() end
---@return UWidget
function UWBP_Arena_Spectate_C:BP_GetDesiredFocusTarget() end
---@param Button UWBP_Arena_Spectate_List_C
function UWBP_Arena_Spectate_C:OnSpecButtonUnhovered(Button) end
---@param Button UWBP_Arena_Spectate_List_C
function UWBP_Arena_Spectate_C:OnSpecButtonHovered(Button) end
---@param Button UWBP_Arena_Spectate_List_C
function UWBP_Arena_Spectate_C:OnSpecButtonClicked(Button) end
function UWBP_Arena_Spectate_C:CancelAction() end
function UWBP_Arena_Spectate_C:Setup() end
function UWBP_Arena_Spectate_C:BndEvt__WBP_Arena_Spectate_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
function UWBP_Arena_Spectate_C:OnSetup() end
function UWBP_Arena_Spectate_C:OnInitialized() end
---@param EntryPoint int32
function UWBP_Arena_Spectate_C:ExecuteUbergraph_WBP_Arena_Spectate(EntryPoint) end


