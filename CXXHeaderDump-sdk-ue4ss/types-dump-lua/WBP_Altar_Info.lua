---@meta

---@class UWBP_Altar_Info_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Battle UWidgetAnimation
---@field Anm_Preparing UWidgetAnimation
---@field Anm_DetailToSimple UWidgetAnimation
---@field BP_PalRichTextBlock_RemainTime_Minute UBP_PalRichTextBlock_C
---@field BP_PalRichTextBlock_RemainTime_Minute_1 UBP_PalRichTextBlock_C
---@field BP_PalRichTextBlock_RemainTime_Second UBP_PalRichTextBlock_C
---@field BP_PalRichTextBlock_RemainTime_Second_1 UBP_PalRichTextBlock_C
---@field Canvas_ItemIcon UCanvasPanel
---@field HorizontalBox_RemainTime UHorizontalBox
---@field Image UImage
---@field Image_1 UImage
---@field Image_2 UImage
---@field Image_3 UImage
---@field Image_110 UImage
---@field Image_317 UImage
---@field Image_556 UImage
---@field Image_Base_Frame UImage
---@field Image_TimerIcon UImage
---@field ['Overlay<Name'] UOverlay
---@field Overlay_Battle UOverlay
---@field Overlay_PrefixName UOverlay
---@field Overlay_Preparing UOverlay
---@field StatusBase UImage
---@field StatusBase_1 UImage
---@field StatusBase_2 UImage
---@field StatusBase_3 UImage
---@field StatusBase_4 UImage
---@field StatusBase_5 UImage
---@field Text_PalName UBP_PalTextBlock_C
---@field Text_PrefixName UBP_PalTextBlock_C
---@field Text_Status UBP_PalTextBlock_C
---@field Text_Status_1 UBP_PalTextBlock_C
---@field WBP_PalCommonItemIcon UWBP_PalCommonItemIcon_C
local UWBP_Altar_Info_C = {}

---@param BossType EPalBossType
---@param BossId FName
function UWBP_Altar_Info_C:SetTowerBossInfo(BossType, BossId) end
---@param StaticItemId FName
function UWBP_Altar_Info_C:SetRaidBossInfo(StaticItemId) end
---@param TargetText1 URichTextBlock
---@param TargetText2 URichTextBlock
---@param TimeInteger int32
function UWBP_Altar_Info_C:SetTimeText(TargetText1, TargetText2, TimeInteger) end
---@param Minutes int32
---@param Seconds int32
function UWBP_Altar_Info_C:SetRemainingTime(Minutes, Seconds) end
function UWBP_Altar_Info_C:PlayAnimation_Phase_Preparing() end
function UWBP_Altar_Info_C:PlayAnimation_Phase_Battle() end
---@param EntryPoint int32
function UWBP_Altar_Info_C:ExecuteUbergraph_WBP_Altar_Info(EntryPoint) end


