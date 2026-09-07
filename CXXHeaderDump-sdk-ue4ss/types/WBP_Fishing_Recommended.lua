---@meta

---@class UWBP_Fishing_Recommended_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Out UWidgetAnimation
---@field Anm_In UWidgetAnimation
---@field Image UImage
---@field Image_32 UImage
---@field Image_Line_L UImage
---@field Image_Line_L_1 UImage
---@field Image_Line_R UImage
---@field Image_Line_R_1 UImage
---@field SizeBox_Check_1 USizeBox
---@field SizeBox_Check_2 USizeBox
---@field Text_Bait UBP_PalTextBlock_C
---@field Text_Rod UBP_PalTextBlock_C
---@field IsShow boolean
local UWBP_Fishing_Recommended_C = {}

function UWBP_Fishing_Recommended_C:Hide() end
---@param ItemName FText
---@param IsAbove boolean
---@param Text FText
function UWBP_Fishing_Recommended_C:GetBaitText(ItemName, IsAbove, Text) end
---@param ItemName FText
---@param IsAbove boolean
---@param Text FText
function UWBP_Fishing_Recommended_C:GetRodText(ItemName, IsAbove, Text) end
---@param RecommendInfo FPalFishingRecommendInfo
function UWBP_Fishing_Recommended_C:Setup(RecommendInfo) end
function UWBP_Fishing_Recommended_C:AnmEvent_In() end
function UWBP_Fishing_Recommended_C:AnmEvent_Out() end
---@param EntryPoint int32
function UWBP_Fishing_Recommended_C:ExecuteUbergraph_WBP_Fishing_Recommended(EntryPoint) end


