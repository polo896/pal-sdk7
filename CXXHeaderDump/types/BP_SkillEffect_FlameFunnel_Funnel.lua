---@meta

---@class ABP_SkillEffect_FlameFunnel_Funnel_C : ABP_Skill_ThunderFunnel_Funnel_C
---@field UberGraphFrame FPointerToUberGraphFrame
local ABP_SkillEffect_FlameFunnel_Funnel_C = {}

---@param ShotSpan double
function ABP_SkillEffect_FlameFunnel_Funnel_C:GetShotSpan(ShotSpan) end
---@param Owner AActor
---@param SkillEffect ABP_SkillEffectBase_C
function ABP_SkillEffect_FlameFunnel_Funnel_C:SpawnSkillEffect(Owner, SkillEffect) end
function ABP_SkillEffect_FlameFunnel_Funnel_C:SetLifeTimer() end
---@param DeltaSecond double
function ABP_SkillEffect_FlameFunnel_Funnel_C:FadeOutEffect(DeltaSecond) end
function ABP_SkillEffect_FlameFunnel_Funnel_C:Terminate() end
---@param EntryPoint int32
function ABP_SkillEffect_FlameFunnel_Funnel_C:ExecuteUbergraph_BP_SkillEffect_FlameFunnel_Funnel(EntryPoint) end


