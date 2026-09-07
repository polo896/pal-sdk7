---@meta

---@class UWBP_WorkSuitabilityPreferenceMenu_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field HorizontalBox_WorkIcon UHorizontalBox
---@field Image_Icon_Change UImage
---@field Text_WorkerNum UBP_PalTextBlock_C
---@field WBP_IngameMenu_PalBox_PalDetail UWBP_IngameMenu_PalBox_PalDetail_C
---@field WBP_Menu_btn_Close UWBP_Menu_btn_C
---@field WBP_NoData UWBP_NoData_C
---@field WBP_PalCommonScrollList_PalList UWBP_PalCommonScrollList_C
---@field WBP_PalKeyGuideIcon UWBP_PalKeyGuideIcon_C
---@field OnClickedCloseButton FWBP_WorkSuitabilityPreferenceMenu_COnClickedCloseButton
---@field SuitabilityIconArray TArray<UWBP_IconPalWork_C>
---@field SoftTargetContainer TSoftObjectPtr<UPalIndividualCharacterContainer>
---@field OnChangedSuitabilitySetting FWBP_WorkSuitabilityPreferenceMenu_COnChangedSuitabilitySetting
---@field OnChangedBattleModeSetting FWBP_WorkSuitabilityPreferenceMenu_COnChangedBattleModeSetting
---@field NowDisplayingCharacterHandle TSoftObjectPtr<UPalIndividualCharacterHandle>
---@field LastHoveredListWidget UWBP_WorlSuitabilityPreference_PalList_C
---@field bEnableOperation boolean
local UWBP_WorkSuitabilityPreferenceMenu_C = {}

function UWBP_WorkSuitabilityPreferenceMenu_C:UpdateOperationPermission() end
---@param bEnableOperation boolean
function UWBP_WorkSuitabilityPreferenceMenu_C:SetOperationPermission(bEnableOperation) end
---@param TargetListDistance int32
---@return UWidget
function UWBP_WorkSuitabilityPreferenceMenu_C:GetNextListFocusTarget(TargetListDistance) end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_WorkSuitabilityPreferenceMenu_C:CustomNavi_DownList(Navigation) end
---@param Navigation EUINavigation
---@return UWidget
function UWBP_WorkSuitabilityPreferenceMenu_C:CustomNavi_UpList(Navigation) end
---@param SelfWidget UWBP_WorlSuitabilityPreference_PalList_C
function UWBP_WorkSuitabilityPreferenceMenu_C:OnHoveredAnyCheckBox_Internal(SelfWidget) end
---@param Slot UHorizontalBoxSlot
function UWBP_WorkSuitabilityPreferenceMenu_C:ArrangeHorizontalBoxSlot_ForSuitabilityIcon(Slot) end
---@param IsChecked boolean
---@param TargetSlot UPalIndividualCharacterSlot
function UWBP_WorkSuitabilityPreferenceMenu_C:OnChangedBattleModeCheck_Internal(IsChecked, TargetSlot) end
---@param IsChecked boolean
---@param Suitability EPalWorkSuitability
---@param TargetSlot UPalIndividualCharacterSlot
function UWBP_WorkSuitabilityPreferenceMenu_C:OnChangedSuitabilityCheck_Internal(IsChecked, Suitability, TargetSlot) end
function UWBP_WorkSuitabilityPreferenceMenu_C:UpdateWorkerNum() end
---@param Slot UPalIndividualCharacterSlot
---@param LastHandle UPalIndividualCharacterHandle
function UWBP_WorkSuitabilityPreferenceMenu_C:OnUpdateSlotHandle(Slot, LastHandle) end
---@param IsEnableInfo boolean
function UWBP_WorkSuitabilityPreferenceMenu_C:SetEnableWorkerInfo(IsEnableInfo) end
function UWBP_WorkSuitabilityPreferenceMenu_C:SetupSuitabilityIcon() end
---@param Target UWidget
function UWBP_WorkSuitabilityPreferenceMenu_C:GetTopFocusTarget_PalList(Target) end
---@param TargetWidget UWidget
function UWBP_WorkSuitabilityPreferenceMenu_C:GetTopFocusTarget(TargetWidget) end
---@param Container UPalIndividualCharacterContainer
function UWBP_WorkSuitabilityPreferenceMenu_C:SetTargetContainer(Container) end
function UWBP_WorkSuitabilityPreferenceMenu_C:Construct() end
function UWBP_WorkSuitabilityPreferenceMenu_C:Destruct() end
function UWBP_WorkSuitabilityPreferenceMenu_C:BndEvt__WBP_WorkSuitabilityPreferenceMenu_WBP_Menu_btn_Close_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
function UWBP_WorkSuitabilityPreferenceMenu_C:OnInitialized() end
---@param EntryPoint int32
function UWBP_WorkSuitabilityPreferenceMenu_C:ExecuteUbergraph_WBP_WorkSuitabilityPreferenceMenu(EntryPoint) end
---@param CanBattle boolean
---@param Slot UPalIndividualCharacterSlot
function UWBP_WorkSuitabilityPreferenceMenu_C:OnChangedBattleModeSetting__DelegateSignature(CanBattle, Slot) end
---@param IsOn boolean
---@param Suitability EPalWorkSuitability
---@param TargetSlot UPalIndividualCharacterSlot
function UWBP_WorkSuitabilityPreferenceMenu_C:OnChangedSuitabilitySetting__DelegateSignature(IsOn, Suitability, TargetSlot) end
function UWBP_WorkSuitabilityPreferenceMenu_C:OnClickedCloseButton__DelegateSignature() end


