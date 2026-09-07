---@meta

---@class UWBP_Arena_PlayerRank_C : UUserWidget
---@field Anm_In UWidgetAnimation
---@field BP_PalTextBlock_Rank UBP_PalTextBlock_C
---@field Image_RankIcon UImage
---@field Text_RankPointNum UBP_PalTextBlock_C
local UWBP_Arena_PlayerRank_C = {}

---@param individualParam UPalIndividualCharacterParameter
---@param Point int32
function UWBP_Arena_PlayerRank_C:OnUpdateRankPoint(individualParam, Point) end
function UWBP_Arena_PlayerRank_C:Setup() end


