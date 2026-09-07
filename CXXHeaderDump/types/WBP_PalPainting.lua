---@meta

---@class UWBP_PalPainting_C : UPalUserWidgetStackableUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Paint UWidgetAnimation
---@field Base_1 UImage
---@field Base_2 UImage
---@field Base_3 UImage
---@field Base_Flash UImage
---@field Base_L_1 UImage
---@field Base_R_1 UImage
---@field Base_R_2 UImage
---@field Base_R_3 UImage
---@field Image UImage
---@field Image_181 UImage
---@field Image_Icon UImage
---@field Overlay_Reticle UOverlay
---@field WBP_IngameConstruction_Paint UWBP_IngameConstruction_Paint_C
---@field WBP_IngameConstruction_Paint_ColorPicker_80 UWBP_IngameConstruction_Paint_ColorPicker_C
---@field WBP_PalKeyGuideIcon UWBP_PalKeyGuideIcon_C
---@field CancelActionInput FPalDataTableRowName_UIInputAction
---@field CancelActionInput_02 FPalDataTableRowName_UIInputAction
---@field ForceCloseActionInput FPalDataTableRowName_UIInputAction
---@field ForceCloseActionInput02 FPalDataTableRowName_UIInputAction
---@field PaintObjectActionInput FPalDataTableRowName_UIInputAction
---@field UIModel UPalUIPaintModel
---@field BuilderComponent UPalBuilderComponent
---@field TargetObject APalBuildObject
---@field RemoveColorActionInput FPalDataTableRowName_UIInputAction
---@field EditColorActionInput FPalDataTableRowName_UIInputAction
---@field PickColorActionInput FPalDataTableRowName_UIInputAction
---@field CancelPaintingActionInput_FromRadialMenu FPalDataTableRowName_UIInputAction
---@field CancelPaintingActionInput_FromRadialMenu_0 FPalDataTableRowName_UIInputAction
---@field MoveselectPickColorRightActionInput FPalDataTableRowName_UIInputAction
---@field MoveselectPickColorLeftActionInput FPalDataTableRowName_UIInputAction
---@field MoveselectPickColorUpActionInput FPalDataTableRowName_UIInputAction
---@field MoveselectPickColorDownActionInput FPalDataTableRowName_UIInputAction
---@field SlotNumInPage int32
---@field PageNum int32
---@field ChangeModeInputAction FPalDataTableRowName_UIInputAction
local UWBP_PalPainting_C = {}

function UWBP_PalPainting_C:OnEsc() end
function UWBP_PalPainting_C:ChangeMode() end
---@param Return_Value TArray<FFPalUIPaintPaletteInfo>
function UWBP_PalPainting_C:GetCurentSlotPaletteInfos(Return_Value) end
---@param Model UPalUIPaintModel
---@param PaletteIndex int32
function UWBP_PalPainting_C:OnUpdatePaletteColor(Model, PaletteIndex) end
---@param Model UPalUIPaintModel
---@param LastPaletteIndex int32
function UWBP_PalPainting_C:OnUpdateSelectedPaletteIndex(Model, LastPaletteIndex) end
---@param Index int32
---@param StartIndex int32
---@param EndIndex int32
function UWBP_PalPainting_C:CalcPageStartEndIndex(Index, StartIndex, EndIndex) end
---@param Return_Value int32
function UWBP_PalPainting_C:SlotNum(Return_Value) end
---@param PaletteIndex int32
---@param pageIndex int32
---@param SlotIndex int32
function UWBP_PalPainting_C:ToPageSlotIndex(PaletteIndex, pageIndex, SlotIndex) end
---@param pageIndex int32
---@param SlotIndex int32
---@param PaletteIndex int32
function UWBP_PalPainting_C:ToPaletteIndex(pageIndex, SlotIndex, PaletteIndex) end
function UWBP_PalPainting_C:EmptyFunction() end
function UWBP_PalPainting_C:MoveSelectPaintColor_Right() end
function UWBP_PalPainting_C:MoveSelectPaintColor_Left() end
function UWBP_PalPainting_C:MoveSelectPaintColor_Down() end
function UWBP_PalPainting_C:MoveSelectPaintColor_Up() end
function UWBP_PalPainting_C:OpenEditPaletteColor() end
function UWBP_PalPainting_C:PickColor() end
function UWBP_PalPainting_C:RemoveColorStop() end
function UWBP_PalPainting_C:RemoveColorStart() end
function UWBP_PalPainting_C:PaintingObjectStop() end
function UWBP_PalPainting_C:PaintingObjectStart() end
function UWBP_PalPainting_C:ResetUI() end
function UWBP_PalPainting_C:UpdateUI() end
function UWBP_PalPainting_C:InitUI() end
---@param WarningText FText
function UWBP_PalPainting_C:GetWarningText(WarningText) end
function UWBP_PalPainting_C:DisposeModel() end
function UWBP_PalPainting_C:FinishPainting() end
function UWBP_PalPainting_C:ReturnToMainMenu() end
function UWBP_PalPainting_C:SetupInputAction() end
UWBP_PalPainting_C['Setup Model'] = function(self, ) end
function UWBP_PalPainting_C:AnmEvent_In() end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_PalPainting_C:Tick(MyGeometry, InDeltaTime) end
function UWBP_PalPainting_C:OnSetup() end
function UWBP_PalPainting_C:Destruct() end
function UWBP_PalPainting_C:Construct() end
---@param EntryPoint int32
function UWBP_PalPainting_C:ExecuteUbergraph_WBP_PalPainting(EntryPoint) end


