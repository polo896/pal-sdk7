---@meta

---@class ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathManager_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BreathTimer FTimerHandle
---@field AttackInterval float
---@field BulletLife double
---@field ScatterDegree float
local ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathManager_C = {}

function ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathManager_C:SpawnBullet() end
function ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathManager_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathManager_C:ReceiveTick(DeltaSeconds) end
function ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathManager_C:SetFade() end
---@param DeltaSecond double
function ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathManager_C:FadeOutEffect(DeltaSecond) end
---@param EntryPoint int32
function ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathManager_C:ExecuteUbergraph_BP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathManager(EntryPoint) end


