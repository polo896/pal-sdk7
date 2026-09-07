---@meta

---@class UWBP_Research_TreeLv_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_PalTextBlock_Level UBP_PalTextBlock_C
---@field Image_Base UImage
---@field Spacer USpacer
---@field WBP_ResearchEffectIcon UWBP_ResearchEffectIcon_C
local UWBP_Research_TreeLv_C = {}

---@param Level int32
---@param BlockHeight int32
---@param Type EPalWorkSuitability
function UWBP_Research_TreeLv_C:SetLevelHeight(Level, BlockHeight, Type) end
---@param EntryPoint int32
function UWBP_Research_TreeLv_C:ExecuteUbergraph_WBP_Research_TreeLv(EntryPoint) end


