---@meta

---@class ABP_SkillEffect_GrassTornado_C : ABP_SkillEffect_DoubleTornadoBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
local ABP_SkillEffect_GrassTornado_C = {}

function ABP_SkillEffect_GrassTornado_C:OnInitialize() end
---@param SkillEffect APalSkillEffectBase
function ABP_SkillEffect_GrassTornado_C:OnTornadoReady(SkillEffect) end
---@param EntryPoint int32
function ABP_SkillEffect_GrassTornado_C:ExecuteUbergraph_BP_SkillEffect_GrassTornado(EntryPoint) end


