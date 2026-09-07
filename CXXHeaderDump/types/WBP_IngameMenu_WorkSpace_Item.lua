---@meta

---@class UWBP_IngameMenu_WorkSpace_Item_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_EnableToDisable UWidgetAnimation
---@field BP_PalTextBlock_Name UBP_PalTextBlock_C
---@field BP_PalTextBlock_Num UBP_PalTextBlock_C
---@field Icon UImage
---@field bUseBaseCampStorage boolean
---@field TempItemCount int32
local UWBP_IngameMenu_WorkSpace_Item_C = {}

---@param ItemStaticId FName
---@param requireNum int32
function UWBP_IngameMenu_WorkSpace_Item_C:Setup(ItemStaticId, requireNum) end
---@param EntryPoint int32
function UWBP_IngameMenu_WorkSpace_Item_C:ExecuteUbergraph_WBP_IngameMenu_WorkSpace_Item(EntryPoint) end


