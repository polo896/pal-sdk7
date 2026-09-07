---@meta

---@class UBP_SubQuestBlock_PalDisplayBase_C : UPalQuestBlock
---@field UberGraphFrame FPointerToUberGraphFrame
---@field DisplayCategory EPalPalDisplayCategory
---@field NewVar FTimerHandle
---@field LastRequireRequestID FName
local UBP_SubQuestBlock_PalDisplayBase_C = {}

---@param RecordData UPalPlayerRecordData
function UBP_SubQuestBlock_PalDisplayBase_C:GetRecordData(RecordData) end
---@param OutText FText
function UBP_SubQuestBlock_PalDisplayBase_C:GetDescriptionText(OutText) end
---@param RequestData FPalDisplayRequestData
function UBP_SubQuestBlock_PalDisplayBase_C:GetCurrentDisplayRequestData(RequestData) end
---@param bCompleted boolean
function UBP_SubQuestBlock_PalDisplayBase_C:IsComplete(bCompleted) end
function UBP_SubQuestBlock_PalDisplayBase_C:OnSetup_ServerInternal_ForBP() end
UBP_SubQuestBlock_PalDisplayBase_C['カスタムイベント'] = function(self, ) end
function UBP_SubQuestBlock_PalDisplayBase_C:OnComplete_ServerInternal_ForBP() end
---@param EntryPoint int32
function UBP_SubQuestBlock_PalDisplayBase_C:ExecuteUbergraph_BP_SubQuestBlock_PalDisplayBase(EntryPoint) end


