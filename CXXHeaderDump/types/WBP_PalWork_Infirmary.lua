---@meta

---@class UWBP_PalWork_Infirmary_C : UPalUIMapObjectStatusIndicatorBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_DetailToSimple UWidgetAnimation
---@field Canvas_LV_A UCanvasPanel
---@field Canvas_LV_B UCanvasPanel
---@field Image_LV_A_2 UImage
---@field Image_LV_A_3 UImage
---@field Image_LV_A_Head UImage
---@field Image_LV_B_2 UImage
---@field Image_LV_B_3 UImage
---@field Image_LV_B_4 UImage
---@field Image_LV_B_5 UImage
---@field Image_LV_B_Head UImage
---@field WBP_PalCraftInfo_Pal UWBP_PalCraftInfo_Pal_C
---@field WBP_RequirePalInfo UWBP_RequirePalInfo_C
---@field DisplayCheckTimer FTimerHandle
---@field ChangeCheckTimer FTimerHandle
---@field isDisplayedDetail boolean
---@field ['Pal Infos'] TArray<UWBP_PalCraftInfo_Pal_C>
---@field Gauges TArray<UWBP_PalWorkPowerPlant_Gauge_C>
---@field PreviousAmout double
---@field CurrentAmout double
---@field CurrentGauge int32
---@field UIModel UPalUIMapObjectClinicStatusIndicatorModel
---@field UIIndicatorParam UPalUIMapObjectStatusIndicatorParameter_Clinic
local UWBP_PalWork_Infirmary_C = {}

function UWBP_PalWork_Infirmary_C:RefreshProductDisplay() end
---@param Work UPalWorkBase
UWBP_PalWork_Infirmary_C['On Updated Worker Pal'] = function(self, Work) end
---@param MaxStarLevel int32
---@param Images TArray<UImage>
function UWBP_PalWork_Infirmary_C:GetTargetStarLevelStarImages(MaxStarLevel, Images) end
---@param MaxStarLevel int32
---@param Canvas UCanvasPanel
function UWBP_PalWork_Infirmary_C:GetTargetStarLevelCanvas(MaxStarLevel, Canvas) end
---@param Canvas UCanvasPanel
---@param StarImages TArray<UImage>
---@param CurrentStarLevel int32
function UWBP_PalWork_Infirmary_C:ShowHygieneStarLevel(Canvas, StarImages, CurrentStarLevel) end
function UWBP_PalWork_Infirmary_C:OnUpdateClinicStatus() end
function UWBP_PalWork_Infirmary_C:Setup() end
function UWBP_PalWork_Infirmary_C:OnSetup() end
function UWBP_PalWork_Infirmary_C:Construct() end
function UWBP_PalWork_Infirmary_C:DisplayCheck() end
function UWBP_PalWork_Infirmary_C:Destruct() end
---@param EntryPoint int32
function UWBP_PalWork_Infirmary_C:ExecuteUbergraph_WBP_PalWork_Infirmary(EntryPoint) end


