---@meta

---@class ABP_BuildObject_Altar_C : APalBuildObjectRaidBossSummon
---@field UberGraphFrame FPointerToUberGraphFrame
---@field RaidBossSummonParameter UPalMapObjectRaidBossSummonParameterComponent
---@field PalLimitVolumeBox UPalLimitVolumeBoxComponent
---@field SM_PalHealingMachine UStaticMeshComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field BuildWorkableBounds UBoxComponent
---@field CheckOverlapCollision UBoxComponent
---@field DefaultSceneRoot USceneComponent
---@field _________Track_0_FA7ECEA24E645B7F041C05A2FDD75DDF float
---@field ________Direction_FA7ECEA24E645B7F041C05A2FDD75DDF ETimelineDirection::Type
---@field ['タイムライン'] UTimelineComponent
---@field Material_PalSummoningStandBase UMaterialInstanceDynamic
---@field Material_PalSummoningStandTower UMaterialInstanceDynamic
---@field SummonFX UNiagaraSystem
local ABP_BuildObject_Altar_C = {}

ABP_BuildObject_Altar_C['タイムライン__FinishedFunc'] = function(self, ) end
ABP_BuildObject_Altar_C['タイムライン__UpdateFunc'] = function(self, ) end
function ABP_BuildObject_Altar_C:BP_PlayPerform() end
function ABP_BuildObject_Altar_C:BroadcastPlayPerform() end
function ABP_BuildObject_Altar_C:ResetPlayPerform() end
---@param EntryPoint int32
function ABP_BuildObject_Altar_C:ExecuteUbergraph_BP_BuildObject_Altar(EntryPoint) end


