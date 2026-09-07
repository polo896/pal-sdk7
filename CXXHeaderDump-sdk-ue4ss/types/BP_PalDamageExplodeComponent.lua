---@meta

---@class UBP_PalDamageExplodeComponent_C : UPalDamageExplodeComponent
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ExClass TSubclassOf<ABP_ExplosionAttackBase_C>
---@field Power int32
---@field OnSpawnEx FBP_PalDamageExplodeComponent_COnSpawnEx
---@field OffsetUp double
local UBP_PalDamageExplodeComponent_C = {}

---@param Attacker AActor
function UBP_PalDamageExplodeComponent_C:SpawnExplosionActor(Attacker) end
---@param Attacker AActor
function UBP_PalDamageExplodeComponent_C:SpawnEx_ToAll(Attacker) end
---@param Attacker AActor
---@param DelayTime float
function UBP_PalDamageExplodeComponent_C:SpawnExplosionActor_Delay(Attacker, DelayTime) end
---@param EntryPoint int32
function UBP_PalDamageExplodeComponent_C:ExecuteUbergraph_BP_PalDamageExplodeComponent(EntryPoint) end
function UBP_PalDamageExplodeComponent_C:OnSpawnEx__DelegateSignature() end


