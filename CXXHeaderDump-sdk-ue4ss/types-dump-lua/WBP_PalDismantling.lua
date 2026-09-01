---@meta

---@class UWBP_PalDismantling_C : UPalUIDismantling
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Demolish UWidgetAnimation
---@field Base UImage
---@field Base_1 UImage
---@field Base_2 UImage
---@field Base_Flash UImage
---@field Base_L UImage
---@field Base_L_1 UImage
---@field Base_R UImage
---@field Base_R_1 UImage
---@field Image UImage
---@field Image_181 UImage
---@field Image_Icon UImage
---@field Overlay_Reticle UOverlay
---@field WBP_IngameConstruction_Dismantling UWBP_IngameConstruction_Dismantling_C
---@field WBP_PalKeyGuideIcon UWBP_PalKeyGuideIcon_C
---@field CancelDismantlingActionInput FPalDataTableRowName_UIInputAction
---@field ForceCloseDismantlingActionInput FPalDataTableRowName_UIInputAction
---@field ForceCloseDismantlingActionInput02 FPalDataTableRowName_UIInputAction
---@field DismantleObjectActionInput FPalDataTableRowName_UIInputAction
---@field Model UPalUIDismantlingModel
---@field BuilderComponent UPalBuilderComponent
---@field DismantleObjectContinuousActionInput FPalDataTableRowName_UIInputAction
---@field DismantleTargetObject APalBuildObject
---@field CancelDismantlingActionInput_FromRadialMenu FPalDataTableRowName_UIInputAction
---@field CancelDismantlingActionInput_FromRadialMenu_0 FPalDataTableRowName_UIInputAction
---@field ChangeModeInputAction FPalDataTableRowName_UIInputAction
local UWBP_PalDismantling_C = {}

function UWBP_PalDismantling_C:OnEsc() end
function UWBP_PalDismantling_C:ChangeMode() end
function UWBP_PalDismantling_C:EmptyFunction() end
function UWBP_PalDismantling_C:DismantleObjectSuccessed() end
function UWBP_PalDismantling_C:DismantleObjectFailed() end
function UWBP_PalDismantling_C:InitUI() end
function UWBP_PalDismantling_C:ResetUI() end
function UWBP_PalDismantling_C:UpdateUI() end
---@param WarningText FText
function UWBP_PalDismantling_C:GetWarningText(WarningText) end
function UWBP_PalDismantling_C:DisposeModel() end
function UWBP_PalDismantling_C:FinishDismantling() end
function UWBP_PalDismantling_C:DismantleObjectContinuous() end
function UWBP_PalDismantling_C:DismantlingObject() end
function UWBP_PalDismantling_C:ReturnToMainMenu() end
function UWBP_PalDismantling_C:SetupInputAction() end
UWBP_PalDismantling_C['Setup Model'] = function(self, ) end
function UWBP_PalDismantling_C:AnmEvent_In() end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_PalDismantling_C:Tick(MyGeometry, InDeltaTime) end
function UWBP_PalDismantling_C:OnSetup() end
function UWBP_PalDismantling_C:Destruct() end
function UWBP_PalDismantling_C:Construct() end
---@param EntryPoint int32
function UWBP_PalDismantling_C:ExecuteUbergraph_WBP_PalDismantling(EntryPoint) end


