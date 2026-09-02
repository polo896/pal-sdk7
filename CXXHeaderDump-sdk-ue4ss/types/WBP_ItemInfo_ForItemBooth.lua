---@meta

---@class UWBP_ItemInfo_ForItemBooth_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_InventoryEquipment_ItemInfo_Cost UWBP_InventoryEquipment_ItemInfo_C
---@field WBP_InventoryEquipment_ItemInfo_Product UWBP_InventoryEquipment_ItemInfo_C
local UWBP_ItemInfo_ForItemBooth_C = {}

---@param Product FPalItemAndNum
---@param Cost FPalItemAndNum
function UWBP_ItemInfo_ForItemBooth_C:SetItemPairInfo(Product, Cost) end
---@param EntryPoint int32
function UWBP_ItemInfo_ForItemBooth_C:ExecuteUbergraph_WBP_ItemInfo_ForItemBooth(EntryPoint) end


