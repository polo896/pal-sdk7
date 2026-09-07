---@meta

---@class UWBP_OperatingTable_TabPage_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_PassiveSelect UWidgetAnimation
---@field Anm_GenderChange UWidgetAnimation
---@field Anm_GenderDefault UWidgetAnimation
---@field Anm_ON UWidgetAnimation
---@field Anm_Empty UWidgetAnimation
---@field BP_PalTextBlock_Num UBP_PalTextBlock_C
---@field Canvas_Gender UCanvasPanel
---@field Canvas_HighlightEff_1 UCanvasPanel
---@field Canvas_Money UCanvasPanel
---@field Canvas_PassiveSkill UCanvasPanel
---@field Canvas_RequireMoney UCanvasPanel
---@field Canvas_ResetInfo UCanvasPanel
---@field Canvas_Skill UCanvasPanel
---@field CanvasPanel_Overall UCanvasPanel
---@field Image_Item_Selectframe UImage
---@field Image_Money UImage
---@field Image_NoItem UImage
---@field Image_Skill_Selectframe UImage
---@field Image_Symbol_After UImage
---@field Image_Symbol_Before UImage
---@field Image_Symbol_Result UImage
---@field Text_Now_Money_Num UBP_PalTextBlock_C
---@field Text_PassiveName UBP_PalTextBlock_C
---@field Text_RequireMoney_Num UBP_PalTextBlock_C
---@field Text_SkillSelectGuide UBP_PalTextBlock_C
---@field Text_Warning UBP_PalTextBlock_C
---@field VerticalBox_87 UVerticalBox
---@field WBP_CommonButton UWBP_CommonButton_C
---@field WBP_IngameMenu_WorkSpace_Item UWBP_IngameMenu_WorkSpace_Item_C
---@field WBP_MainMenu_Pal_Skill_Passive UWBP_MainMenu_Pal_Skill_Passive_C
---@field WBP_MainMenu_Pal_Skill_Passive_1 UWBP_MainMenu_Pal_Skill_Passive_C
---@field WBP_MainMenu_Pal_Skill_Passive_2 UWBP_MainMenu_Pal_Skill_Passive_C
---@field WBP_MainMenu_Pal_Skill_Passive_3 UWBP_MainMenu_Pal_Skill_Passive_C
---@field WBP_NoData UWBP_NoData_C
---@field WBP_PalInGameMenuItemIcon UWBP_PalInGameMenuItemIcon_C
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnRequireChangeSelectItem FWBP_OperatingTable_TabPage_COnRequireChangeSelectItem
---@field Passives TArray<UWBP_MainMenu_Pal_Skill_Passive_C>
---@field CachedCharacter UPalIndividualCharacterParameter
---@field OnSelectedPassiveIndex FWBP_OperatingTable_TabPage_COnSelectedPassiveIndex
---@field OnHoveredOtomoPassiveSlot FWBP_OperatingTable_TabPage_COnHoveredOtomoPassiveSlot
---@field OnUnhoveredOtomoPassiveSlot FWBP_OperatingTable_TabPage_COnUnhoveredOtomoPassiveSlot
---@field CachedPassiveSlotIndex int32
---@field EnabledButton boolean
---@field RequestChangePassiveSkill FWBP_OperatingTable_TabPage_CRequestChangePassiveSkill
---@field CurrentPassiveList TArray<FName>
---@field RequestChangeGender FWBP_OperatingTable_TabPage_CRequestChangeGender
---@field CurrentPassiveId FName
---@field CurrentRequireMoney int32
---@field CurrentConsumable boolean
---@field RequireConsumeItem boolean
---@field CurrentCurrency FName
local UWBP_OperatingTable_TabPage_C = {}

