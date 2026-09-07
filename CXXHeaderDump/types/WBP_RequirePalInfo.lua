---@meta

---@class UWBP_RequirePalInfo_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_DetailToSimple_Path UWidgetAnimation
---@field Anm_Electric_EnableToDisable UWidgetAnimation
---@field Base UImage
---@field Canvas_PathFailed UCanvasPanel
---@field Canvas_RequirePal UCanvasPanel
---@field ElectricPower UCanvasPanel
---@field Image_128 UImage
---@field Image_CautionIcon UImage
---@field Image_Line_Red UImage
---@field Line UImage
---@field Text_Electric UBP_PalTextBlock_C
---@field Text_PathFailed UBP_PalTextBlock_C
---@field Text_RequireWorkSuitability_1 UBP_PalTextBlock_C
---@field Text_Transport UBP_PalTextBlock_C
---@field WBP_MainMenu_Pal_WorkIcon UWBP_MainMenu_Pal_WorkIcon_C
---@field WBP_MainMenu_Pal_WorkIcon_1 UWBP_MainMenu_Pal_WorkIcon_C
---@field RequireGenusMSGID FDataTableRowHandle
---@field RequireTypeMSGID FDataTableRowHandle
---@field PowerOnlineMSGID FDataTableRowHandle
---@field PowerOfflineMSGID FDataTableRowHandle
---@field PowerSufficient boolean
---@field RequireBulletMSGID FDataTableRowHandle
---@field ['Launcher Model'] UPalMapObjectDefenseBulletLauncherModel
---@field BulletRequire boolean
---@field EnergyRequire boolean
---@field isDisplayedDetail boolean
---@field OwnerMapObject APalMapObject
---@field TimerUpdateDisplayPeriodically FTimerHandle
---@field WeakWorkerDirector TSoftObjectPtr<UPalBaseCampWorkerDirector>
---@field ['Suitability Display Data'] TArray<FPalUIMapObjectStatusIndicatorWorkSuitabilityDisplayData>
local UWBP_RequirePalInfo_C = {}

---@param ReturnValues TArray<UWBP_MainMenu_Pal_WorkIcon_C>
function UWBP_RequirePalInfo_C:GetWorkIcons(ReturnValues) end
function UWBP_RequirePalInfo_C:UpdateDisplayIsExistsRequiredWorker() end
---@param NewParam TArray<FPalUIMapObjectStatusIndicatorWorkSuitabilityDisplayData>
---@param bValidData boolean
function UWBP_RequirePalInfo_C:IsValidWorkSuitabilityData(NewParam, bValidData) end
---@param bToDetails boolean
---@param bFinishImmediately boolean
UWBP_RequirePalInfo_C['Play Path Animation'] = function(self, bToDetails, bFinishImmediately) end
---@return boolean
function UWBP_RequirePalInfo_C:ShouldDisplayPathDetail() end
---@param Module UPalMapObjectWorkeeModule
function UWBP_RequirePalInfo_C:OnChangeRegisteredMapObjectCannotApproach(Module) end
---@param Model UPalMapObjectConcreteModelBase
---@param Module UPalMapObjectConcreteModelModuleBase
function UWBP_RequirePalInfo_C:OnReadyRegisteredMapObjectWorkeeModule(Model, Module) end
---@param Model UPalMapObjectConcreteModelBase
UWBP_RequirePalInfo_C['On Ready Registered Map Object Concrete Model'] = function(self, Model) end
---@param OwnerMapObject APalMapObject
function UWBP_RequirePalInfo_C:RegisterOwnerMapObject(OwnerMapObject) end
function UWBP_RequirePalInfo_C:UpdatePowerOrBulletRequireDisplay() end
---@param bulletNum int32
function UWBP_RequirePalInfo_C:UpdateBulletRequire(bulletNum) end
---@param LauncherModel UPalMapObjectDefenseBulletLauncherModel
function UWBP_RequirePalInfo_C:SetupBulletRequire(LauncherModel) end
---@param Module UPalMapObjectEnergyModule
function UWBP_RequirePalInfo_C:SetupPowerSuffcient(Module) end
---@param Module UPalMapObjectEnergyModule
UWBP_RequirePalInfo_C['Update Power Suffcient'] = function(self, Module) end
---@param Work UPalWorkBase
---@param SuitabilityDisplayData TArray<FPalUIMapObjectStatusIndicatorWorkSuitabilityDisplayData>
UWBP_RequirePalInfo_C['Update Display'] = function(self, Work, SuitabilityDisplayData) end
---@param DisplayData TArray<FPalUIMapObjectStatusIndicatorWorkSuitabilityDisplayData>
UWBP_RequirePalInfo_C['Set Work Suitability'] = function(self, DisplayData) end
function UWBP_RequirePalInfo_C:Construct() end
function UWBP_RequirePalInfo_C:UpdateDisplayPeriodically() end
function UWBP_RequirePalInfo_C:Destruct() end
---@param EntryPoint int32
function UWBP_RequirePalInfo_C:ExecuteUbergraph_WBP_RequirePalInfo(EntryPoint) end


