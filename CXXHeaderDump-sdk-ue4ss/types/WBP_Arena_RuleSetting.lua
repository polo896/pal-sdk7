---@meta

---@class UWBP_Arena_RuleSetting_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_PalTextBlock_RestrictOtomo UBP_PalTextBlock_C
---@field BP_PalTextBlock_Title UBP_PalTextBlock_C
---@field CanvasPanel_Matching UCanvasPanel
---@field Image_RankIcon UImage
---@field ScrollBox UScrollBox
---@field Text_PlayerName_Lv UBP_PalTextBlock_C
---@field Text_PlayerName_P1 UBP_PalTextBlock_C
---@field WBP_Arena_PalIcon UWBP_Arena_PalIcon_C
---@field WBP_Arena_PalIcon_1 UWBP_Arena_PalIcon_C
---@field WBP_Arena_PalIcon_2 UWBP_Arena_PalIcon_C
---@field WBP_Arena_PalIcon_3 UWBP_Arena_PalIcon_C
---@field WBP_Arena_PalIcon_4 UWBP_Arena_PalIcon_C
---@field WBP_Arena_Rule_ListGroup UWBP_Arena_Rule_ListGroup_C
---@field WBP_Arena_RuleSetting_Pal UWBP_Arena_RuleSetting_Pal_C
---@field WBP_CommonButton UWBP_CommonButton_C
---@field WBP_IngameMenu_PalBox_PalDetail UWBP_IngameMenu_PalBox_PalDetail_C
---@field WBP_MainMenu_PalSkillInfo UWBP_MainMenu_PalSkillInfo_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field ArenaRuleParamter UPalHUDDispatchParameter_ArenaRule
---@field CurrentRule FPalArenaRule
---@field OtomoPalIcons TArray<UWBP_Arena_PalIcon_C>
---@field SaveRuleAction FPalUIActionBindData
---@field DefaultRuleAction FPalUIActionBindData
local UWBP_Arena_RuleSetting_C = {}

function UWBP_Arena_RuleSetting_C:SaveRule() end
function UWBP_Arena_RuleSetting_C:SetDefaultRule() end
---@return UWidget
function UWBP_Arena_RuleSetting_C:BP_GetDesiredFocusTarget() end
function UWBP_Arena_RuleSetting_C:RefreshOtomoRestriction() end
function UWBP_Arena_RuleSetting_C:CancelAction() end
function UWBP_Arena_RuleSetting_C:ShowRestrictPalDetail() end
function UWBP_Arena_RuleSetting_C:OnotomoIconUnhovered() end
---@param Icon UWBP_Arena_PalIcon_C
function UWBP_Arena_RuleSetting_C:OnOtomoIconHovered(Icon) end
---@param NewRule FPalArenaRule
function UWBP_Arena_RuleSetting_C:OnRuleChanged(NewRule) end
function UWBP_Arena_RuleSetting_C:Setup() end
function UWBP_Arena_RuleSetting_C:BndEvt__WBP_Arena_RuleSetting_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
function UWBP_Arena_RuleSetting_C:OnSetup() end
function UWBP_Arena_RuleSetting_C:BndEvt__WBP_Arena_RuleSetting_WBP_CommonButton_K2Node_ComponentBoundEvent_1_OnClicked__DelegateSignature() end
function UWBP_Arena_RuleSetting_C:OnInitialized() end
function UWBP_Arena_RuleSetting_C:Construct() end
function UWBP_Arena_RuleSetting_C:BndEvt__WBP_Arena_RuleSetting_WBP_Arena_RuleSetting_Pal_K2Node_ComponentBoundEvent_2_OnCloseButtonClicked__DelegateSignature() end
---@param CharacterID FName
---@param Widget UWBP_Arena_RuleSetting_PalListButton_C
function UWBP_Arena_RuleSetting_C:BndEvt__WBP_Arena_RuleSetting_WBP_Arena_RuleSetting_Pal_K2Node_ComponentBoundEvent_3_OnToggleCharacterRestrict__DelegateSignature(CharacterID, Widget) end
---@param IsBan boolean
function UWBP_Arena_RuleSetting_C:BndEvt__WBP_Arena_RuleSetting_WBP_Arena_RuleSetting_Pal_K2Node_ComponentBoundEvent_4_OnChangeAll__DelegateSignature(IsBan) end
---@param Show boolean
function UWBP_Arena_RuleSetting_C:BndEvt__WBP_Arena_RuleSetting_WBP_Arena_Rule_ListGroup_K2Node_ComponentBoundEvent_5_ToggleLevelSyncInfo__DelegateSignature(Show) end
---@param EntryPoint int32
function UWBP_Arena_RuleSetting_C:ExecuteUbergraph_WBP_Arena_RuleSetting(EntryPoint) end


