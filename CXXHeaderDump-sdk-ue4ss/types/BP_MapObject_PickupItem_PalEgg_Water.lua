---@meta

---@class ABP_MapObject_PickupItem_PalEgg_Water_C : ABP_MapObject_PickupItem_PalEgg_Base_C
---@field UberGraphFrame FPointerToUberGraphFrame
local ABP_MapObject_PickupItem_PalEgg_Water_C = {}

---@return FPalObjectPoolParameter
function ABP_MapObject_PickupItem_PalEgg_Water_C:GetObjectPoolParameter() end
function ABP_MapObject_PickupItem_PalEgg_Water_C:InitializeFromPool() end
function ABP_MapObject_PickupItem_PalEgg_Water_C:ReturnToPool() end
---@param EntryPoint int32
function ABP_MapObject_PickupItem_PalEgg_Water_C:ExecuteUbergraph_BP_MapObject_PickupItem_PalEgg_Water(EntryPoint) end


