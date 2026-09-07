---@meta

---@class ABP_Shotgun_NPC_C : ABP_PumpActionShotgun_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ReloadCount int32
local ABP_Shotgun_NPC_C = {}

---@return int32
function ABP_Shotgun_NPC_C:GetNPCWeaponDamage() end
---@return int32
function ABP_Shotgun_NPC_C:GetWeaponDamage() end
---@param Type EWeaponNotifyType
function ABP_Shotgun_NPC_C:OnWeaponNotify(Type) end
function ABP_Shotgun_NPC_C:BPI_OnReload() end
---@param EntryPoint int32
function ABP_Shotgun_NPC_C:ExecuteUbergraph_BP_Shotgun_NPC(EntryPoint) end


