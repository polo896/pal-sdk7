---@meta

---@class ABP_NPC_GrassBoss_C : ABP_NPC_StandardHumanDataSet_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_PalCryComponent UBP_PalCryComponent_C
local ABP_NPC_GrassBoss_C = {}

function ABP_NPC_GrassBoss_C:ReceiveBeginPlay() end
---@param bIsBattleMode boolean
ABP_NPC_GrassBoss_C['OnChangeBattleModeDelegate_イベント'] = function(self, bIsBattleMode) end
---@param EntryPoint int32
function ABP_NPC_GrassBoss_C:ExecuteUbergraph_BP_NPC_GrassBoss(EntryPoint) end


