---@meta

---@class UWBP_Arena_PalSelect_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Out UWidgetAnimation
---@field Anm_In UWidgetAnimation
---@field BP_PalTextBlock_RivalName UBP_PalTextBlock_C
---@field BP_PalTextBlock_SelfName UBP_PalTextBlock_C
---@field Canvas_Rival_Selected UCanvasPanel
---@field Text_TimerNum UBP_PalTextBlock_C
---@field WBP_Arena_PalDetail UWBP_Arena_PalDetail_C
---@field WBP_Arena_PalSelect_PalSlot_Main UWBP_Arena_PalSelect_PalSlot_C
---@field WBP_Arena_PalSelect_PalSlot_Main_R UWBP_Arena_PalSelect_PalSlot_C
---@field WBP_Arena_PalSelect_PalSlot_Sub_0 UWBP_Arena_PalSelect_PalSlot_C
---@field WBP_Arena_PalSelect_PalSlot_Sub_1 UWBP_Arena_PalSelect_PalSlot_C
---@field WBP_Arena_PalSelect_PalSlot_Sub_0R UWBP_Arena_PalSelect_PalSlot_C
---@field WBP_Arena_PalSelect_PalSlot_Sub_1R UWBP_Arena_PalSelect_PalSlot_C
---@field WBP_Arena_PalSelect_Ready UWBP_Arena_PalSelect_Ready_C
---@field WBP_Arena_PalSelect_Ready_1 UWBP_Arena_PalSelect_Ready_C
---@field WBP_CommonButton_Ready UWBP_CommonButton_2_C
---@field WBP_Menu_PalList UWBP_Menu_PalList_C
---@field WBP_Menu_PalList_1 UWBP_Menu_PalList_C
---@field WBP_Menu_PalList_2 UWBP_Menu_PalList_C
---@field WBP_Menu_PalList_3 UWBP_Menu_PalList_C
---@field WBP_Menu_PalList_4 UWBP_Menu_PalList_C
---@field WBP_Menu_PalList_5 UWBP_Menu_PalList_C
---@field WBP_Menu_PalList_6 UWBP_Menu_PalList_C
---@field WBP_Menu_PalList_7 UWBP_Menu_PalList_C
---@field WBP_Menu_PalList_8 UWBP_Menu_PalList_C
---@field WBP_Menu_PalList_9 UWBP_Menu_PalList_C
---@field ['As Pal HUDDispatch Parameter Arena Pal Select'] UPalHUDDispatchParameter_ArenaPalSelect
---@field OnPartySet FWBP_Arena_PalSelect_COnPartySet
---@field SelfPalList TArray<UWBP_Menu_PalList_C>
---@field RivalPalList TArray<UWBP_Menu_PalList_C>
---@field ['Arena Sequencer'] UPalArenaSequencer
---@field EnableDetailPanel boolean
---@field CurrentParty FPalArenaPlayerParty
---@field CurrentHoverHandle UPalIndividualCharacterHandle
---@field ConfirmDialog FGuid
---@field CurrentSelectPalTribes TArray<EPalTribeID>
---@field IsSpectator boolean
local UWBP_Arena_PalSelect_C = {}

---@param Party FPalArenaPlayerParty
UWBP_Arena_PalSelect_C['Update Rival Party Slot'] = function(self, Party) end
UWBP_Arena_PalSelect_C['Cancel Spect'] = function(self, ) end
---@param Rule FPalArenaRule
---@param individualParam UPalIndividualCharacterParameter
---@param IsRestricted boolean
function UWBP_Arena_PalSelect_C:IsRestrictedSelect(Rule, individualParam, IsRestricted) end
function UWBP_Arena_PalSelect_C:CancelSoloMatch() end
function UWBP_Arena_PalSelect_C:ShowArenaRule() end
function UWBP_Arena_PalSelect_C:ToggleDetailVisibility() end
---@return UWidget
function UWBP_Arena_PalSelect_C:BP_GetDesiredFocusTarget() end
---@param Time double
UWBP_Arena_PalSelect_C['On Timer Updated'] = function(self, Time) end
---@param CurrentParty FPalArenaPlayerParty
---@param IsRival boolean
UWBP_Arena_PalSelect_C['Update Party Count UI'] = function(self, CurrentParty, IsRival) end
UWBP_Arena_PalSelect_C['Update Local Party Slot'] = function(self, ) end
---@param PlayerIndex EPalArenaPlayerIndex
---@param Party FPalArenaPlayerParty
UWBP_Arena_PalSelect_C['On Party Updated'] = function(self, PlayerIndex, Party) end
---@param CharacterHandle UPalIndividualCharacterHandle
UWBP_Arena_PalSelect_C['Toggle Select Party'] = function(self, CharacterHandle) end
---@param CharacterHandle UPalIndividualCharacterHandle
UWBP_Arena_PalSelect_C['Display Detail'] = function(self, CharacterHandle) end
function UWBP_Arena_PalSelect_C:CloseDetail() end
---@param PalList TArray<UPalIndividualCharacterParameter>
---@param IsRival boolean
function UWBP_Arena_PalSelect_C:SetupPalList(PalList, IsRival) end
function UWBP_Arena_PalSelect_C:SetupCharacterName() end
---@param IsSoloMode boolean
function UWBP_Arena_PalSelect_C:Setup(IsSoloMode) end
function UWBP_Arena_PalSelect_C:Finished_6CCB6F4C49947D6ED3DAE8939CE96337() end
function UWBP_Arena_PalSelect_C:OnSetup() end
function UWBP_Arena_PalSelect_C:BndEvt__WBP_Arena_PalSelect_WBP_CommonButton_2_K2Node_ComponentBoundEvent_0_OnClicked__DelegateSignature() end
function UWBP_Arena_PalSelect_C:OnInitialized() end
function UWBP_Arena_PalSelect_C:EmptyEvent() end
---@param Confirmed boolean
function UWBP_Arena_PalSelect_C:ConfirmParty(Confirmed) end
function UWBP_Arena_PalSelect_C:ClosePanel() end
---@param IsConfirm boolean
function UWBP_Arena_PalSelect_C:EmptyConfirm(IsConfirm) end
function UWBP_Arena_PalSelect_C:AnmEvent_In() end
---@param Sequencer UPalArenaSequencer
---@param PrevType EPalArenaSequenceType
---@param AfterType EPalArenaSequenceType
function UWBP_Arena_PalSelect_C:OnUpdateSequence(Sequencer, PrevType, AfterType) end
---@param EntryPoint int32
function UWBP_Arena_PalSelect_C:ExecuteUbergraph_WBP_Arena_PalSelect(EntryPoint) end
---@param NewParty FPalArenaPlayerParty
function UWBP_Arena_PalSelect_C:OnPartySet__DelegateSignature(NewParty) end


