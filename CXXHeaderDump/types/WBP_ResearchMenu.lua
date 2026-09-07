---@meta

---@class UWBP_ResearchMenu_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Canvas_Progress UCanvasPanel
---@field Canvas_ResearchDetail UCanvasPanel
---@field CanvasPanel_DetailRequire UCanvasPanel
---@field CanvasPanel_OverView UCanvasPanel
---@field ProgressBar_Progress UProgressBar
---@field Text_BuffText UBP_PalTextBlock_C
---@field Text_ManMonth_Value UBP_PalTextBlock_C
---@field Text_PalWork UBP_PalTextBlock_C
---@field Text_PalWork_CompNum_0 UBP_PalTextBlock_C
---@field Text_PalWork_CompNum_1 UBP_PalTextBlock_C
---@field Text_RearchName UBP_PalTextBlock_C
---@field Text_ResearchName UBP_PalTextBlock_C
---@field Vertical_Buff UVerticalBox
---@field Vertical_BuffList UVerticalBox
---@field Vertical_Research_List UVerticalBox
---@field WBP_CommonButton UWBP_CommonButton_C
---@field WBP_IconPalWork UWBP_IconPalWork_C
---@field WBP_InventoryEquipment_ItemInfo_Tecnology UWBP_InventoryEquipment_ItemInfo_Tecnology_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field WBP_Research_AllBuff UWBP_Research_AllBuff_C
---@field WBP_Research_Buff UWBP_Research_Buff_C
---@field WBP_Research_PalWorkList UWBP_Research_PalWorkList_C
---@field WBP_Research_Tree UWBP_Research_Tree_C
---@field WBP_ResearchEffectIcon UWBP_ResearchEffectIcon_C
---@field LabModel UPalUIGuildLabModel
---@field CurrentResearchType EPalWorkSuitability
---@field Pined boolean
---@field PinedDetail boolean
---@field CurrentResearch FName
---@field BlockButton boolean
---@field EntryMap TMap<EPalWorkSuitability, UWBP_Research_PalWorkList_C>
---@field ProgressUpdateTimer FTimerHandle
local UWBP_ResearchMenu_C = {}

---@param ResearchInfo TArray<FPalUIGuildLabResearchInfo>
---@param Count int32
function UWBP_ResearchMenu_C:GetResearchCompleteCount(ResearchInfo, Count) end
function UWBP_ResearchMenu_C:ShowAllBuff() end
function UWBP_ResearchMenu_C:UpdateCurrentResearchProgress() end
function UWBP_ResearchMenu_C:OnCurrentResearchChanged() end
---@return UWidget
function UWBP_ResearchMenu_C:BP_GetDesiredFocusTarget() end
---@param Materials TArray<FPalStaticItemIdAndNum>
---@param IsSatisfy boolean
UWBP_ResearchMenu_C['Check Research Require Satisfy'] = function(self, Materials, IsSatisfy) end
---@param ToDetail boolean
UWBP_ResearchMenu_C['Switch Right Panel'] = function(self, ToDetail) end
---@param ResearchId FName
function UWBP_ResearchMenu_C:SetupResearchDetail(ResearchId) end
function UWBP_ResearchMenu_C:OnCancelAction() end
---@param ResearchType EPalWorkSuitability
UWBP_ResearchMenu_C['Setup Research Overview'] = function(self, ResearchType) end
---@param WorkType EPalWorkSuitability
function UWBP_ResearchMenu_C:OnResearchEntryUnhovered(WorkType) end
---@param WorkType EPalWorkSuitability
function UWBP_ResearchMenu_C:OnResearchEntryHovered(WorkType) end
---@param WorkType EPalWorkSuitability
function UWBP_ResearchMenu_C:OnResearchEntryClicked(WorkType) end
function UWBP_ResearchMenu_C:Setup() end
function UWBP_ResearchMenu_C:OnSetup() end
function UWBP_ResearchMenu_C:BndEvt__WBP_ResearchMenu_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
---@param ResearchId FName
function UWBP_ResearchMenu_C:BndEvt__WBP_ResearchMenu_WBP_Research_Tree_K2Node_ComponentBoundEvent_1_OnResearchSelectDelegate__DelegateSignature(ResearchId) end
---@param ResearchId FName
function UWBP_ResearchMenu_C:BndEvt__WBP_ResearchMenu_WBP_Research_Tree_K2Node_ComponentBoundEvent_2_OnResearchHoveredDelegate__DelegateSignature(ResearchId) end
function UWBP_ResearchMenu_C:BndEvt__WBP_ResearchMenu_WBP_Research_Tree_K2Node_ComponentBoundEvent_3_OnResearchUnhoveredDelegate__DelegateSignature() end
function UWBP_ResearchMenu_C:BndEvt__WBP_ResearchMenu_WBP_CommonButton_K2Node_ComponentBoundEvent_4_OnClicked__DelegateSignature() end
---@param bResult boolean
function UWBP_ResearchMenu_C:OnConfirmChangeResearch(bResult) end
---@param NewNode UWBP_Research_TreeIcon_C
function UWBP_ResearchMenu_C:BndEvt__WBP_ResearchMenu_WBP_Research_Tree_K2Node_ComponentBoundEvent_5_OnTreeNodeCreate__DelegateSignature(NewNode) end
function UWBP_ResearchMenu_C:Destruct() end
function UWBP_ResearchMenu_C:BndEvt__WBP_ResearchMenu_WBP_Research_AllBuff_K2Node_ComponentBoundEvent_6_OnAllBuffPanelClose__DelegateSignature() end
---@param EntryPoint int32
function UWBP_ResearchMenu_C:ExecuteUbergraph_WBP_ResearchMenu(EntryPoint) end


