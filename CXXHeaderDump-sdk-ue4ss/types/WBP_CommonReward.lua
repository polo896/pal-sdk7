---@meta

---@class UWBP_CommonReward_C : UPalUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_MonoColor UWidgetAnimation
---@field Anm_PurpleColor UWidgetAnimation
---@field Anm_DefaultColor UWidgetAnimation
---@field Anm_Close UWidgetAnimation
---@field Anm_Open UWidgetAnimation
---@field BP_PalRichTextBlock_C_99 UBP_PalRichTextBlock_C
---@field Icon UImage
---@field Image_Mutant UImage
---@field Image_Strong UImage
---@field Spacer_62 USpacer
---@field Text_Title UBP_PalTextBlock_C
---@field RewardInfos TArray<FPalUICommonRewardDisplayData>
---@field Queuing boolean
---@field TitleMap TMap<EPalUIRewardDisplayType, FDataTableRowHandle>
local UWBP_CommonReward_C = {}

function UWBP_CommonReward_C:Finished_8B86E03B4C9B039B2D1E43872343E0D8() end
function UWBP_CommonReward_C:Finished_99C931904947D8826978CE8B6DE53642() end
function UWBP_CommonReward_C:ShowInfo() end
---@param Info FPalUICommonRewardDisplayData
function UWBP_CommonReward_C:QueueRewardInfo(Info) end
---@param Info FPalUICommonRewardDisplayData
function UWBP_CommonReward_C:SetInfo(Info) end
---@param DisplayType EPalUIRewardDisplayType
function UWBP_CommonReward_C:ChangeColor(DisplayType) end
function UWBP_CommonReward_C:ClearQueueInfo() end
---@param EntryPoint int32
function UWBP_CommonReward_C:ExecuteUbergraph_WBP_CommonReward(EntryPoint) end


