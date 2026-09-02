---@meta

---@class UWBP_PalWork_FishPond_C : UPalUIMapObjectStatusIndicatorBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_DetailToSimple UWidgetAnimation
---@field BP_PalRichTextBlock_RemainTime_Hour UBP_PalRichTextBlock_C
---@field BP_PalRichTextBlock_RemainTime_Hour_1 UBP_PalRichTextBlock_C
---@field BP_PalRichTextBlock_RemainTime_Minute UBP_PalRichTextBlock_C
---@field BP_PalRichTextBlock_RemainTime_Minute_1 UBP_PalRichTextBlock_C
---@field BP_PalRichTextBlock_RemainTime_Second UBP_PalRichTextBlock_C
---@field BP_PalRichTextBlock_RemainTime_Second_1 UBP_PalRichTextBlock_C
---@field CircleGauge_Progress UImage
---@field HorizontalBox_RemainTime UHorizontalBox
---@field Image UImage
---@field Image_Base_Dot UImage
---@field Image_Icon_FishPond UImage
---@field PalRetainerBox_0 UPalRetainerBox
---@field Text_MaxItemNum UBP_PalTextBlock_C
---@field Text_NowItemNum UBP_PalTextBlock_C
---@field Text_TargetName UBP_PalTextBlock_C
---@field WBP_PalCraftInfo_Pal UWBP_PalCraftInfo_Pal_C
---@field WBP_PalCraftInfo_Pal_1 UWBP_PalCraftInfo_Pal_C
---@field WBP_PalCraftInfo_Pal_2 UWBP_PalCraftInfo_Pal_C
---@field WBP_PalCraftInfo_Pal_3 UWBP_PalCraftInfo_Pal_C
---@field WBP_PalCraftInfo_Pal_4 UWBP_PalCraftInfo_Pal_C
---@field WBP_RequirePalInfo UWBP_RequirePalInfo_C
---@field StateMsgIdMap TMap<EPalFarmCropState, FDataTableRowHandle>
---@field PalInfos TArray<UWBP_PalCraftInfo_Pal_C>
---@field DisplayCheckTimer FTimerHandle
---@field isDisplayedDetail boolean
---@field HideNextState boolean
---@field LastNum int32
local UWBP_PalWork_FishPond_C = {}

---@param RemainingSecond int32
function UWBP_PalWork_FishPond_C:SetRemainTime(RemainingSecond) end
---@param UIModel UPalUIMapObjectFishPondStatusIndicatorModel
function UWBP_PalWork_FishPond_C:OnUpdateProductNumInfo(UIModel) end
---@param UIModel UPalUIMapObjectFishPondStatusIndicatorModel
function UWBP_PalWork_FishPond_C:OnUpdateSelectedTarget(UIModel) end
---@return UPalMapObjectConcreteModelBase
function UWBP_PalWork_FishPond_C:GetOwnerConcreteModel() end
---@return UPalUIMapObjectFishPondStatusIndicatorModel
function UWBP_PalWork_FishPond_C:GetIndicatorModel() end
---@param Location FVector
function UWBP_PalWork_FishPond_C:GetMapObjectLocation(Location) end
function UWBP_PalWork_FishPond_C:Setup() end
---@param Work UPalWorkBase
UWBP_PalWork_FishPond_C['On Updated Worker Pal'] = function(self, Work) end
---@param Progress UPalWorkProgress
function UWBP_PalWork_FishPond_C:OnUpdateProgress(Progress) end
function UWBP_PalWork_FishPond_C:OnSetup() end
function UWBP_PalWork_FishPond_C:DisplayCheck() end
function UWBP_PalWork_FishPond_C:Destruct() end
function UWBP_PalWork_FishPond_C:Construct() end
---@param EntryPoint int32
function UWBP_PalWork_FishPond_C:ExecuteUbergraph_WBP_PalWork_FishPond(EntryPoint) end


