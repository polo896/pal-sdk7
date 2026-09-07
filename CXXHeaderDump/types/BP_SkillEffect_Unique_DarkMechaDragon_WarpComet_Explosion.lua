---@meta

---@class ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Explosion_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Capsule UCapsuleComponent
---@field Niagara UNiagaraComponent
---@field TimeUntilFade double
local ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Explosion_C = {}

---@param Scale double
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Explosion_C:SetScale(Scale) end
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Explosion_C:ReceiveBeginPlay() end
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Explosion_C:OnLifeTime() end
---@param DeltaSecond double
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Explosion_C:FadeOutEffect(DeltaSecond) end
---@param EntryPoint int32
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Explosion_C:ExecuteUbergraph_BP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Explosion(EntryPoint) end


