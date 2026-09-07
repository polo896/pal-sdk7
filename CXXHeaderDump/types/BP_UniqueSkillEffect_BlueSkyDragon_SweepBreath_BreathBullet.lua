---@meta

---@class ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathBullet_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Sphere USphereComponent
---@field PalProjectileMovement UPalProjectileMovementComponent
---@field Niagara UNiagaraComponent
---@field CurrentSize double
---@field AdjustNormal FVector
---@field CurrentSpeed double
---@field AdjustStrengthWeight double
---@field Turn boolean
---@field EnlargeSpeed double
---@field OriginalRadius float
---@field AdjustStrength float
---@field MinSpeed double
local ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathBullet_C = {}

---@param Direct FVector
---@param Life double
---@param CenterDirect FVector
function ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathBullet_C:SetDirectAndLife(Direct, Life, CenterDirect) end
---@param DeltaSeconds float
function ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathBullet_C:ReceiveTick(DeltaSeconds) end
function ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathBullet_C:EndLife() end
---@param DeltaSecond double
function ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathBullet_C:FadeOutEffect(DeltaSecond) end
---@param EntryPoint int32
function ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathBullet_C:ExecuteUbergraph_BP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathBullet(EntryPoint) end


