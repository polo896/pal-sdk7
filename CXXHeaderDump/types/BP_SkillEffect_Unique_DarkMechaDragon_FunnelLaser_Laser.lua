---@meta

---@class ABP_SkillEffect_Unique_DarkMechaDragon_FunnelLaser_Laser_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field LaserRoot USceneComponent
---@field Capsule UCapsuleComponent
---@field Niagara_Funnel UNiagaraComponent
---@field View USceneComponent
---@field UntilFadeTime double
---@field DelayLaser double
---@field InterpSpeed double
---@field CurveVector UCurveVector
---@field EnableYHoming boolean
---@field HomingLocationYRange FVector2D
---@field IsSpawnedLaser boolean
---@field CurveVectorTimer double
---@field Niagara_Laser UNiagaraComponent
---@field ScaleCache double
local ABP_SkillEffect_Unique_DarkMechaDragon_FunnelLaser_Laser_C = {}

---@param Location FVector
function ABP_SkillEffect_Unique_DarkMechaDragon_FunnelLaser_Laser_C:GetTargetLocation_Override(Location) end
function ABP_SkillEffect_Unique_DarkMechaDragon_FunnelLaser_Laser_C:ReceiveBeginPlay() end
function ABP_SkillEffect_Unique_DarkMechaDragon_FunnelLaser_Laser_C:OnLifeTime() end
---@param DeltaSecond double
function ABP_SkillEffect_Unique_DarkMechaDragon_FunnelLaser_Laser_C:FadeOutEffect(DeltaSecond) end
function ABP_SkillEffect_Unique_DarkMechaDragon_FunnelLaser_Laser_C:SpawnLaser() end
---@param DeltaSeconds float
function ABP_SkillEffect_Unique_DarkMechaDragon_FunnelLaser_Laser_C:ReceiveTick(DeltaSeconds) end
---@param Scale double
function ABP_SkillEffect_Unique_DarkMechaDragon_FunnelLaser_Laser_C:SetScale(Scale) end
---@param EntryPoint int32
function ABP_SkillEffect_Unique_DarkMechaDragon_FunnelLaser_Laser_C:ExecuteUbergraph_BP_SkillEffect_Unique_DarkMechaDragon_FunnelLaser_Laser(EntryPoint) end


