---@meta

---@class UWBP_AssignBoard_C : UPalUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Canvas_RemoveGuide UCanvasPanel
---@field Canvas_SortButton UCanvasPanel
---@field Image_860 UImage
---@field Image_Base_Pal_Select UImage
---@field Image_Base_WorkList_Select UImage
---@field Image_Frame_Pal UImage
---@field Image_Frame_Pal_Select UImage
---@field Image_Frame_WorkList UImage
---@field Image_Frame_WorkList_Select UImage
---@field Text_SortType UBP_PalTextBlock_C
---@field Text_WorkerNum UBP_PalTextBlock_C
---@field WBP_IngameMenu_PalBox_PalDetail UWBP_IngameMenu_PalBox_PalDetail_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WBP_NoData UWBP_NoData_C
---@field WBP_PalCharacterScrollList_Worker UWBP_PalCharacterScrollList_C
---@field WBP_PalCommonScrollList_WorkList UWBP_PalCommonScrollList_C
---@field WBP_PalInvisibleButton_Sort UWBP_PalInvisibleButton_C
---@field WBP_PalKeyGuideIcon UWBP_PalKeyGuideIcon_C
---@field SoftWorkerCharacterContainer TSoftObjectPtr<UPalIndividualCharacterContainer>
---@field OnClickedWorkerSlot FWBP_AssignBoard_COnClickedWorkerSlot
---@field IsSelectingWorker boolean
---@field OnClickedWork FWBP_AssignBoard_COnClickedWork
---@field WorkTypeWidgetMap TMap<EPalWorkType, TSubclassOf<UUserWidget>>
---@field SelectedWorkWidget UWBP_AssignBoard_WorkListBase_C
---@field RemoveAssignActionHandle FPalUIActionBindData
---@field OnTriggerRemoveAssignShortcut FWBP_AssignBoard_COnTriggerRemoveAssignShortcut
---@field RemoveAssignInputAction FPalDataTableRowName_UIInputAction
---@field OnHoveredWork FWBP_AssignBoard_COnHoveredWork
---@field OnUnhoveredWork FWBP_AssignBoard_COnUnhoveredWork
---@field WorkListWidgetMap TMap<FGuid, UWBP_AssignBoard_WorkListBase_C>
---@field OnClickedSortButton FWBP_AssignBoard_COnClickedSortButton
---@field OnClickedCloseButton FWBP_AssignBoard_COnClickedCloseButton
local UWBP_AssignBoard_C = {}

