---@meta

---@class UWBP_CharacterSkinChanger_C : UPalUICharacterSkinChanger
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Canvas_Inframe UCanvasPanel
---@field CanvasPanel_ApplySkinCharacterSelect UCanvasPanel
---@field CanvasPanel_SelectSkin UCanvasPanel
---@field CanvasPanel_SelectSkinCharacter UCanvasPanel
---@field Image_71 UImage
---@field Image_Floor UImage
---@field Image_Floor_1 UImage
---@field Image_PalReflection UImage
---@field Overlay_InframeRender_SelectSkin UOverlay
---@field Overlay_InframeRender_SelectSkinCharacter UOverlay
---@field Overlay_WaitInitialize UOverlay
---@field PalScrollBox_SelectCharacter UPalScrollBox
---@field PalScrollBox_SelectSkin UPalScrollBox
---@field WBP_Common_LoadingIcon UWBP_Common_LoadingIcon_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WBP_PalMonsterInframeRender UWBP_PalMonsterInframeRender_C
---@field WBP_PalStorageMenu_ForSkinChanger UWBP_PalStorageMenu_ForSkinChanger_C
---@field WBP_WaitInitialize UWBP_NoData_C
---@field WidgetSwitcher_109 UWidgetSwitcher
---@field SequenceType E_PalUISkinChangerSequenceType::Type
---@field SelectedSkinName FName
---@field SelectedSoftTargetSlot TSoftObjectPtr<UPalIndividualCharacterSlot>
---@field SelectedCharacterID FName
---@field DIalogMsgID_NoSkin FDataTableRowHandle
---@field DIalogMsgID_OverwriteSkin FDataTableRowHandle
---@field WaitInitializeMsgID FDataTableRowHandle
---@field RemoveSkinMsgID FDataTableRowHandle
---@field DialogMsgID_Remove FDataTableRowHandle
---@field SelectedCharacterPanel TSoftObjectPtr<UWBP_Paldex_List_C>
---@field isButton1Clicked boolean
---@field SkinUpdateBindedCharacterParam UPalIndividualCharacterParameter
local UWBP_CharacterSkinChanger_C = {}

---@param NewSkinName FName
function UWBP_CharacterSkinChanger_C:CREATEDELEGATE_PROXYFUNCTION_1(NewSkinName) end
---@param NewSkinName FName
function UWBP_CharacterSkinChanger_C:CREATEDELEGATE_PROXYFUNCTION_0(NewSkinName) end
---@param SkinName FName
function UWBP_CharacterSkinChanger_C:OnSkinUpdated(SkinName) end
---@param bNewInputType ECommonInputType
function UWBP_CharacterSkinChanger_C:OnChangedInputMehotd(bNewInputType) end
---@param CharacterID FName
---@param SelfWidget UWBP_Paldex_List_C
function UWBP_CharacterSkinChanger_C:OnHoveredRemoveSkinButton(CharacterID, SelfWidget) end
---@param bResult boolean
UWBP_CharacterSkinChanger_C['On Closed Remove Skin Dialog'] = function(self, bResult) end
---@param CharacterID FName
---@param Widget UWBP_Paldex_List_C
function UWBP_CharacterSkinChanger_C:OnClickedRemoveSkinButton(CharacterID, Widget) end
---@param CharacterID FName
---@param SelfWidget UWBP_Paldex_List_C
function UWBP_CharacterSkinChanger_C:OnHoveredSkinPanel(CharacterID, SelfWidget) end
---@param CharacterID FName
---@param SelfWidget UWBP_Paldex_List_C
function UWBP_CharacterSkinChanger_C:OnHoveredCharacterPanel(CharacterID, SelfWidget) end
---@param SkinName FName
---@param SkinNameText FText
UWBP_CharacterSkinChanger_C['Get Localized Skin Name'] = function(self, SkinName, SkinNameText) end
---@param TargetCharacterParameter UPalIndividualCharacterParameter
UWBP_CharacterSkinChanger_C['Open Remove Skin Dialog'] = function(self, TargetCharacterParameter) end
---@param TargetCharacterParameter UPalIndividualCharacterParameter
function UWBP_CharacterSkinChanger_C:OpenChangeSkinDIalog(TargetCharacterParameter) end
---@param ID FGuid
function UWBP_CharacterSkinChanger_C:GetNowInsideBaseCampId(ID) end
---@param bResult boolean
function UWBP_CharacterSkinChanger_C:OnClosedCheckDialog(bResult) end
---@param CharacterID FName
---@param Widget UWBP_Paldex_List_C
function UWBP_CharacterSkinChanger_C:OnClickedSkinPanel(CharacterID, Widget) end
---@param CharacterID FName
function UWBP_CharacterSkinChanger_C:SetupSkinList(CharacterID) end
---@param CharacterID FName
---@param Widget UWBP_Paldex_List_C
function UWBP_CharacterSkinChanger_C:OnClickedCharacterPanel(CharacterID, Widget) end
function UWBP_CharacterSkinChanger_C:SetupExistSkinCharacterList() end
function UWBP_CharacterSkinChanger_C:OnCancelAction() end
function UWBP_CharacterSkinChanger_C:OnUpdateSkillInfo() end
---@return UWidget
function UWBP_CharacterSkinChanger_C:BP_GetDesiredFocusTarget() end
---@param Widget UWidget
function UWBP_CharacterSkinChanger_C:GetNowSequenceFocusTarget(Widget) end
---@param NewSequence E_PalUISkinChangerSequenceType::Type
function UWBP_CharacterSkinChanger_C:ChangeSequence(NewSequence) end
function UWBP_CharacterSkinChanger_C:OnSetup() end
function UWBP_CharacterSkinChanger_C:Destruct() end
function UWBP_CharacterSkinChanger_C:OnInitialized() end
---@param Slot UPalIndividualCharacterSlot
function UWBP_CharacterSkinChanger_C:BndEvt__WBP_CharacterSkinChanger_WBP_PalStorageMenu_ForSkinChanger_K2Node_ComponentBoundEvent_3_OnClickedAnySlot__DelegateSignature(Slot) end
function UWBP_CharacterSkinChanger_C:BndEvt__WBP_CharacterSkinChanger_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
function UWBP_CharacterSkinChanger_C:BndEvt__WBP_CharacterSkinChanger_WBP_PalStorageMenu_ForSkinChanger_K2Node_ComponentBoundEvent_2_OnClickedCloseButton__DelegateSignature() end
UWBP_CharacterSkinChanger_C['カスタムイベント'] = function(self, ) end
---@param Confirmed boolean
function UWBP_CharacterSkinChanger_C:EmptyEvent(Confirmed) end
function UWBP_CharacterSkinChanger_C:Construct() end
---@param EntryPoint int32
function UWBP_CharacterSkinChanger_C:ExecuteUbergraph_WBP_CharacterSkinChanger(EntryPoint) end


