---@meta

---@class UWBP_PalWorkPowerPlant_1_C : UPalUIMapObjectStatusIndicatorBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Thermometer_Overheat UWidgetAnimation
---@field Anm_Thermometer_Heat UWidgetAnimation
---@field Anm_Thermometer_Default UWidgetAnimation
---@field Anm_DetailToSimple_OnlyStorage UWidgetAnimation
---@field Anm_DetailToSimple UWidgetAnimation
---@field Arrow UImage
---@field Canvas_HeatCaution UCanvasPanel
---@field Image_199 UImage
---@field Image_CautionIcon UImage
---@field Image_Thermometer_Base UImage
---@field Image_Thermometer_GaugeBase UImage
---@field Image_Thermometer_Glow UImage
---@field Image_Thermometer_HeatZone UImage
---@field Overlay_OverheatText UOverlay
---@field PalProgressBar_Thermometer UPalProgressBar
---@field Text_PlantNum UBP_PalTextBlock_C
---@field WBP_PalCraftInfo_Pal UWBP_PalCraftInfo_Pal_C
---@field WBP_PalCraftInfo_Pal_1 UWBP_PalCraftInfo_Pal_C
---@field WBP_PalWorkPowerPlant_Gauge UWBP_PalWorkPowerPlant_Gauge_C
---@field WBP_PalWorkPowerPlant_Gauge_1 UWBP_PalWorkPowerPlant_Gauge_C
---@field WBP_PalWorkPowerPlant_Gauge_2 UWBP_PalWorkPowerPlant_Gauge_C
---@field WBP_PalWorkPowerPlant_Gauge_3 UWBP_PalWorkPowerPlant_Gauge_C
---@field WBP_PalWorkPowerPlant_Gauge_4 UWBP_PalWorkPowerPlant_Gauge_C
---@field WBP_RequirePalInfo UWBP_RequirePalInfo_C
---@field DisplayCheckTimer FTimerHandle
---@field ChangeCheckTimer FTimerHandle
---@field isDisplayedDetail boolean
---@field ['Pal Infos'] TArray<UWBP_PalCraftInfo_Pal_C>
---@field Gauges TArray<UWBP_PalWorkPowerPlant_Gauge_C>
---@field PreviousAmout double
---@field CurrentAmout double
---@field CurrentGauge int32
---@field UIIndicatorModel UPalUIMapObjectEnergyStatusIndicatorModel
local UWBP_PalWorkPowerPlant_1_C = {}

---@param IndicatorModel UPalUIMapObjectEnergyStatusIndicatorModel_GenerateEnergy
function UWBP_PalWorkPowerPlant_1_C:SetHeatGaugeValue(IndicatorModel) end
---@param bOn boolean
function UWBP_PalWorkPowerPlant_1_C:SetVisibleOverHeatCaution(bOn) end
---@return UWidgetAnimation
function UWBP_PalWorkPowerPlant_1_C:GetAnimationDetailToSimple() end
function UWBP_PalWorkPowerPlant_1_C:SetupForMapObjectConcreteModel() end
---@param Model UPalUIMapObjectEnergyStatusIndicatorModel_GenerateEnergy
function UWBP_PalWorkPowerPlant_1_C:OnUpdateOverHeatGauge(Model) end
---@param Model UPalUIMapObjectEnergyStatusIndicatorModel
function UWBP_PalWorkPowerPlant_1_C:OnUpdateEnergyStack(Model) end
---@param Work UPalWorkBase
UWBP_PalWorkPowerPlant_1_C['On Updated Worker Pal'] = function(self, Work) end
---@param IsIncrease boolean
function UWBP_PalWorkPowerPlant_1_C:SetArrow(IsIncrease) end
function UWBP_PalWorkPowerPlant_1_C:OnSetup() end
function UWBP_PalWorkPowerPlant_1_C:Construct() end
function UWBP_PalWorkPowerPlant_1_C:DisplayCheck() end
function UWBP_PalWorkPowerPlant_1_C:Destruct() end
function UWBP_PalWorkPowerPlant_1_C:ChangeCheck() end
---@param EntryPoint int32
function UWBP_PalWorkPowerPlant_1_C:ExecuteUbergraph_WBP_PalWorkPowerPlant_1(EntryPoint) end


