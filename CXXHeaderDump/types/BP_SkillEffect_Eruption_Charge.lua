---@meta

---@class ABP_SkillEffect_Eruption_Charge_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ExplosionEffect UNiagaraComponent
---@field MaxEffectDuration float
---@field SplitNum int32
---@field bulletNum int32
---@field Angle int32
---@field BulletNumPerAngle int32
---@field Stream FRandomStream
---@field AttackMinRange double
---@field AttackMaxRange double
---@field IsDirectAttackBulletSpawned boolean
---@field GravityScale double
---@field FallMinTime double
---@field FallMaxTime double
---@field TempEndLocation FVector
local ABP_SkillEffect_Eruption_Charge_C = {}

---@return float
function ABP_SkillEffect_Eruption_Charge_C:GetRandomFallTime_NoPure() end
function ABP_SkillEffect_Eruption_Charge_C:OnInitialize() end
---@param BulletIndex int32
---@param AngleIndex int32
function ABP_SkillEffect_Eruption_Charge_C:SpawnBullet(BulletIndex, AngleIndex) end
---@param EntryPoint int32
function ABP_SkillEffect_Eruption_Charge_C:ExecuteUbergraph_BP_SkillEffect_Eruption_Charge(EntryPoint) end


