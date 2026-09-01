---@meta

---@class ABP_SkillEffect_Tremor_Explode_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Sphere USphereComponent
---@field Niagara UNiagaraComponent
local ABP_SkillEffect_Tremor_Explode_C = {}

function ABP_SkillEffect_Tremor_Explode_C:OnBreakAction() end
function ABP_SkillEffect_Tremor_Explode_C:ReceiveBeginPlay() end
---@param NewScale double
function ABP_SkillEffect_Tremor_Explode_C:SetScale(NewScale) end
---@param EntryPoint int32
function ABP_SkillEffect_Tremor_Explode_C:ExecuteUbergraph_BP_SkillEffect_Tremor_Explode(EntryPoint) end


