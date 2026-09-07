---@meta

---@class ABP_SkillEffect_SeaGush_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field SpawnRadius double
---@field ExplosionWaitTime double
---@field ExplosionInterval double
---@field IntervalTimer FTimerHandle
---@field CurrentPhase int32
---@field Locations TArray<FVector>
---@field BulletRadius double
---@field PhaseSetting TArray<int32>
---@field CurrentIndex int32
local ABP_SkillEffect_SeaGush_C = {}

function ABP_SkillEffect_SeaGush_C:SwitchPhase() end
---@param NewParam TSubclassOf<ABP_SkillEffectBase_C>
function ABP_SkillEffect_SeaGush_C:GetEffect(NewParam) end
---@param PointCount int32
ABP_SkillEffect_SeaGush_C['Get Random Locations'] = function(self, PointCount) end
function ABP_SkillEffect_SeaGush_C:SpawnBullet() end
function ABP_SkillEffect_SeaGush_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_SkillEffect_SeaGush_C:ExecuteUbergraph_BP_SkillEffect_SeaGush(EntryPoint) end


