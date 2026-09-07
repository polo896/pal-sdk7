---@meta

---@class UWBP_Buildup_Pal_Item_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field IconHaveItem UImage
---@field Text_HaveNum UBP_PalTextBlock_C
local UWBP_Buildup_Pal_Item_C = {}

---@param IconIndex int32
function UWBP_Buildup_Pal_Item_C:SetIcon(IconIndex) end
---@param Num int32
function UWBP_Buildup_Pal_Item_C:SetNum(Num) end
---@param IsRed boolean
function UWBP_Buildup_Pal_Item_C:SetNumRed(IsRed) end
---@param EntryPoint int32
function UWBP_Buildup_Pal_Item_C:ExecuteUbergraph_WBP_Buildup_Pal_Item(EntryPoint) end


