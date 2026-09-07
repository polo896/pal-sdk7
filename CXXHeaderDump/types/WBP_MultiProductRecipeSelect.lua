---@meta

---@class UWBP_MultiProductRecipeSelect_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_PalWork_RecipeSelect UWBP_PalWork_RecipeSelect_C
---@field Model UPalUIMapObjectMultiProductModel
local UWBP_MultiProductRecipeSelect_C = {}

---@param SelfWidget UWBP_PalConvertItemMenu_RecipeSlotButton_C
function UWBP_MultiProductRecipeSelect_C:OnUnhoverSlot(SelfWidget) end
---@param SelfWidget UWBP_PalConvertItemMenu_RecipeSlotButton_C
function UWBP_MultiProductRecipeSelect_C:OnHoverSlot(SelfWidget) end
---@param SelfWidget UWBP_PalConvertItemMenu_RecipeSlotButton_C
function UWBP_MultiProductRecipeSelect_C:OnClickSlot(SelfWidget) end
---@return UWidget
function UWBP_MultiProductRecipeSelect_C:BP_GetDesiredFocusTarget() end
function UWBP_MultiProductRecipeSelect_C:SetupRecipeList() end
function UWBP_MultiProductRecipeSelect_C:OnSetup() end
function UWBP_MultiProductRecipeSelect_C:OnClose() end
---@param EntryPoint int32
function UWBP_MultiProductRecipeSelect_C:ExecuteUbergraph_WBP_MultiProductRecipeSelect(EntryPoint) end


