---@meta

---@class UWBP_ConvertItemStatusIndicator_Dual_C : UPalUIMapObjectStatusIndicatorBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_PalWorkProduct_Dual UWBP_PalWorkProduct_Dual_C
---@field isDisplayedDetail boolean
---@field isValidRecipe boolean
---@field displayDetailRange double
---@field LocationCheckTimerHandle FTimerHandle
---@field IsFirstSetup boolean
---@field Model UPalMapObjectConvertItemModel
local UWBP_ConvertItemStatusIndicator_Dual_C = {}

---@param Work UPalWorkBase
function UWBP_ConvertItemStatusIndicator_Dual_C:OnUpdatedWorkerPal(Work) end
function UWBP_ConvertItemStatusIndicator_Dual_C:CloseDetail() end
function UWBP_ConvertItemStatusIndicator_Dual_C:DisplayDetail() end
---@param WorkProgress UPalWorkProgress
function UWBP_ConvertItemStatusIndicator_Dual_C:OnReflectWorkProgress(WorkProgress) end
---@param Slot UPalItemSlot
function UWBP_ConvertItemStatusIndicator_Dual_C:OnUpdateProductSlot(Slot) end
---@param Model UPalMapObjectConvertItemModel
function UWBP_ConvertItemStatusIndicator_Dual_C:UpdateProductNum(Model) end
---@param Model UPalMapObjectConvertItemModel
function UWBP_ConvertItemStatusIndicator_Dual_C:OnUpdateRecipe(Model) end
function UWBP_ConvertItemStatusIndicator_Dual_C:Initialize() end
function UWBP_ConvertItemStatusIndicator_Dual_C:OnSetup() end
function UWBP_ConvertItemStatusIndicator_Dual_C:Construct() end
function UWBP_ConvertItemStatusIndicator_Dual_C:CheckLocationEvent() end
function UWBP_ConvertItemStatusIndicator_Dual_C:Destruct() end
---@param EntryPoint int32
function UWBP_ConvertItemStatusIndicator_Dual_C:ExecuteUbergraph_WBP_ConvertItemStatusIndicator_Dual(EntryPoint) end


