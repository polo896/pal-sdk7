---@meta

---@class ABP_SkillEffect_WindBurst_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Sphere USphereComponent
---@field Niagara UNiagaraComponent
local ABP_SkillEffect_WindBurst_C = {}

function ABP_SkillEffect_WindBurst_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_SkillEffect_WindBurst_C:ExecuteUbergraph_BP_SkillEffect_WindBurst(EntryPoint) end


