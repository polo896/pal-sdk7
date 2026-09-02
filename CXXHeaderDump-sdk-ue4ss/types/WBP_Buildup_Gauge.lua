---@meta

---@class UWBP_Buildup_Gauge_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Fill UImage
---@field Select UImage
local UWBP_Buildup_Gauge_C = {}

---@param IsFill boolean
function UWBP_Buildup_Gauge_C:SetFill(IsFill) end
function UWBP_Buildup_Gauge_C:SetSelect() end
function UWBP_Buildup_Gauge_C:SetEmpty() end
---@param EntryPoint int32
function UWBP_Buildup_Gauge_C:ExecuteUbergraph_WBP_Buildup_Gauge(EntryPoint) end


