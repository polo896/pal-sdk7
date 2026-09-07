---@meta

---@class ABP_GatlingGun_NPC_C : ABP_GatlingGun_C
---@field UberGraphFrame FPointerToUberGraphFrame
local ABP_GatlingGun_NPC_C = {}

function ABP_GatlingGun_NPC_C:PlayReloadAnimation() end
---@return FTransform
function ABP_GatlingGun_NPC_C:GetLeftHandTransform() end
---@return int32
function ABP_GatlingGun_NPC_C:GetNPCWeaponDamage() end
---@return int32
function ABP_GatlingGun_NPC_C:GetWeaponDamage() end
function ABP_GatlingGun_NPC_C:BPI_OnReload() end
---@param EntryPoint int32
function ABP_GatlingGun_NPC_C:ExecuteUbergraph_BP_GatlingGun_NPC(EntryPoint) end


