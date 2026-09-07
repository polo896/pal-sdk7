---@meta

---@class UWBP_IngameMenu_PalCondense_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_SelectFull UWidgetAnimation
---@field Anm_SelectMaterialPal UWidgetAnimation
---@field Anm_SelectMainPal UWidgetAnimation
---@field CanvasPanelGet UCanvasPanel
---@field HorizontalBox_PalWorkIcon UHorizontalBox
---@field ProgressBar_Extract UProgressBar
---@field Text_LevelValue UBP_PalTextBlock_C
---@field Text_PalExtractNum UBP_PalTextBlock_C
---@field Text_PalName UBP_PalTextBlock_C
---@field Text_RegisterPalNumValue UBP_PalTextBlock_C
---@field Text_StatusNum_AftAtk UBP_PalTextBlock_C
---@field Text_StatusNum_AftDef UBP_PalTextBlock_C
---@field Text_StatusNum_AftHp UBP_PalTextBlock_C
---@field Text_StatusNum_PreDef UBP_PalTextBlock_C
---@field Text_StatusNum_PrevAtk UBP_PalTextBlock_C
---@field Text_StatusNum_PrevHP UBP_PalTextBlock_C
---@field WBP_BoxPalList_Party UWBP_BoxPalList_Party_C
---@field WBP_CommonButton_Invoke UWBP_CommonButton_C
---@field WBP_IngameMenu_PalBox_PalDetail UWBP_IngameMenu_PalBox_PalDetail_C
---@field WBP_MainMenu_Pal_Skill_Unique UWBP_MainMenu_Pal_Skill_Unique_C
---@field WBP_MainMenu_PalRarityStar_0 UWBP_MainMenu_PalRarityStar_C
---@field WBP_MainMenu_PalRarityStar_1 UWBP_MainMenu_PalRarityStar_C
---@field WBP_MainMenu_PalRarityStar_2 UWBP_MainMenu_PalRarityStar_C
---@field WBP_MainMenu_PalRarityStar_3 UWBP_MainMenu_PalRarityStar_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WBP_PalCommonCharacterIcon UWBP_PalCommonCharacterIcon_C
---@field WBP_PalKeyGuideIcon_211 UWBP_PalKeyGuideIcon_C
---@field BoxNameMsgID FDataTableRowHandle
---@field ConfirmMsgID FDataTableRowHandle
---@field SuccessMsgID FDataTableRowHandle
---@field Model UPalUIPalCharacterRankUpModel
---@field InputActionControllerInvokeName FName
---@field PartyPalSlots TArray<UWBP_PalCommonCharacterSlotButton_C>
---@field RarityStars TArray<UWBP_MainMenu_PalRarityStar_C>
---@field BasePalHandle UPalIndividualCharacterHandle
---@field BasePalSlot UWBP_PalCommonCharacterSlotButton_C
---@field CurrentConsumePalSlots TArray<UWBP_PalCommonCharacterSlotButton_C>
---@field CanInvoke boolean
---@field TempSlots TArray<UPalIndividualCharacterSlot>
---@field HighRankMsgID FDataTableRowHandle
---@field MaxRankMsgID FDataTableRowHandle
---@field WarningLevel int32
---@field OverflowRankUpExpMsgID FDataTableRowHandle
---@field CurrentTribeCount int32
---@field DialogText FText
---@field OnePageSelectAction FPalUIActionBindData
---@field OnePageUnselectAction FPalUIActionBindData
---@field FavoriteInputHandle FPalUIActionBindData
---@field FavoriteShortcutInput FPalDataTableRowName_UIInputAction
---@field CachedSlot UWBP_PalCharacterSlotButtonBase_C
local UWBP_IngameMenu_PalCondense_C = {}

