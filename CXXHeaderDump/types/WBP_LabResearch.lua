---@meta

---@class UWBP_LabResearch_C : UPalUIMapObjectStatusIndicatorBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_DetailToSimple UWidgetAnimation
---@field CanvasPanel_NoResearch UCanvasPanel
---@field CanvasPanel_ResearchInfo UCanvasPanel
---@field CircleGauge_Progress UImage
---@field HorizontalBox_Progress UHorizontalBox
---@field HorizontalBox_Progress_Percent UHorizontalBox
---@field Image UImage
---@field Image_Base_Dot UImage
---@field PalRetainerBox_0 UPalRetainerBox
---@field Text_Complete UBP_PalTextBlock_C
---@field Text_ItemName UBP_PalTextBlock_C
---@field Text_MaxItemNum UBP_PalTextBlock_C
---@field Text_MaxItemNum_2 UBP_PalTextBlock_C
---@field Text_MaxItemNum_3 UBP_PalTextBlock_C
---@field Text_NowItemNum UBP_PalTextBlock_C
---@field Text_NowPercent UBP_PalTextBlock_C
---@field Text_NowPercent_1 UBP_PalTextBlock_C
---@field Text_Workload_Progress UBP_PalTextBlock_C
---@field WBP_PalCraftInfo_Pal UWBP_PalCraftInfo_Pal_C
---@field WBP_PalCraftInfo_Pal_1 UWBP_PalCraftInfo_Pal_C
---@field WBP_PalCraftInfo_Pal_2 UWBP_PalCraftInfo_Pal_C
---@field WBP_PalCraftInfo_Pal_3 UWBP_PalCraftInfo_Pal_C
---@field WBP_PalCraftInfo_Pal_4 UWBP_PalCraftInfo_Pal_C
---@field WBP_RequirePalInfo UWBP_RequirePalInfo_C
---@field WBP_ResearchEffectIcon UWBP_ResearchEffectIcon_C
---@field StateMsgIdMap TMap<EPalFarmCropState, FDataTableRowHandle>
---@field PalInfos TArray<UWBP_PalCraftInfo_Pal_C>
---@field DisplayCheckTimer FTimerHandle
---@field isDisplayedDetail boolean
---@field HideNextState boolean
---@field LabModel UPalMapObjectLabModel
---@field ProgressUpdateTimer FTimerHandle
---@field WorkSyncTimer FTimerHandle
local UWBP_LabResearch_C = {}

function UWBP_LabResearch_C:CheckWorkSync() end
---@param LabModel UPalMapObjectLabModel
UWBP_LabResearch_C['On Current Research Updated'] = function(self, LabModel) end
UWBP_LabResearch_C['Update Research Progress'] = function(self, ) end
---@param Location FVector
function UWBP_LabResearch_C:GetMapObjectLocation(Location) end
function UWBP_LabResearch_C:Setup() end
---@param Work UPalWorkBase
UWBP_LabResearch_C['On Updated Worker Pal'] = function(self, Work) end
function UWBP_LabResearch_C:OnSetup() end
function UWBP_LabResearch_C:DisplayCheck() end
function UWBP_LabResearch_C:Destruct() end
function UWBP_LabResearch_C:Construct() end
---@param EntryPoint int32
function UWBP_LabResearch_C:ExecuteUbergraph_WBP_LabResearch(EntryPoint) end


