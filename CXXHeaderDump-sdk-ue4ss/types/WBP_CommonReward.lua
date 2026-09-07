---@meta

---@class UWBP_CommonReward_C : UPalUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_AddText_Out UWidgetAnimation
---@field Anm_AddText_In UWidgetAnimation
---@field Anm_MonoColor UWidgetAnimation
---@field Anm_PurpleColor UWidgetAnimation
---@field Anm_DefaultColor UWidgetAnimation
---@field Anm_Close UWidgetAnimation
---@field Anm_Open UWidgetAnimation
---@field BP_PalRichTextBlock_C_99 UBP_PalRichTextBlock_C
---@field Icon UImage
---@field Image UImage
---@field Image_AddEff UImage
---@field Image_AddEff_1 UImage
---@field Image_AddEff_2 UImage
---@field Image_Base UImage
---@field Image_Mutant UImage
---@field Image_Plane UImage
---@field Image_Strong UImage
---@field RichText_AddText_1 UBP_PalRichTextBlock_C
---@field RichText_AddText_2 UBP_PalRichTextBlock_C
---@field SizeBox_AddText_1 USizeBox
---@field SizeBox_AddTextTitle USizeBox
---@field Spacer_62 USpacer
---@field Text_Add_Title UBP_PalTextBlock_C
---@field Text_Title UBP_PalTextBlock_C
---@field VerticalBox_Add UVerticalBox
---@field RewardInfos TArray<FPalUICommonRewardDisplayData>
---@field Queuing boolean
---@field TitleMap TMap<EPalUIRewardDisplayType, FDataTableRowHandle>
---@field CurrentDisplayInfo FPalUICommonRewardDisplayData
---@field AdditionalTextArray TArray<UBP_PalRichTextBlock_C>
local UWBP_CommonReward_C = {}

---@param bIsEmpty boolean
function UWBP_CommonReward_C:IsCurrentAdditionalTextEmpty(bIsEmpty) end
---@param bIsEmpty boolean
function UWBP_CommonReward_C:IsCurrentAdditionalTitleTextEmpty(bIsEmpty) end
function UWBP_CommonReward_C:SetupCurrentAdditionalText() end
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
function UWBP_CommonReward_C:OnInitialized() end
---@param EntryPoint int32
function UWBP_CommonReward_C:ExecuteUbergraph_WBP_CommonReward(EntryPoint) end


