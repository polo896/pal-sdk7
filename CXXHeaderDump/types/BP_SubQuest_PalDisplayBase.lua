---@meta

---@class UBP_SubQuest_PalDisplayBase_C : UBP_PalQuestDataBase_C
local UBP_SubQuest_PalDisplayBase_C = {}

---@return FPalCommonQuestRewardData
function UBP_SubQuest_PalDisplayBase_C:GetCustomDisplayRewardData() end
---@param InOriginalText FText
---@param OutText FText
function UBP_SubQuest_PalDisplayBase_C:FormatQuestDescriptionText(InOriginalText, OutText) end


