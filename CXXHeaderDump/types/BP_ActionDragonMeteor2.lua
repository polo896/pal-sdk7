---@meta

---@class UBP_ActionDragonMeteor2_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Height double
---@field MeteorCount int32
---@field ['Out Locations'] TArray<FVector>
---@field Interval float
---@field CurrentCount int32
---@field MeteorTimer FTimerHandle
local UBP_ActionDragonMeteor2_C = {}

---@param Index int32
---@param OutLocations TArray<FVector>
function UBP_ActionDragonMeteor2_C:CalcMeteorLocation(Index, OutLocations) end
function UBP_ActionDragonMeteor2_C:OnStartProcessAnimation() end
function UBP_ActionDragonMeteor2_C:OnBeginAction() end
---@param Effect APalSkillEffectBase
function UBP_ActionDragonMeteor2_C:OnSpawnEffect(Effect) end
function UBP_ActionDragonMeteor2_C:OnEndAction() end
function UBP_ActionDragonMeteor2_C:SpawnMeteor() end
---@param EntryPoint int32
function UBP_ActionDragonMeteor2_C:ExecuteUbergraph_BP_ActionDragonMeteor2(EntryPoint) end


