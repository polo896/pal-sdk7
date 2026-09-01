---@meta

---@class UWBP_WorlSuitabilityPreference_PalList_C : UWBP_IndividualParameterBindWidget_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field CanvasPanel_FixedAssign UCanvasPanel
---@field CanvasPanel_FreeAssign UCanvasPanel
---@field CanvasPanel_PalInfo_Simple UCanvasPanel
---@field CanvasPanel_PalInfo_TaskDetail UCanvasPanel
---@field HorizontalBox_CheckBox UHorizontalBox
---@field Image UImage
---@field Image_PalIcon UImage
---@field Overlay_Night UOverlay
---@field Text_CurrentTask UBP_PalTextBlock_C
---@field Text_Pal_LevelValue UBP_PalTextBlock_C
---@field Text_Pal_name UBP_PalTextBlock_C
---@field Text_Task_Fix UBP_PalTextBlock_C
---@field Text_Task_Free UBP_PalTextBlock_C
---@field Text_Task_Free_1 UBP_PalTextBlock_C
---@field WBP_EnemyGauge_SAN UWBP_EnemyGauge_SAN_C
---@field WBP_MainMenu_Pal_State_0 UWBP_MainMenu_Pal_State_C
---@field WBP_MainMenu_Pal_State_1 UWBP_MainMenu_Pal_State_C
---@field WBP_MainMenu_Pal_State_2 UWBP_MainMenu_Pal_State_C
---@field ConditionWidgets TArray<UWBP_MainMenu_Pal_State_C>
---@field UpdateWorkDetailTimerHandle FTimerHandle
---@field bindedSlot TSoftObjectPtr<UPalIndividualCharacterSlot>
---@field FixedAssignMsgID FDataTableRowHandle
---@field FreeAssignMsgID FDataTableRowHandle
---@field SuitabilityCheckBoxMap TMap<EPalWorkSuitability, UWBP_WorkSuitabilityPreference_CheckBox_0_C>
---@field OnChangedSuitabilityCheck FWBP_WorlSuitabilityPreference_PalList_COnChangedSuitabilityCheck
---@field BattleModeCheckBox UWBP_WorkSuitabilityPreference_CheckBox_0_C
---@field OnChangedBattleModeCheck FWBP_WorlSuitabilityPreference_PalList_COnChangedBattleModeCheck
---@field OnHoveredCheckBox FWBP_WorlSuitabilityPreference_PalList_COnHoveredCheckBox
---@field LastHoveredCheckBoxIndex int32
---@field bEnableOperation boolean
local UWBP_WorlSuitabilityPreference_PalList_C = {}

function UWBP_WorlSuitabilityPreference_PalList_C:UpdateOperationPermission() end
---@param bEnableOperation boolean
function UWBP_WorlSuitabilityPreference_PalList_C:SetOperationPermission(bEnableOperation) end
---@param Index int32
function UWBP_WorlSuitabilityPreference_PalList_C:GetLastHoveredCheckBoxIndex(Index) end
---@param Index int32
---@param TargetWidget UWidget
function UWBP_WorlSuitabilityPreference_PalList_C:GetFocusTargetByCheckBoxIndex(Index, TargetWidget) end
---@param CheckBox UWBP_WorkSuitabilityPreference_CheckBox_0_C
function UWBP_WorlSuitabilityPreference_PalList_C:OnHoveredCheckBox_Internal(CheckBox) end
---@param Slot UHorizontalBoxSlot
function UWBP_WorlSuitabilityPreference_PalList_C:ArrangeHorizontalSlot_ForCheckBox(Slot) end
---@param IsChecked boolean
---@param Suitability EPalWorkSuitability
function UWBP_WorlSuitabilityPreference_PalList_C:OnChangedBattleModeCheckState_Internal(IsChecked, Suitability) end
---@param WorkSuitabilities TMap<EPalWorkSuitability, int32>
UWBP_WorlSuitabilityPreference_PalList_C['Set Work Suitability'] = function(self, WorkSuitabilities) end
---@param IsChecked boolean
---@param Suitability EPalWorkSuitability
function UWBP_WorlSuitabilityPreference_PalList_C:OnChangedSuitabilityCheckState_Internal(IsChecked, Suitability) end
---@param NewLevel int32
function UWBP_WorlSuitabilityPreference_PalList_C:OnUpdateLevel_Binded(NewLevel) end
---@param IsFixedAssign boolean
function UWBP_WorlSuitabilityPreference_PalList_C:SetFixedAssignMode(IsFixedAssign) end
---@param Slot UPalIndividualCharacterSlot
---@param LastHandle UPalIndividualCharacterHandle
function UWBP_WorlSuitabilityPreference_PalList_C:OnUpdateSlotHandle(Slot, LastHandle) end
function UWBP_WorlSuitabilityPreference_PalList_C:Unbind() end
---@param TargetSlot UPalIndividualCharacterSlot
function UWBP_WorlSuitabilityPreference_PalList_C:BindFromSlot(TargetSlot) end
function UWBP_WorlSuitabilityPreference_PalList_C:UpdateWorkDetail_Timer() end
---@param NewNickName FString
function UWBP_WorlSuitabilityPreference_PalList_C:OnUpdateNickName_Binded(NewNickName) end
function UWBP_WorlSuitabilityPreference_PalList_C:OnUpdateCondition_Binded() end
---@param Info FPalWorkSuitabilityPreferenceInfo
function UWBP_WorlSuitabilityPreference_PalList_C:OnUpdateWorkSuitabilityOption_Binded(Info) end
---@param nowSanity double
---@param nowMaxSanity double
function UWBP_WorlSuitabilityPreference_PalList_C:OnUpdateSanity_Binded(nowSanity, nowMaxSanity) end
function UWBP_WorlSuitabilityPreference_PalList_C:SetupCheckBox() end
---@param IsEnable boolean
function UWBP_WorlSuitabilityPreference_PalList_C:SetEnableTaskDetail(IsEnable) end
---@param Target UWidget
function UWBP_WorlSuitabilityPreference_PalList_C:GetTopFocusTarget(Target) end
function UWBP_WorlSuitabilityPreference_PalList_C:Construct() end
function UWBP_WorlSuitabilityPreference_PalList_C:OnInitialized() end
function UWBP_WorlSuitabilityPreference_PalList_C:Destruct() end
---@param EntryPoint int32
function UWBP_WorlSuitabilityPreference_PalList_C:ExecuteUbergraph_WBP_WorlSuitabilityPreference_PalList(EntryPoint) end
---@param SelfWidget UWBP_WorlSuitabilityPreference_PalList_C
function UWBP_WorlSuitabilityPreference_PalList_C:OnHoveredCheckBox__DelegateSignature(SelfWidget) end
---@param IsChecked boolean
---@param TargetSlot UPalIndividualCharacterSlot
function UWBP_WorlSuitabilityPreference_PalList_C:OnChangedBattleModeCheck__DelegateSignature(IsChecked, TargetSlot) end
---@param IsChecked boolean
---@param Suitability EPalWorkSuitability
---@param TargetSlot UPalIndividualCharacterSlot
function UWBP_WorlSuitabilityPreference_PalList_C:OnChangedSuitabilityCheck__DelegateSignature(IsChecked, Suitability, TargetSlot) end


