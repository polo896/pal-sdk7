---@meta

---@class UWBP_IngameConstruction_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Caution UWidgetAnimation
---@field BP_PalTextBlock_C_1 UBP_PalTextBlock_C
---@field BP_PalTextBlock_C_39 UBP_PalTextBlock_C
---@field BP_PalTextBlock_C_100 UBP_PalTextBlock_C
---@field BP_PalTextBlock_CautionTitle UBP_PalTextBlock_C
---@field Canvas_Limit UCanvasPanel
---@field CanvasPanel_Caution UCanvasPanel
---@field CanvasPanel_Warning UCanvasPanel
---@field Image UImage
---@field Image_1 UImage
---@field Image_2 UImage
---@field Image_Limit_Base UImage
---@field Image_LimitCautionIcon UImage
---@field Text_Limit UBP_PalTextBlock_C
---@field Text_LimitNum UBP_PalTextBlock_C
---@field VerticalBox_1 UVerticalBox
---@field WBP_Ingameconstruction_KeyGuide_5 UWBP_Ingameconstruction_KeyGuide_C
---@field WBP_Ingameconstruction_KeyGuide_6 UWBP_Ingameconstruction_KeyGuide_C
---@field WBP_Ingameconstruction_KeyGuide_7 UWBP_Ingameconstruction_KeyGuide_C
---@field WBP_Ingameconstruction_KeyGuide_BuildObject_ForGamepad UWBP_Ingameconstruction_KeyGuide_C
---@field WBP_Ingameconstruction_KeyGuide_BuildObjectContinuous_ForGamepad UWBP_Ingameconstruction_KeyGuide_C
---@field WBP_Ingameconstruction_KeyGuide_BuildObjectContinuous_ForMouse UWBP_Ingameconstruction_KeyGuide_C
---@field WBP_Ingameconstruction_KeyGuide_Cancel UWBP_Ingameconstruction_KeyGuide_C
---@field WBP_Ingameconstruction_KeyGuide_End UWBP_Ingameconstruction_KeyGuide_C
---@field WBP_Ingameconstruction_KeyGuide_Rotate UWBP_Ingameconstruction_KeyGuide_C
---@field WBP_IngameConstruction_Num_0 UWBP_IngameConstruction_Num_C
---@field WBP_IngameConstruction_Num_1 UWBP_IngameConstruction_Num_C
---@field WBP_IngameConstruction_Num_2 UWBP_IngameConstruction_Num_C
---@field WBP_IngameConstruction_Num_3 UWBP_IngameConstruction_Num_C
---@field WBP_PalCommonItemIcon UWBP_PalCommonItemIcon_C
---@field WBP_PalCommonItemIcon_1 UWBP_PalCommonItemIcon_C
---@field WBP_PalCommonItemIcon_2 UWBP_PalCommonItemIcon_C
---@field WBP_PalCommonItemIcon_3 UWBP_PalCommonItemIcon_C
---@field ItemNums TArray<UWBP_IngameConstruction_Num_C>
---@field keyGuideMsgHandle_Reserve FDataTableRowHandle
---@field keyGuideMsgHandle_ReserveContinue FDataTableRowHandle
---@field keyGuideMsgHandle_Cancel FDataTableRowHandle
---@field keyGuideMsgHandle_Close FDataTableRowHandle
---@field ItemIconArray TArray<UWBP_PalCommonItemIcon_C>
---@field keyGuideMsgHandle_RotateRight FDataTableRowHandle
---@field keyGuideMsgHandle_RotateLeft FDataTableRowHandle
---@field CachedModel UPalUIBuildingModel
local UWBP_IngameConstruction_C = {}

---@param Model UPalUIBuildingModel
---@param NewParam EPalBuildingNumWarningType
function UWBP_IngameConstruction_C:GetBuildingWarningType(Model, NewParam) end
---@param Model UPalUIBuildingModel
function UWBP_IngameConstruction_C:UpdateBuildingLimit(Model) end
---@param Model UPalUIBuildingModel
function UWBP_IngameConstruction_C:UpdateDisplayContent(Model) end
---@param NewVisibility ESlateVisibility
function UWBP_IngameConstruction_C:SetVisibilityOutSideBaseCampWarning(NewVisibility) end
---@param Model UPalUIBuildingModel
function UWBP_IngameConstruction_C:SetupKeyGuide(Model) end
---@param IsEnable boolean
function UWBP_IngameConstruction_C:SetEnableWarning(IsEnable) end
---@param Index int32
---@param StaticItemId FName
---@param ItemCount int32
function UWBP_IngameConstruction_C:SetMaterial(Index, StaticItemId, ItemCount) end
---@param inBuildObjectData FPalBuildObjectData
function UWBP_IngameConstruction_C:Setup(inBuildObjectData) end
---@param InText FText
function UWBP_IngameConstruction_C:SetWarningText(InText) end
---@param Model UPalUIBuildingModel
function UWBP_IngameConstruction_C:ResetAllUI(Model) end
---@param InName FText
function UWBP_IngameConstruction_C:SetBuildObjectName(InName) end
function UWBP_IngameConstruction_C:Construct() end
function UWBP_IngameConstruction_C:OnInitialized() end
---@param bNewInputType ECommonInputType
function UWBP_IngameConstruction_C:OnChangedInputMethod(bNewInputType) end
---@param EntryPoint int32
function UWBP_IngameConstruction_C:ExecuteUbergraph_WBP_IngameConstruction(EntryPoint) end


