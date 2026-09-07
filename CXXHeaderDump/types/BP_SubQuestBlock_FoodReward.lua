---@meta

---@class UBP_SubQuestBlock_FoodReward_C : UPalQuestBlock
---@field UberGraphFrame FPointerToUberGraphFrame
---@field NewVar FTimerHandle
---@field OldItemCount int32
---@field OldRequestid FName
---@field RequestCategry EPalItemRequireCategory
local UBP_SubQuestBlock_FoodReward_C = {}

---@param RecordData UPalPlayerRecordData
function UBP_SubQuestBlock_FoodReward_C:GetRecordData(RecordData) end
---@param InventoryData UPalPlayerInventoryData
function UBP_SubQuestBlock_FoodReward_C:GetInventoryData(InventoryData) end
---@param OutText FText
function UBP_SubQuestBlock_FoodReward_C:GetProgressText(OutText) end
---@param OutText FText
function UBP_SubQuestBlock_FoodReward_C:GetDescriptionText(OutText) end
---@param RewardData FPalCircumRequestData
function UBP_SubQuestBlock_FoodReward_C:GetCurrentObjecttiveData(RewardData) end
---@param bCompleted boolean
function UBP_SubQuestBlock_FoodReward_C:IsCompleted(bCompleted) end
UBP_SubQuestBlock_FoodReward_C['カスタムイベント'] = function(self, ) end
function UBP_SubQuestBlock_FoodReward_C:OnSetup_ServerInternal_ForBP() end
function UBP_SubQuestBlock_FoodReward_C:OnComplete_ServerInternal_ForBP() end
---@param EntryPoint int32
function UBP_SubQuestBlock_FoodReward_C:ExecuteUbergraph_BP_SubQuestBlock_FoodReward(EntryPoint) end


