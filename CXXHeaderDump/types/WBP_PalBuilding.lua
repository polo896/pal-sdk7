---@meta

---@class UWBP_PalBuilding_C : UPalUIBuilding
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_In UWidgetAnimation
---@field Base_Flash UImage
---@field Image UImage
---@field Image_181 UImage
---@field Image_Icon UImage
---@field Overlay_Reticle UOverlay
---@field WBP_IngameConstruction UWBP_IngameConstruction_C
---@field WBP_PalKeyGuideIcon UWBP_PalKeyGuideIcon_C
---@field Model UBP_PalUIBuildingModel_C
---@field FailedMessageMap TMap<EPalMapObjectOperationResult, FDataTableRowHandle>
---@field FailedMessageOther FDataTableRowHandle
---@field BuilderComponent UPalBuilderComponent
---@field lastWarningType EPalMapObjectOperationResult
---@field isExitMaterial boolean
---@field CancelBuildingActionInput FPalDataTableRowName_UIInputAction
---@field ForceCloseBuildingActionInput FPalDataTableRowName_UIInputAction
---@field ForceCloseBuildingActionInput02 FPalDataTableRowName_UIInputAction
---@field BuildObjectActionInput FPalDataTableRowName_UIInputAction
---@field BuildObjectContinuousActionInput FPalDataTableRowName_UIInputAction
---@field CancelBuildingActionInput_ForRadialMenu FPalDataTableRowName_UIInputAction
---@field BuildRotateRightActionInput FPalDataTableRowName_UIInputAction
---@field BuildRotateLeftActionInput FPalDataTableRowName_UIInputAction
---@field BuildChangeMode FPalDataTableRowName_UIInputAction
---@field NewVar boolean
---@field UpdateDisplayTimer FTimerHandle
---@field BuildChangeSnapMode FPalDataTableRowName_UIInputAction
---@field BuildChangeReplaceMode FPalDataTableRowName_UIInputAction
---@field ChangeModeInputAction FPalDataTableRowName_UIInputAction
---@field bCompletedDelayInputActionSetup boolean
---@field DelayInputActionSetupTimerHandle FTimerHandle
local UWBP_PalBuilding_C = {}

function UWBP_PalBuilding_C:DelaySetupInputAction() end
function UWBP_PalBuilding_C:ChangeMode() end
function UWBP_PalBuilding_C:OnEsc() end
function UWBP_PalBuilding_C:ToggleChangeReplaceMode() end
function UWBP_PalBuilding_C:ChangeSnapModeOff() end
function UWBP_PalBuilding_C:ChangeSnapModeOn() end
function UWBP_PalBuilding_C:ChangeModeOff() end
function UWBP_PalBuilding_C:ChangeModeOn() end
function UWBP_PalBuilding_C:UpdateOutsideBaseCampWarning() end
function UWBP_PalBuilding_C:OnLeaveBaseCamp() end
---@param Model UPalBaseCampModel
function UWBP_PalBuilding_C:OnEnterBaseCamp(Model) end
function UWBP_PalBuilding_C:UnregisterInsideBaseCampEvent() end
function UWBP_PalBuilding_C:RegisterInsideBaseCampEvent() end
function UWBP_PalBuilding_C:RotateLeft() end
function UWBP_PalBuilding_C:RotateRight() end
---@param Result EPalMapObjectOperationResult
UWBP_PalBuilding_C['Get Build Operation Result'] = function(self, Result) end
function UWBP_PalBuilding_C:EmptyFunction() end
---@param Result EPalMapObjectOperationResult
---@param Text FText
function UWBP_PalBuilding_C:GetWarningText(Result, Text) end
function UWBP_PalBuilding_C:BuildObjectContinuous() end
function UWBP_PalBuilding_C:BuildObject() end
UWBP_PalBuilding_C['Finish Building'] = function(self, ) end
function UWBP_PalBuilding_C:ReturnToMainMenu() end
function UWBP_PalBuilding_C:SetupInputAction() end
function UWBP_PalBuilding_C:ResetUI() end
function UWBP_PalBuilding_C:SetupUI() end
function UWBP_PalBuilding_C:DisposeModel() end
UWBP_PalBuilding_C['Setup Model'] = function(self, ) end
function UWBP_PalBuilding_C:AnmEvent_In() end
function UWBP_PalBuilding_C:OnSetup() end
function UWBP_PalBuilding_C:Destruct() end
function UWBP_PalBuilding_C:UpdateDisplay() end
function UWBP_PalBuilding_C:Construct() end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_PalBuilding_C:Tick(MyGeometry, InDeltaTime) end
function UWBP_PalBuilding_C:DelayInputActionSetupEvent() end
---@param EntryPoint int32
function UWBP_PalBuilding_C:ExecuteUbergraph_WBP_PalBuilding(EntryPoint) end


