---@meta

---@class ABP_SkillEffect_SeaGush_Bullet_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Capsule UCapsuleComponent
---@field ExplosionEffect UNiagaraComponent
---@field OmenEffect UNiagaraComponent
---@field CollisionTime double
---@field Timer FTimerHandle
local ABP_SkillEffect_SeaGush_Bullet_C = {}

---@param NiagaraComp UNiagaraComponent
function ABP_SkillEffect_SeaGush_Bullet_C:SetRandomValueIntoNiagaraVariable(NiagaraComp) end
function ABP_SkillEffect_SeaGush_Bullet_C:Explosion() end
function ABP_SkillEffect_SeaGush_Bullet_C:InitializeEffect() end
function ABP_SkillEffect_SeaGush_Bullet_C:OnInitialize() end
function ABP_SkillEffect_SeaGush_Bullet_C:OnExplosion() end
---@param DeltaSecond double
function ABP_SkillEffect_SeaGush_Bullet_C:FadeOutEffect(DeltaSecond) end
---@param Location FVector
---@param DelayTime double
function ABP_SkillEffect_SeaGush_Bullet_C:Setup(Location, DelayTime) end
---@param EntryPoint int32
function ABP_SkillEffect_SeaGush_Bullet_C:ExecuteUbergraph_BP_SkillEffect_SeaGush_Bullet(EntryPoint) end


