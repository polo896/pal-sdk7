---@meta

---@class UWBP_PalWork_Expedition_C : UPalUIMapObjectStatusIndicatorBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_DetailToSimple UWidgetAnimation
---@field BP_PalRichTextBlock_CompletedExpedition UBP_PalRichTextBlock_C
---@field BP_PalRichTextBlock_RemainTime_Hour UBP_PalRichTextBlock_C
---@field BP_PalRichTextBlock_RemainTime_Hour_1 UBP_PalRichTextBlock_C
---@field BP_PalRichTextBlock_RemainTime_Minute UBP_PalRichTextBlock_C
---@field BP_PalRichTextBlock_RemainTime_Minute_1 UBP_PalRichTextBlock_C
---@field BP_PalRichTextBlock_RemainTime_Second UBP_PalRichTextBlock_C
---@field BP_PalRichTextBlock_RemainTime_Second_1 UBP_PalRichTextBlock_C
---@field CanvasPanel_Complete UCanvasPanel
---@field CanvasPanel_Progress UCanvasPanel
---@field CircularGauge_Progress UWBP_CommonCircularGauge_C
---@field HorizontalBox_RemainTime UHorizontalBox
---@field Image UImage
---@field Image_Base_Dot UImage
---@field Image_Icon_Expedition UImage
---@field PalRetainerBox_0 UPalRetainerBox
---@field Text_StageName UBP_PalTextBlock_C
---@field IsSimpleDetail boolean
local UWBP_PalWork_Expedition_C = {}

function UWBP_PalWork_Expedition_C:ChangeToExpandDetail() end
---@param bSkipAnimation boolean
function UWBP_PalWork_Expedition_C:ChangeToSimpleDetail(bSkipAnimation) end
function UWBP_PalWork_Expedition_C:ChangeToCompleted() end
function UWBP_PalWork_Expedition_C:ChangeToInProgress() end
---@param Rate double
function UWBP_PalWork_Expedition_C:SetGaugeRate(Rate) end
---@param Seconds int64
function UWBP_PalWork_Expedition_C:SetRemainSeconds(Seconds) end
---@param TitleText FText
function UWBP_PalWork_Expedition_C:SetTitle(TitleText) end
function UWBP_PalWork_Expedition_C:Destruct() end
function UWBP_PalWork_Expedition_C:Construct() end
---@param EntryPoint int32
function UWBP_PalWork_Expedition_C:ExecuteUbergraph_WBP_PalWork_Expedition(EntryPoint) end