---@param individualParam UPalIndividualCharacterParameter
---@param IsEnable boolean
function UWBP_IngameMenu_PalCondense_C:CheckResourceSlotEnable(individualParam, IsEnable) end
UWBP_IngameMenu_PalCondense_C['On Favorite Shortcut'] = function(self, ) end
function UWBP_IngameMenu_PalCondense_C:UnregistSlotInputAction() end
function UWBP_IngameMenu_PalCondense_C:RegistSlotInputAction() end
function UWBP_IngameMenu_PalCondense_C:OnePageUnselect() end
function UWBP_IngameMenu_PalCondense_C:OnePageSelect() end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_IngameMenu_PalCondense_C:DoCustomNavi_ToBoxRightBottom(Navigation) end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_IngameMenu_PalCondense_C:DoCustomNavi_ToInvokeButton(Navigation) end
function UWBP_IngameMenu_PalCondense_C:RequestInvoke() end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_IngameMenu_PalCondense_C:SetupBoxSlot(Slot) end
function UWBP_IngameMenu_PalCondense_C:GetWarningLevel() end
function UWBP_IngameMenu_PalCondense_C:UpdateBaseCharacterSimulateStatus() end
function UWBP_IngameMenu_PalCondense_C:UpdateGauge() end
UWBP_IngameMenu_PalCondense_C['Update Simulation'] = function(self, ) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
---@param PressType EPalItemSlotPressType
UWBP_IngameMenu_PalCondense_C['On Click Slot'] = function(self, Slot, PressType) end
UWBP_IngameMenu_PalCondense_C['Cancel Condense'] = function(self, ) end
UWBP_IngameMenu_PalCondense_C['Get Consumeable Pal'] = function(self, ) end
---@param individualParam UPalIndividualCharacterParameter
function UWBP_IngameMenu_PalCondense_C:SetWorkSuitability(individualParam) end
---@param Rank int32
---@param ToRank int32
function UWBP_IngameMenu_PalCondense_C:SetRank(Rank, ToRank) end
---@param IndividualHandle UPalIndividualCharacterHandle
function UWBP_IngameMenu_PalCondense_C:SetBasePal(IndividualHandle) end
---@return UWidget
function UWBP_IngameMenu_PalCondense_C:BP_GetDesiredFocusTarget() end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_IngameMenu_PalCondense_C:OnUnhoverPalSlot(Slot) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_IngameMenu_PalCondense_C:OnHoverPalSlot(Slot) end
function UWBP_IngameMenu_PalCondense_C:Setup() end
function UWBP_IngameMenu_PalCondense_C:OnCancelAction() end
function UWBP_IngameMenu_PalCondense_C:OnSetup() end
function UWBP_IngameMenu_PalCondense_C:Destruct() end
function UWBP_IngameMenu_PalCondense_C:BndEvt__WBP_IngameMenu_PalCondense_WBP_CommonButton_K2Node_ComponentBoundEvent_3_OnClicked__DelegateSignature() end
---@param IsConfirmed boolean
function UWBP_IngameMenu_PalCondense_C:ReceiveConfirmInvokeRankup(IsConfirmed) end
---@param Result EPalMapObjectRankUpCharacterResult
function UWBP_IngameMenu_PalCondense_C:OnRankupResultNotified(Result) end
---@param bResult boolean
function UWBP_IngameMenu_PalCondense_C:ConfirmSuccess(bResult) end
function UWBP_IngameMenu_PalCondense_C:BndEvt__WBP_IngameMenu_PalCondense_WBP_Menu_btn_K2Node_ComponentBoundEvent_4_OnButtonClicked__DelegateSignature() end
---@param bResult boolean
function UWBP_IngameMenu_PalCondense_C:MaxRankConfirm(bResult) end
---@param bResult boolean
function UWBP_IngameMenu_PalCondense_C:ReceiveConfirmOverflowRankUpExp(bResult) end
function UWBP_IngameMenu_PalCondense_C:ActionInvokeRankUp() end
function UWBP_IngameMenu_PalCondense_C:ConfirmInvokeRankUp() end
---@param IsDesignTime boolean
function UWBP_IngameMenu_PalCondense_C:PreConstruct(IsDesignTime) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_IngameMenu_PalCondense_C:BndEvt__WBP_IngameMenu_PalCondense_WBP_BoxPalList_Party_K2Node_ComponentBoundEvent_2_OnHoverSlot__DelegateSignature(Slot) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_IngameMenu_PalCondense_C:BndEvt__WBP_IngameMenu_PalCondense_WBP_BoxPalList_Party_K2Node_ComponentBoundEvent_5_OnUnhoverSlot__DelegateSignature(Slot) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
function UWBP_IngameMenu_PalCondense_C:BndEvt__WBP_IngameMenu_PalCondense_WBP_BoxPalList_Party_K2Node_ComponentBoundEvent_7_OnCreatedNewSlot__DelegateSignature(Slot) end
---@param Slot UWBP_PalCharacterSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_IngameMenu_PalCondense_C:BndEvt__WBP_IngameMenu_PalCondense_WBP_BoxPalList_Party_K2Node_ComponentBoundEvent_14_OnLeftClickedSlot__DelegateSignature(Slot, PressType) end
function UWBP_IngameMenu_PalCondense_C:Construct() end
---@param EntryPoint int32
function UWBP_IngameMenu_PalCondense_C:ExecuteUbergraph_WBP_IngameMenu_PalCondense(EntryPoint) end


