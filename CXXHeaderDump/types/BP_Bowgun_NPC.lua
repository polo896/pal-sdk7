---@meta

---@class ABP_Bowgun_NPC_C : ABP_Bowgun_C
---@field UberGraphFrame FPointerToUberGraphFrame
local ABP_Bowgun_NPC_C = {}

---@param NewParam TSubclassOf<APalBullet>
function ABP_Bowgun_NPC_C:GetBulletClass(NewParam) end
---@return int32
function ABP_Bowgun_NPC_C:GetNPCWeaponDamage() end
---@return int32
function ABP_Bowgun_NPC_C:GetWeaponDamage() end
function ABP_Bowgun_NPC_C:BPI_OnReload() end
---@param EntryPoint int32
function ABP_Bowgun_NPC_C:ExecuteUbergraph_BP_Bowgun_NPC(EntryPoint) end


