---@meta

---@class ABP_GatlingGun_NPC_Otomo_C : ABP_GatlingGun_C
---@field UberGraphFrame FPointerToUberGraphFrame
local ABP_GatlingGun_NPC_Otomo_C = {}

function ABP_GatlingGun_NPC_Otomo_C:PlayReloadAnimation() end
---@return FTransform
function ABP_GatlingGun_NPC_Otomo_C:GetLeftHandTransform() end
---@return int32
function ABP_GatlingGun_NPC_Otomo_C:GetNPCWeaponDamage() end
---@return int32
function ABP_GatlingGun_NPC_Otomo_C:GetWeaponDamage() end
---@param InReloadSpeedPlayRate float
function ABP_GatlingGun_NPC_Otomo_C:OnReloadStart(InReloadSpeedPlayRate) end
---@param EntryPoint int32
function ABP_GatlingGun_NPC_Otomo_C:ExecuteUbergraph_BP_GatlingGun_NPC_Otomo(EntryPoint) end


