---@meta

---@class ABP_SkillEffect_AirBlade_Charge_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
local ABP_SkillEffect_AirBlade_Charge_C = {}

function ABP_SkillEffect_AirBlade_Charge_C:ReceiveBeginPlay() end
---@param DeltaSecond double
function ABP_SkillEffect_AirBlade_Charge_C:FadeOutEffect(DeltaSecond) end
---@param EntryPoint int32
function ABP_SkillEffect_AirBlade_Charge_C:ExecuteUbergraph_BP_SkillEffect_AirBlade_Charge(EntryPoint) end


