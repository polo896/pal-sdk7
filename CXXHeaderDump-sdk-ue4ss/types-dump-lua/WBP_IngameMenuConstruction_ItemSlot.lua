---@meta

---@class UWBP_IngameMenuConstruction_ItemSlot_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_OnToOff_WithoutText UWidgetAnimation
---@field Anm_LtoS UWidgetAnimation
---@field Anm_OnToOff UWidgetAnimation
---@field CanvasPanel_2 UCanvasPanel
---@field CanvasPanel_Lock UCanvasPanel
---@field Icon UImage
---@field Text_BuildObjectName UBP_PalTextBlock_C
---@field Text_Label UBP_PalTextBlock_C
---@field WBP_MainMenu_NewDot UWBP_MainMenu_NewDot_C
---@field WBP_PalCommonNewMark_0 UWBP_PalCommonNewMark_0_C
---@field BuildObjectData FPalBuildObjectData
---@field NotEnoughMaterialMsgID FDataTableRowHandle
---@field NoBlueprintlMsgID FDataTableRowHandle
local UWBP_IngameMenuConstruction_ItemSlot_C = {}

---@param Visable boolean
function UWBP_IngameMenuConstruction_ItemSlot_C:SetNewIconVisibility(Visable) end
---@return FVector2D
function UWBP_IngameMenuConstruction_ItemSlot_C:GetCanvasSize() end
---@param BuildObjectData FPalBuildObjectData
function UWBP_IngameMenuConstruction_ItemSlot_C:Setup(BuildObjectData) end
function UWBP_IngameMenuConstruction_ItemSlot_C:AnmEvent_CannotBuild_NotEnoughMaterials() end
function UWBP_IngameMenuConstruction_ItemSlot_C:AnmEvent_CannotBuild_NoBlueprint() end
function UWBP_IngameMenuConstruction_ItemSlot_C:AnmEvent_Small() end
function UWBP_IngameMenuConstruction_ItemSlot_C:AnmEvent_CannotBuild_NoText() end
function UWBP_IngameMenuConstruction_ItemSlot_C:Construct() end
function UWBP_IngameMenuConstruction_ItemSlot_C:DisableTextForDeck() end
---@param EntryPoint int32
function UWBP_IngameMenuConstruction_ItemSlot_C:ExecuteUbergraph_WBP_IngameMenuConstruction_ItemSlot(EntryPoint) end


