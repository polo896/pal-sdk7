---@meta

---@class UBP_SubQuestBlock_BossDefeatReward_C : UPalQuestBlock
---@field UberGraphFrame FPointerToUberGraphFrame
---@field NewVar FTimerHandle
---@field OldDefeatCount int32
---@field OldRequestid FName
local UBP_SubQuestBlock_BossDefeatReward_C = {}

---@param RecordData UPalPlayerRecordData
function UBP_SubQuestBlock_BossDefeatReward_C:GetRecordData(RecordData) end
---@param OutText FText
function UBP_SubQuestBlock_BossDefeatReward_C:GetProgressText(OutText) end
---@param OutText FText
function UBP_SubQuestBlock_BossDefeatReward_C:GetDescriptionText(OutText) end
---@param RewardData FPalRecordCountRewardData
function UBP_SubQuestBlock_BossDefeatReward_C:GetCurrentObjecttiveData(RewardData) end
---@param bCompleted boolean
function UBP_SubQuestBlock_BossDefeatReward_C:IsCompleted(bCompleted) end
UBP_SubQuestBlock_BossDefeatReward_C['カスタムイベント'] = function(self, ) end
function UBP_SubQuestBlock_BossDefeatReward_C:OnSetup_ServerInternal_ForBP() end
function UBP_SubQuestBlock_BossDefeatReward_C:OnComplete_ServerInternal_ForBP() end
---@param EntryPoint int32
function UBP_SubQuestBlock_BossDefeatReward_C:ExecuteUbergraph_BP_SubQuestBlock_BossDefeatReward(EntryPoint) end


