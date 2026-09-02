---@meta

---@class UWBP_PalWorkProduct_C : UPalUIMapObjectStatusIndicatorBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_None UWidgetAnimation
---@field Anm_DetailToSimple UWidgetAnimation
---@field CircleGauge_Progress UImage
---@field Image UImage
---@field Text_ItemName UBP_PalTextBlock_C
---@field Text_MaxItemNum UBP_PalTextBlock_C
---@field Text_NowItemNum UBP_PalTextBlock_C
---@field WBP_PalCommonItemIcon UWBP_PalCommonItemIcon_C
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
---@field ['Product Item Model'] UPalUIMapObjectProductItemStatusIndicatorModel
local UWBP_PalWorkProduct_C = {}

function UWBP_PalWorkProduct_C:RefreshProductDisplay() end
---@param Location FVector
function UWBP_PalWorkProduct_C:GetMapObjectLocation(Location) end
function UWBP_PalWorkProduct_C:Setup() end
---@param Container UPalItemContainer
function UWBP_PalWorkProduct_C:OnUpdateContainer(Container) end
---@param Work UPalWorkBase
UWBP_PalWorkProduct_C['On Updated Worker Pal'] = function(self, Work) end
---@param Progress UPalWorkProgress
function UWBP_PalWorkProduct_C:OnUpdateProgress(Progress) end
function UWBP_PalWorkProduct_C:OnSetup() end
function UWBP_PalWorkProduct_C:DisplayCheck() end
function UWBP_PalWorkProduct_C:Destruct() end
function UWBP_PalWorkProduct_C:Construct() end
---@param UIModel UPalUIMapObjectProductItemStatusIndicatorModel
UWBP_PalWorkProduct_C['OnUpdateProductIdDelegate_イベント'] = function(self, UIModel) end
---@param EntryPoint int32
function UWBP_PalWorkProduct_C:ExecuteUbergraph_WBP_PalWorkProduct(EntryPoint) end


