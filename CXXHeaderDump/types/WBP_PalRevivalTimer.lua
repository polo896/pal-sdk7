---@meta

---@class UWBP_PalRevivalTimer_C : UUserWidget
---@field Image_229 UImage
---@field Image_Arrow UImage
---@field Image_Buff_0 UImage
---@field Image_Buff_1 UImage
---@field Image_Buff_2 UImage
---@field Image_RoundProgress UImage
---@field Text_ReviveTimer UBP_PalTextBlock_C
local UWBP_PalRevivalTimer_C = {}

---@param Rate double
function UWBP_PalRevivalTimer_C:SetProgressRate(Rate) end
---@param ResurrectSpeedMultiplier double
function UWBP_PalRevivalTimer_C:SetResurrectAbility(ResurrectSpeedMultiplier) end
---@param RemainingSeconds double
function UWBP_PalRevivalTimer_C:SetRemainingTime(RemainingSeconds) end


