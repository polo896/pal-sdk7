---@meta

---@class UWBP_Research_Buff_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Text_RearchEffect UBP_PalTextBlock_C
---@field WBP_ResearchEffectIcon UWBP_ResearchEffectIcon_C
local UWBP_Research_Buff_C = {}

---@param MainType EPalWorkSuitability
---@param SubType EPalLabCategorySubType
---@param Effect FText
function UWBP_Research_Buff_C:Setup(MainType, SubType, Effect) end
---@param EntryPoint int32
function UWBP_Research_Buff_C:ExecuteUbergraph_WBP_Research_Buff(EntryPoint) end


