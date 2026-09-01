---@meta

---@class UWBP_OperatingTable_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Canvas_ItemList UCanvasPanel
---@field CanvasPanel_1 UCanvasPanel
---@field HorizontalBox_Tab UHorizontalBox
---@field Select UImage
---@field Text_GuildMenberHead UBP_PalTextBlock_C
---@field WBP_Buildup_TabButton_Gender UWBP_Buildup_TabButton_C
---@field WBP_Buildup_TabButton_Passive UWBP_Buildup_TabButton_C
---@field WBP_IngameMenu_PalBox_PalDetail UWBP_IngameMenu_PalBox_PalDetail_C
---@field WBP_MainMenu_PalSkillInfo UWBP_MainMenu_PalSkillInfo_C
---@field WBP_Menu_btn_Close UWBP_Menu_btn_C
---@field WBP_Menu_btn_ListClose UWBP_Menu_btn_C
---@field WBP_Menu_PalList UWBP_Menu_PalList_C
---@field WBP_Menu_PalList_1 UWBP_Menu_PalList_C
---@field WBP_Menu_PalList_2 UWBP_Menu_PalList_C
---@field WBP_Menu_PalList_3 UWBP_Menu_PalList_C
---@field WBP_Menu_PalList_4 UWBP_Menu_PalList_C
---@field WBP_OperatingTable_TabPage UWBP_OperatingTable_TabPage_C
---@field WBP_PalCommonScrollList_Item UWBP_PalCommonScrollList_C
---@field WBP_PalCommonWindow UWBP_PalCommonWindow_C
---@field WBP_PalKeyGuideIcon_1 UWBP_PalKeyGuideIcon_C
---@field PalList TArray<UWBP_Menu_PalList_C>
---@field OperatingTableModel UPalMapObjectOperatingTableModel
---@field Hovering boolean
---@field CurrentHandle UPalIndividualCharacterHandle
---@field PinDetail boolean
---@field Requested boolean
---@field CurrentTab int32
---@field ParamUpdated boolean
---@field Notified boolean
---@field BindedCharacterParam UPalIndividualCharacterParameter
---@field Updated boolean
---@field CachedConsumeItemId FName
---@field RefreshTimer FTimerHandle
local UWBP_OperatingTable_C = {}

function UWBP_OperatingTable_C:RefreshItemDisplay() end
---@param Widget UWBP_MainMenu_Pal_Skill_Passive_C
function UWBP_OperatingTable_C:OnHoveredPalPassiveSlot(Widget) end
function UWBP_OperatingTable_C:OnUnhoveredPasssiveItem() end
---@param Widget UWBP_OperatingTable_ItemList_C
function UWBP_OperatingTable_C:OnHoveredPassiveItem(Widget) end
---@param PassiveId FName
---@param ConsumeItemId FName
UWBP_OperatingTable_C['On Select Passive Change'] = function(self, PassiveId, ConsumeItemId) end
---@return UWidget
function UWBP_OperatingTable_C:BP_GetDesiredFocusTarget() end
function UWBP_OperatingTable_C:SetupPassiveChangeItem() end
function UWBP_OperatingTable_C:CloseAction() end
---@param Handle UPalIndividualCharacterHandle
UWBP_OperatingTable_C['On Click Pal List'] = function(self, Handle) end
function UWBP_OperatingTable_C:OnUnhoverPalList() end
---@param Handle UPalIndividualCharacterHandle
function UWBP_OperatingTable_C:OnHoverPalList(Handle) end
function UWBP_OperatingTable_C:Setup() end
function UWBP_OperatingTable_C:OnSetup() end
function UWBP_OperatingTable_C:OnInitialized() end
---@param Success boolean
function UWBP_OperatingTable_C:OnOperatingPassiveNotifyied(Success) end
function UWBP_OperatingTable_C:Destruct() end
function UWBP_OperatingTable_C:BndEvt__WBP_OperatingTable_WBP_Menu_btn_Close_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
function UWBP_OperatingTable_C:SwitchPassive() end
function UWBP_OperatingTable_C:SwitchGender() end
---@param Tab int32
function UWBP_OperatingTable_C:SwitchTab(Tab) end
function UWBP_OperatingTable_C:BndEvt__WBP_OperatingTable_WBP_OperatingTable_TabPage_K2Node_ComponentBoundEvent_1_OnRequireChangeSelectItem__DelegateSignature() end
function UWBP_OperatingTable_C:BndEvt__WBP_OperatingTable_WBP_Menu_btn_ListClose_K2Node_ComponentBoundEvent_2_OnButtonClicked__DelegateSignature() end
---@param Widget UWBP_MainMenu_Pal_Skill_Passive_C
function UWBP_OperatingTable_C:BndEvt__WBP_OperatingTable_WBP_OperatingTable_TabPage_K2Node_ComponentBoundEvent_3_OnHoveredOtomoPassiveSlot__DelegateSignature(Widget) end
function UWBP_OperatingTable_C:BndEvt__WBP_OperatingTable_WBP_OperatingTable_TabPage_K2Node_ComponentBoundEvent_4_OnUnhoveredOtomoPassiveSlot__DelegateSignature() end
---@param PassiveId FName
---@param SlotIndex int32
function UWBP_OperatingTable_C:BndEvt__WBP_OperatingTable_WBP_OperatingTable_TabPage_K2Node_ComponentBoundEvent_6_RequestChangePassiveSkill__DelegateSignature(PassiveId, SlotIndex) end
---@param Success boolean
function UWBP_OperatingTable_C:OnOperatingGenderNotifyied(Success) end
---@param CharacterParam UPalIndividualCharacterParameter
function UWBP_OperatingTable_C:BndEvt__WBP_OperatingTable_WBP_OperatingTable_TabPage_K2Node_ComponentBoundEvent_5_RequestChangeGender__DelegateSignature(CharacterParam) end
---@param PassiveIds TArray<FName>
function UWBP_OperatingTable_C:OnPassiveUpdate(PassiveIds) end
---@param NewGender EPalGenderType
function UWBP_OperatingTable_C:OnGenderUpdate(NewGender) end
---@param EntryPoint int32
function UWBP_OperatingTable_C:ExecuteUbergraph_WBP_OperatingTable(EntryPoint) end


