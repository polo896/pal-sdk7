---@meta

---@class UWBP_PalActionBarContent_C : UPalCommonBoundActionButton
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Unhovered UWidgetAnimation
---@field Anm_Hovered UWidgetAnimation
---@field HorizontalBox_32 UHorizontalBox
---@field Image_68 UImage
local UWBP_PalActionBarContent_C = {}

function UWBP_PalActionBarContent_C:Construct() end
function UWBP_PalActionBarContent_C:OnUpdateInputAction() end
---@param Button UCommonButtonBase
function UWBP_PalActionBarContent_C:HoveredEvent(Button) end
---@param Button UCommonButtonBase
function UWBP_PalActionBarContent_C:UnhoveredEvent(Button) end
---@param EntryPoint int32
function UWBP_PalActionBarContent_C:ExecuteUbergraph_WBP_PalActionBarContent(EntryPoint) end


