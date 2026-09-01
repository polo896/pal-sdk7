---@meta

---@class UWBP_Buildup_Player_Item_C : UUserWidget
---@field Image_IconHaveItem UImage
---@field Text_HaveNum UBP_PalTextBlock_C
---@field MyRelicType EPalRelicType
local UWBP_Buildup_Player_Item_C = {}

---@param DisplayCount int32
function UWBP_Buildup_Player_Item_C:DisplayFIxedRelicCount(DisplayCount) end
function UWBP_Buildup_Player_Item_C:DisplayCurrentRelicCount() end
---@param RelicType EPalRelicType
function UWBP_Buildup_Player_Item_C:SetRelicType(RelicType) end


