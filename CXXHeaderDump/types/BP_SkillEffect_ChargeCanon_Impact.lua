---@meta

---@class ABP_SkillEffect_ChargeCanon_Impact_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ImpactEffect UNiagaraComponent
---@field ImpactDamage USphereComponent
---@field MaxEffectDuration float
---@field CollisionEnableTime float
---@field ImpactRadius double
local ABP_SkillEffect_ChargeCanon_Impact_C = {}

function ABP_SkillEffect_ChargeCanon_Impact_C:UserConstructionScript() end
function ABP_SkillEffect_ChargeCanon_Impact_C:ReceiveBeginPlay() end
function ABP_SkillEffect_ChargeCanon_Impact_C:EndEffect() end
---@param DeltaSecond double
function ABP_SkillEffect_ChargeCanon_Impact_C:FadeOutEffect(DeltaSecond) end
function ABP_SkillEffect_ChargeCanon_Impact_C:CollisionDisable() end
---@param EntryPoint int32
function ABP_SkillEffect_ChargeCanon_Impact_C:ExecuteUbergraph_BP_SkillEffect_ChargeCanon_Impact(EntryPoint) end


