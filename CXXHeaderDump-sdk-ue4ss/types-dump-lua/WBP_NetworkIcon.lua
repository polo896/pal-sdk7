---@meta

---@class UWBP_NetworkIcon_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Slow UWidgetAnimation
---@field Image_Icon UImage
---@field Image_IconBase UImage
local UWBP_NetworkIcon_C = {}

function UWBP_NetworkIcon_C:Construct() end
function UWBP_NetworkIcon_C:OnNetworkCheckTick() end
---@param EntryPoint int32
function UWBP_NetworkIcon_C:ExecuteUbergraph_WBP_NetworkIcon(EntryPoint) end


