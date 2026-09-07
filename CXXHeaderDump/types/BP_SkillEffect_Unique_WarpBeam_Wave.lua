---@meta

---@class ABP_SkillEffect_Unique_WarpBeam_Wave_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Arrow UArrowComponent
---@field Niagara UNiagaraComponent
local ABP_SkillEffect_Unique_WarpBeam_Wave_C = {}

---@param DeltaSecond double
function ABP_SkillEffect_Unique_WarpBeam_Wave_C:FadeOutEffect(DeltaSecond) end
---@param Life double
---@param Size double
function ABP_SkillEffect_Unique_WarpBeam_Wave_C:SetLifeAndSize(Life, Size) end
function ABP_SkillEffect_Unique_WarpBeam_Wave_C:StartFade() end
---@param EntryPoint int32
function ABP_SkillEffect_Unique_WarpBeam_Wave_C:ExecuteUbergraph_BP_SkillEffect_Unique_WarpBeam_Wave(EntryPoint) end


