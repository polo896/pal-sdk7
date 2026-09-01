---@meta

---@class UWBP_WarningEvent_NoticeTimer_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_NormalToSimple UWidgetAnimation
---@field Image UImage
---@field Image_104 UImage
---@field Image_CautionIcon UImage
---@field Image_Line_L UImage
---@field Image_Line_R UImage
---@field Text_Timer UBP_PalTextBlock_C
---@field bSimpleDetail boolean
---@field bFirstAnimation boolean
local UWBP_WarningEvent_NoticeTimer_C = {}

---@param remainTime double
function UWBP_WarningEvent_NoticeTimer_C:SetRemainTime(remainTime) end
function UWBP_WarningEvent_NoticeTimer_C:AnmEvent_ForceSimpleDetail() end
function UWBP_WarningEvent_NoticeTimer_C:AnmEvent_SimpleToNormal() end
function UWBP_WarningEvent_NoticeTimer_C:AnmEvent_NormalToSimple() end
---@param EntryPoint int32
function UWBP_WarningEvent_NoticeTimer_C:ExecuteUbergraph_WBP_WarningEvent_NoticeTimer(EntryPoint) end


