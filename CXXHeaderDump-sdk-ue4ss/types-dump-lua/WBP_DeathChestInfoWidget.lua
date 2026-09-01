---@meta

---@class UWBP_DeathChestInfoWidget_C : UPalUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_DroppedTimer UWBP_DroppedTimer_C
---@field ['Death Drop Model'] UPalMapObjectDeathPenaltyStorageModel
---@field DropTimerHandle FTimerHandle
local UWBP_DeathChestInfoWidget_C = {}

function UWBP_DeathChestInfoWidget_C:DropTimer() end
---@param DeathDropModel UPalMapObjectDeathPenaltyStorageModel
function UWBP_DeathChestInfoWidget_C:SetDeathDropTimer(DeathDropModel) end
function UWBP_DeathChestInfoWidget_C:Destruct() end
---@param EntryPoint int32
function UWBP_DeathChestInfoWidget_C:ExecuteUbergraph_WBP_DeathChestInfoWidget(EntryPoint) end


