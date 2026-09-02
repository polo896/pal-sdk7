---@meta

---@class UWBP_Buildup_Player_1_C : UPalUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Canvas_NothingRelic UCanvasPanel
---@field Canvas_Scroll UCanvasPanel
---@field SizeBox_ConfirmButton USizeBox
---@field Text_Info_1 UBP_PalTextBlock_C
---@field WBP_Buildup_Player_Item UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_1 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_2 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_3 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_4 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_5 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_6 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_7 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_8 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_9 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_10 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_11 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_12 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_13 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_14 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_15 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_16 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_17 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_18 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_19 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_20 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_21 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_22 UWBP_Buildup_Player_Item_C
---@field WBP_Buildup_Player_Item_23 UWBP_Buildup_Player_Item_C
---@field WBP_CommonButton_Confirm UWBP_CommonButton_C
---@field WBP_MainMenu_PalSkillInfo UWBP_MainMenu_PalSkillInfo_C
---@field WBP_Menu_btn_Close UWBP_Menu_btn_C
---@field WBP_PalCommonScrollList UWBP_PalCommonScrollList_C
---@field WBP_PalKeyGuideIcon UWBP_PalKeyGuideIcon_C
---@field WrapBox_HaveItem UWrapBox
---@field WrapBox_RequireItem UWrapBox
---@field InInventoryRelicCountWidgetMap TMap<EPalRelicType, UWBP_Buildup_Player_Item_C>
---@field RequireRelicCountWidgetMap TMap<EPalRelicType, UWBP_Buildup_Player_Item_C>
---@field OperationWidgetMap TMap<EPalRelicType, UWBP_Buildup_Player_StatusContent_C>
---@field SoftStatusOpetation TSoftObjectPtr<UPalCharacterStatusOperation>
---@field OnClickedConfirm FWBP_Buildup_Player_1_COnClickedConfirm
---@field QuickConfirmAction FPalDataTableRowName_UIInputAction
---@field QuickConfirmActionHandle FPalUIActionBindData
---@field OnClickedCloseButton FWBP_Buildup_Player_1_COnClickedCloseButton
---@field bIsParentRequesting boolean
local UWBP_Buildup_Player_1_C = {}

---@param NewIsParentRequesting boolean
function UWBP_Buildup_Player_1_C:SetIsParentRequesting(NewIsParentRequesting) end
---@param NewAcceptInput boolean
function UWBP_Buildup_Player_1_C:SetAllOperationWidgetAcceptInput(NewAcceptInput) end
function UWBP_Buildup_Player_1_C:OnInputAction_QuckConfirm() end
---@param bEnableAction boolean
function UWBP_Buildup_Player_1_C:SetEnableQuickConfirmAction(bEnableAction) end
---@return UWidget
function UWBP_Buildup_Player_1_C:GetTopFocusTarget() end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_Buildup_Player_1_C:DoCustomNavigation_ToConfirmButton(Navigation) end
function UWBP_Buildup_Player_1_C:UpdateConfirmButton() end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_Buildup_Player_1_C:DoCustomNavigation_ToListTop(Navigation) end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_Buildup_Player_1_C:DoCustomNavigation_ToCloseButton(Navigation) end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_Buildup_Player_1_C:DoCustomNavigation_ToListBottom(Navigation) end
---@param RelicType EPalRelicType
---@param OriginalRank int32
---@param CurrentSimulationRank int32
function UWBP_Buildup_Player_1_C:OnSimulationChanged(RelicType, OriginalRank, CurrentSimulationRank) end
function UWBP_Buildup_Player_1_C:ResetSimulationAndUpdateAll() end
---@param RankupInfo TMap<EPalRelicType, int32>
function UWBP_Buildup_Player_1_C:CollectSimulationInfo(RankupInfo) end
---@param Widget UWBP_Buildup_Player_StatusContent_C
function UWBP_Buildup_Player_1_C:OnUnhoveredRelicPanel(Widget) end
---@param Widget UWBP_Buildup_Player_StatusContent_C
function UWBP_Buildup_Player_1_C:OnHoveredRelicPanel(Widget) end
---@param Widget UWidget
function UWBP_Buildup_Player_1_C:GetRestoreFocusTarget(Widget) end
---@param bNothingRelic boolean
function UWBP_Buildup_Player_1_C:SetNothingRelic(bNothingRelic) end
function UWBP_Buildup_Player_1_C:UpdateRequireRelicCount() end
function UWBP_Buildup_Player_1_C:UpdateCurrentRelicCount() end
---@param RelicCountMap TMap<EPalRelicType, int32>
function UWBP_Buildup_Player_1_C:SetCurrentRelicCountMap(RelicCountMap) end
---@param RelicTypeArray TArray<EPalRelicType>
function UWBP_Buildup_Player_1_C:AnmEvent_Rankup(RelicTypeArray) end
function UWBP_Buildup_Player_1_C:Destruct() end
function UWBP_Buildup_Player_1_C:BndEvt__WBP_Buildup_Player_1_WBP_CommonButton_Confirm_K2Node_ComponentBoundEvent_0_OnClicked__DelegateSignature() end
function UWBP_Buildup_Player_1_C:BndEvt__WBP_Buildup_Player_1_WBP_Menu_btn_Close_K2Node_ComponentBoundEvent_1_OnButtonClicked__DelegateSignature() end
function UWBP_Buildup_Player_1_C:Construct() end
---@param EntryPoint int32
function UWBP_Buildup_Player_1_C:ExecuteUbergraph_WBP_Buildup_Player_1(EntryPoint) end
function UWBP_Buildup_Player_1_C:OnClickedCloseButton__DelegateSignature() end
function UWBP_Buildup_Player_1_C:OnClickedConfirm__DelegateSignature() end


