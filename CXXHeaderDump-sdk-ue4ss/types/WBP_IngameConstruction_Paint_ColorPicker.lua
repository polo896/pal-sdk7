---@meta

---@class UWBP_IngameConstruction_Paint_ColorPicker_C : UUserWidget
---@field Image_190 UImage
---@field Image_229 UImage
---@field Image_Color UImage
---@field Image_Line UImage
---@field WBP_PalKeyGuideIcon UWBP_PalKeyGuideIcon_C
local UWBP_IngameConstruction_Paint_ColorPicker_C = {}

---@param UIModel UPalUIPaintModel
function UWBP_IngameConstruction_Paint_ColorPicker_C:UpdateTarget(UIModel) end
function UWBP_IngameConstruction_Paint_ColorPicker_C:Deactivate() end
---@param TargetColor FLinearColor
function UWBP_IngameConstruction_Paint_ColorPicker_C:ActivateTargetInfo(TargetColor) end
function UWBP_IngameConstruction_Paint_ColorPicker_C:SetupKeyGuide() end
function UWBP_IngameConstruction_Paint_ColorPicker_C:InitUI() end


