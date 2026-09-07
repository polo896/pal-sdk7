---@meta

---@class ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_WarpTrail_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field TimeUntilFade double
local ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_WarpTrail_C = {}

---@param Scale double
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_WarpTrail_C:SetScale(Scale) end
---@param DeltaSecond double
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_WarpTrail_C:FadeOutEffect(DeltaSecond) end
---@param Duration double
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_WarpTrail_C:SetLifeTimer(Duration) end
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_WarpTrail_C:OnLifeTime() end
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_WarpTrail_C:ForceFade() end
---@param EntryPoint int32
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_WarpTrail_C:ExecuteUbergraph_BP_SkillEffect_Unique_DarkMechaDragon_WarpComet_WarpTrail(EntryPoint) end