---@param NewMoney int64
UWBP_OperatingTable_TabPage_C['On Money Changed'] = function(self, NewMoney) end
UWBP_OperatingTable_TabPage_C['On Update Local Player Inventory'] = function(self, ) end
---@param NowMoney int64
UWBP_OperatingTable_TabPage_C['On Update Money'] = function(self, NowMoney) end
function UWBP_OperatingTable_TabPage_C:RefreshCurrentPassiveItem() end
---@param UpdateItemNum FName
function UWBP_OperatingTable_TabPage_C:UpdateNum(UpdateItemNum) end
function UWBP_OperatingTable_TabPage_C:ReflectGenderChange() end
function UWBP_OperatingTable_TabPage_C:ReflectPassiveChange() end
UWBP_OperatingTable_TabPage_C['Update Button State'] = function(self, ) end
---@param SelfWidget UWBP_MainMenu_Pal_Skill_Passive_C
function UWBP_OperatingTable_TabPage_C:OnUnhoveredPassiveSlot(SelfWidget) end
---@param SelfWidget UWBP_MainMenu_Pal_Skill_Passive_C
function UWBP_OperatingTable_TabPage_C:OnHoveredPassiveSlot(SelfWidget) end
---@param Widget UWidget
function UWBP_OperatingTable_TabPage_C:GetFocusTarget(Widget) end
---@param SelfWidget UWBP_MainMenu_Pal_Skill_Passive_C
function UWBP_OperatingTable_TabPage_C:OnSelectPassiveSlot(SelfWidget) end
UWBP_OperatingTable_TabPage_C['Set Gender Reverse'] = function(self, ) end
---@param PassiveId FName
UWBP_OperatingTable_TabPage_C['Set Passive Has Item'] = function(self, PassiveId) end
UWBP_OperatingTable_TabPage_C['Set Passive Empty Item'] = function(self, ) end
---@param ToPassive boolean
function UWBP_OperatingTable_TabPage_C:SwitchPanel(ToPassive) end
function UWBP_OperatingTable_TabPage_C:Anm_EmptyLoop() end
function UWBP_OperatingTable_TabPage_C:Anm_SetItem() end
function UWBP_OperatingTable_TabPage_C:AnmEvent_GenderReverse() end
function UWBP_OperatingTable_TabPage_C:AnmEvent_GenderPanelDefault() end
function UWBP_OperatingTable_TabPage_C:AnmEvent_PassiveHighlight() end
---@param Button UCommonButtonBase
function UWBP_OperatingTable_TabPage_C:BndEvt__WBP_OperatingTable_TabPage_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_OperatingTable_TabPage_C:OnInitialized() end
function UWBP_OperatingTable_TabPage_C:Construct() end
function UWBP_OperatingTable_TabPage_C:BndEvt__WBP_OperatingTable_TabPage_WBP_CommonButton_K2Node_ComponentBoundEvent_1_OnClicked__DelegateSignature() end
---@param OK boolean
function UWBP_OperatingTable_TabPage_C:ConfirmPassiveOperate(OK) end
---@param ConsumeItemId FName
function UWBP_OperatingTable_TabPage_C:UpdateCurrentConsumeItem(ConsumeItemId) end
---@param EntryPoint int32
function UWBP_OperatingTable_TabPage_C:ExecuteUbergraph_WBP_OperatingTable_TabPage(EntryPoint) end
---@param CharacterParam UPalIndividualCharacterParameter
function UWBP_OperatingTable_TabPage_C:RequestChangeGender__DelegateSignature(CharacterParam) end
---@param PassiveId FName
---@param SlotIndex int32
function UWBP_OperatingTable_TabPage_C:RequestChangePassiveSkill__DelegateSignature(PassiveId, SlotIndex) end
function UWBP_OperatingTable_TabPage_C:OnUnhoveredOtomoPassiveSlot__DelegateSignature() end
---@param Widget UWBP_MainMenu_Pal_Skill_Passive_C
function UWBP_OperatingTable_TabPage_C:OnHoveredOtomoPassiveSlot__DelegateSignature(Widget) end
---@param Index int32
function UWBP_OperatingTable_TabPage_C:OnSelectedPassiveIndex__DelegateSignature(Index) end
function UWBP_OperatingTable_TabPage_C:OnRequireChangeSelectItem__DelegateSignature() end


