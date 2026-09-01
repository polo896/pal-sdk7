---@meta

---@class UWBP_IngameConstruction_Paint_ColorPreset_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_NormalToFocus UWidgetAnimation
---@field ColorSelect_Square UImage
---@field WBP_PalInvisibleButton UWBP_PalInvisibleButton_C
---@field OnClickButton FWBP_IngameConstruction_Paint_ColorPreset_COnClickButton
local UWBP_IngameConstruction_Paint_ColorPreset_C = {}

---@param InColor FLinearColor
function UWBP_IngameConstruction_Paint_ColorPreset_C:SetColor(InColor) end
---@param Button UCommonButtonBase
function UWBP_IngameConstruction_Paint_ColorPreset_C:BndEvt__WBP_IngameConstruction_Paint_ColorPreset_WBP_PalInvisibleButton_K2Node_ComponentBoundEvent_0_OnButtonReleased__DelegateSignature(Button) end
---@param EntryPoint int32
function UWBP_IngameConstruction_Paint_ColorPreset_C:ExecuteUbergraph_WBP_IngameConstruction_Paint_ColorPreset(EntryPoint) end
---@param Color FLinearColor
function UWBP_IngameConstruction_Paint_ColorPreset_C:OnClickButton__DelegateSignature(Color) end


