---@meta

---@class UWBP_IngameConstruction_Paint_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_ColorSetChange UWidgetAnimation
---@field Anm_Caution UWidgetAnimation
---@field BP_PalTextBlock_C_39 UBP_PalTextBlock_C
---@field BP_PalTextBlock_C_100 UBP_PalTextBlock_C
---@field CanvasPanel_Warning UCanvasPanel
---@field Image UImage
---@field Image_1 UImage
---@field Image_2 UImage
---@field VerticalBox_1 UVerticalBox
---@field WBP_Common_PagingDot UWBP_Common_PagingDot_C
---@field WBP_Common_PagingDot_1 UWBP_Common_PagingDot_C
---@field WBP_Common_PagingDot_2 UWBP_Common_PagingDot_C
---@field WBP_Ingameconstruction_KeyGuide UWBP_Ingameconstruction_KeyGuide_C
---@field WBP_Ingameconstruction_KeyGuide_1 UWBP_Ingameconstruction_KeyGuide_C
---@field WBP_Ingameconstruction_KeyGuide_2 UWBP_Ingameconstruction_KeyGuide_C
---@field WBP_Ingameconstruction_KeyGuide_3 UWBP_Ingameconstruction_KeyGuide_C
---@field WBP_Ingameconstruction_KeyGuide_4 UWBP_Ingameconstruction_KeyGuide_C
---@field WBP_Ingameconstruction_KeyGuide_5 UWBP_Ingameconstruction_KeyGuide_C
---@field WBP_IngameConstruction_Paint_Color UWBP_IngameConstruction_Paint_Color_C
---@field WBP_IngameConstruction_Paint_Color_1 UWBP_IngameConstruction_Paint_Color_C
---@field WBP_IngameConstruction_Paint_Color_2 UWBP_IngameConstruction_Paint_Color_C
---@field WBP_IngameConstruction_Paint_Color_3 UWBP_IngameConstruction_Paint_Color_C
---@field WBP_IngameConstruction_Paint_Color_4 UWBP_IngameConstruction_Paint_Color_C
---@field WBP_PlayerInputKeyGuideIcon_0 UWBP_PlayerInputKeyGuideIcon_C
---@field ItemNums TArray<UWBP_IngameConstruction_Num_C>
---@field keyGuideMsgHandle_PaintColor FDataTableRowHandle
---@field keyGuideMsgHandle_RemoveColor FDataTableRowHandle
---@field keyGuideMsgHandle_Cancel FDataTableRowHandle
---@field keyGuideMsgHandle_Close FDataTableRowHandle
---@field keyGuideMsgHandle_PickColor FDataTableRowHandle
---@field keyGuideMsgHandle_EditColor FDataTableRowHandle
---@field ItemIconArray TArray<UWBP_PalCommonItemIcon_C>
---@field keyGuideMsgHandle_RotateRight FDataTableRowHandle
---@field keyGuideMsgHandle_RotateLeft FDataTableRowHandle
---@field CachedModel UPalUIBuildingModel
local UWBP_IngameConstruction_Paint_C = {}

---@param Index int32
---@param Output UWBP_Common_PagingDot_C
function UWBP_IngameConstruction_Paint_C:FindPageDotWidget(Index, Output) end
---@param Return_Value TArray<UWBP_Common_PagingDot_C>
function UWBP_IngameConstruction_Paint_C:GetPageDotWidgets(Return_Value) end
---@param SlotIndex int32
---@param Output UWBP_IngameConstruction_Paint_Color_C
function UWBP_IngameConstruction_Paint_C:FindSlotWidget(SlotIndex, Output) end
---@param Return_Value TArray<UWBP_IngameConstruction_Paint_Color_C>
function UWBP_IngameConstruction_Paint_C:GetSlotWidgets(Return_Value) end
---@param SlotIndex int32
---@param PaletteInfo FFPalUIPaintPaletteInfo
function UWBP_IngameConstruction_Paint_C:NotifyUpdatePaletteColor(SlotIndex, PaletteInfo) end
---@param PaletteInfos TArray<FFPalUIPaintPaletteInfo>
function UWBP_IngameConstruction_Paint_C:ReflectAllSlotPaletteInfo(PaletteInfos) end
---@param NewSlotIndex int32
function UWBP_IngameConstruction_Paint_C:NotifyUpdateSelectedSlotIndex(NewSlotIndex) end
---@param NewPageIndex int32
---@param LastPageIndex int32
function UWBP_IngameConstruction_Paint_C:NotifyUpdateSelectedPageIndex(NewPageIndex, LastPageIndex) end
---@param Model UPalUIBuildingModel
---@param NewParam EPalBuildingNumWarningType
function UWBP_IngameConstruction_Paint_C:GetBuildingWarningType(Model, NewParam) end
function UWBP_IngameConstruction_Paint_C:SetupKeyGuide() end
---@param IsEnable boolean
function UWBP_IngameConstruction_Paint_C:SetEnableWarning(IsEnable) end
---@param inBuildObjectData FPalBuildObjectData
function UWBP_IngameConstruction_Paint_C:Setup(inBuildObjectData) end
---@param InText FText
function UWBP_IngameConstruction_Paint_C:SetWarningText(InText) end
function UWBP_IngameConstruction_Paint_C:ResetAllUI() end
function UWBP_IngameConstruction_Paint_C:InitUI() end
---@param InName FText
function UWBP_IngameConstruction_Paint_C:SetBuildObjectName(InName) end
function UWBP_IngameConstruction_Paint_C:PlayAnimation_ColorSetChange() end
function UWBP_IngameConstruction_Paint_C:Construct() end
function UWBP_IngameConstruction_Paint_C:OnInitialized() end
---@param EntryPoint int32
function UWBP_IngameConstruction_Paint_C:ExecuteUbergraph_WBP_IngameConstruction_Paint(EntryPoint) end


