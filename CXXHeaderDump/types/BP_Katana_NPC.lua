---@meta

---@class ABP_Katana_NPC_C : ABP_Bat_C
---@field UberGraphFrame FPointerToUberGraphFrame
local ABP_Katana_NPC_C = {}

---@return int32
function ABP_Katana_NPC_C:GetNPCWeaponDamage() end
---@return int32
function ABP_Katana_NPC_C:GetWeaponDamage() end
function ABP_Katana_NPC_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_Katana_NPC_C:ExecuteUbergraph_BP_Katana_NPC(EntryPoint) end


