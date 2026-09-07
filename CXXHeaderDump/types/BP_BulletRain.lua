---@meta

---@class ABP_BulletRain_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BulletClass TSubclassOf<AActor>
---@field ShootTimeInterval double
---@field ShootDistanceInterval double
---@field ShootNum int32
---@field SplitNum int32
---@field ShootCounter int32
---@field RotatorLookingAtTarget FRotator
---@field OwnerLocation FVector
---@field ThunderTimer FTimerHandle
local ABP_BulletRain_C = {}

---@param Count int32
function ABP_BulletRain_C:SpawnBullet(Count) end
ABP_BulletRain_C['Update Thunder Spawn'] = function(self, ) end
function ABP_BulletRain_C:ReceiveBeginPlay() end
---@param EndPlayReason EEndPlayReason::Type
function ABP_BulletRain_C:ReceiveEndPlay(EndPlayReason) end
---@param EntryPoint int32
function ABP_BulletRain_C:ExecuteUbergraph_BP_BulletRain(EntryPoint) end


