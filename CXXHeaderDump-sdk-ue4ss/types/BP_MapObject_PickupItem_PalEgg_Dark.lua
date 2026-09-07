---@meta

---@class ABP_MapObject_PickupItem_PalEgg_Dark_C : ABP_MapObject_PickupItem_PalEgg_Base_C
---@field UberGraphFrame FPointerToUberGraphFrame
local ABP_MapObject_PickupItem_PalEgg_Dark_C = {}

---@return FPalObjectPoolParameter
function ABP_MapObject_PickupItem_PalEgg_Dark_C:GetObjectPoolParameter() end
---@return boolean
function ABP_MapObject_PickupItem_PalEgg_Dark_C:IsShowOutlineInReticleTargetting() end
function ABP_MapObject_PickupItem_PalEgg_Dark_C:InitializeFromPool() end
function ABP_MapObject_PickupItem_PalEgg_Dark_C:ReturnToPool() end
---@param EntryPoint int32
function ABP_MapObject_PickupItem_PalEgg_Dark_C:ExecuteUbergraph_BP_MapObject_PickupItem_PalEgg_Dark(EntryPoint) end


