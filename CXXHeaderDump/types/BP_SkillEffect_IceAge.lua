---@meta

---@class ABP_SkillEffect_IceAge_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BulletNumLimit int32
---@field SpawnRadius double
---@field ExplosionWaitTime double
---@field ExplosionInterval double
---@field SpawnEffects TArray<APalSkillEffectBase>
---@field ExplosionTimer FTimerHandle
---@field IntervalTimer FTimerHandle
---@field IsSpawned boolean
---@field Index int32
---@field Locations TArray<FVector>
---@field BulletRadius double
---@field SpawnCenterDistance double
---@field SpawnCenterLocation FVector
local ABP_SkillEffect_IceAge_C = {}

---@param NewParam TArray<FVector2D>
function ABP_SkillEffect_IceAge_C:GetRandomPointList(NewParam) end
---@param NewParam TSubclassOf<ABP_SkillEffectBase_C>
function ABP_SkillEffect_IceAge_C:GetEffect(NewParam) end
---@param Location FVector
---@param Index int32
---@param IsInside boolean
function ABP_SkillEffect_IceAge_C:GetInsertIndex(Location, Index, IsInside) end
function ABP_SkillEffect_IceAge_C:SpawnBullet() end
function ABP_SkillEffect_IceAge_C:Explosion() end
---@param DeltaSeconds float
function ABP_SkillEffect_IceAge_C:ReceiveTick(DeltaSeconds) end
function ABP_SkillEffect_IceAge_C:OnExlosion() end
function ABP_SkillEffect_IceAge_C:StartInterval() end
---@param EntryPoint int32
function ABP_SkillEffect_IceAge_C:ExecuteUbergraph_BP_SkillEffect_IceAge(EntryPoint) end