---@param AssignInfo FPalUIBaseCampWorkFixedAssignInfo
---@param createdWidget UWBP_AssignBoard_WorkListBase_C
function UWBP_AssignBoard_C:CreateWorkListWidget(AssignInfo, createdWidget) end
---@param Widget UWBP_AssignBoard_WorkListBase_C
---@param IsExist boolean
function UWBP_AssignBoard_C:IsExistWorkListWidget(Widget, IsExist) end
---@param SortNameText FText
UWBP_AssignBoard_C['Set Sort Name'] = function(self, SortNameText) end
function UWBP_AssignBoard_C:RegisterAction_RemoveAssignShortcut() end
---@param Widget UWBP_AssignBoard_WorkListBase_C
function UWBP_AssignBoard_C:OnUnhoveredWork_Internal(Widget) end
---@param Widget UWBP_AssignBoard_WorkListBase_C
function UWBP_AssignBoard_C:OnHoveredWork_Internal(Widget) end
function UWBP_AssignBoard_C:OnTriggerRemoveAssignShortcut_Internal() end
---@param Widget UWBP_AssignBoard_WorkListBase_C
function UWBP_AssignBoard_C:OnSelectedWork_Internal(Widget) end
---@param IsSelecting boolean
function UWBP_AssignBoard_C:IsSelectiongWorkerMode(IsSelecting) end
function UWBP_AssignBoard_C:EndSelectWorker() end
---@param TargetWorkWIdget UWBP_AssignBoard_WorkListBase_C
function UWBP_AssignBoard_C:StartSelectWorker(TargetWorkWIdget) end
---@param Widget UWidget
function UWBP_AssignBoard_C:GetWorkerTopButton(Widget) end
---@param Widget UWidget
function UWBP_AssignBoard_C:GetWorkListTopButton(Widget) end
---@param AssignInfo TArray<FPalUIBaseCampWorkFixedAssignInfo>
---@param ForceRefresh boolean
function UWBP_AssignBoard_C:SetAssignInfo(AssignInfo, ForceRefresh) end
---@param Model UPalUIBaseCampWorkFixedAssignManageModel
function UWBP_AssignBoard_C:OnUpdateAssignInfo(Model) end
---@param Widget UWBP_PalCharacterSlotButtonBase_C
function UWBP_AssignBoard_C:OnUnhoveredWorkerButton_Internal(Widget) end
---@param Widget UWBP_PalCharacterSlotButtonBase_C
function UWBP_AssignBoard_C:OnHoveredWorkerButton_Internal(Widget) end
---@param Container UPalIndividualCharacterContainer
function UWBP_AssignBoard_C:OnUpdateWorkerSlots_Internal(Container) end
---@param Widget UWBP_PalCharacterSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_AssignBoard_C:OnClickedWorkerButton_Internal(Widget, PressType) end
function UWBP_AssignBoard_C:ResetWorkerContainerEvent() end
---@param Container UPalIndividualCharacterContainer
function UWBP_AssignBoard_C:SetupWorkerContainerEvent(Container) end
---@param Container UPalIndividualCharacterContainer
function UWBP_AssignBoard_C:SetWorkerCharacterContainer(Container) end
function UWBP_AssignBoard_C:Setup() end
---@param SelectWidget UWBP_AssignBoard_WorkListBase_C
function UWBP_AssignBoard_C:AnmEvent_SelectWork(SelectWidget) end
function UWBP_AssignBoard_C:AnmEvent_UnselectWork() end
function UWBP_AssignBoard_C:Destruct() end
---@param createdSlot UWBP_PalCharacterSlotButtonBase_C
function UWBP_AssignBoard_C:BndEvt__WBP_AssignBoard_WBP_PalCharacterScrollList_Worker_K2Node_ComponentBoundEvent_0_OnCreatedSlot__DelegateSignature(createdSlot) end
---@param Widget UWBP_PalCharacterSlotButtonBase_C
function UWBP_AssignBoard_C:BndEvt__WBP_AssignBoard_WBP_PalCharacterScrollList_Worker_K2Node_ComponentBoundEvent_1_OnHoveredSlot__DelegateSignature(Widget) end
---@param Widget UWBP_PalCharacterSlotButtonBase_C
---@param PressType EPalItemSlotPressType
function UWBP_AssignBoard_C:BndEvt__WBP_AssignBoard_WBP_PalCharacterScrollList_Worker_K2Node_ComponentBoundEvent_2_OnLeftClickedSlot__DelegateSignature(Widget, PressType) end
---@param Widget UWBP_PalCharacterSlotButtonBase_C
function UWBP_AssignBoard_C:BndEvt__WBP_AssignBoard_WBP_PalCharacterScrollList_Worker_K2Node_ComponentBoundEvent_3_OnUnhoveredSlot__DelegateSignature(Widget) end
---@param Widget UWBP_PalCharacterSlotButtonBase_C
function UWBP_AssignBoard_C:BndEvt__WBP_AssignBoard_WBP_PalCharacterScrollList_Worker_K2Node_ComponentBoundEvent_4_OnRightClickedSlot__DelegateSignature(Widget) end
---@param Button UCommonButtonBase
function UWBP_AssignBoard_C:BndEvt__WBP_AssignBoard_WBP_PalInvisibleButton_Sort_K2Node_ComponentBoundEvent_5_CommonButtonBaseClicked__DelegateSignature(Button) end
function UWBP_AssignBoard_C:BndEvt__WBP_AssignBoard_WBP_Menu_btn_K2Node_ComponentBoundEvent_6_OnButtonClicked__DelegateSignature() end
---@param EntryPoint int32
function UWBP_AssignBoard_C:ExecuteUbergraph_WBP_AssignBoard(EntryPoint) end
function UWBP_AssignBoard_C:OnClickedCloseButton__DelegateSignature() end
function UWBP_AssignBoard_C:OnClickedSortButton__DelegateSignature() end
---@param Widget UWBP_AssignBoard_WorkListBase_C
function UWBP_AssignBoard_C:OnUnhoveredWork__DelegateSignature(Widget) end
---@param Widget UWBP_AssignBoard_WorkListBase_C
function UWBP_AssignBoard_C:OnHoveredWork__DelegateSignature(Widget) end
function UWBP_AssignBoard_C:OnTriggerRemoveAssignShortcut__DelegateSignature() end
---@param Widget UWBP_AssignBoard_WorkListBase_C
function UWBP_AssignBoard_C:OnClickedWork__DelegateSignature(Widget) end
---@param SlotButtonBase UWBP_PalCharacterSlotButtonBase_C
function UWBP_AssignBoard_C:OnClickedWorkerSlot__DelegateSignature(SlotButtonBase) end


