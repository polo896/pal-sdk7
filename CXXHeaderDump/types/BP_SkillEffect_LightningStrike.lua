---@meta

---@class ABP_SkillEffect_LightningStrike_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Capsule UCapsuleComponent
---@field NS_LightningStrike UNiagaraComponent
---@field StrikeDelay double
local ABP_SkillEffect_LightningStrike_C = {}

function ABP_SkillEffect_LightningStrike_C:ReceiveBeginPlay() end
function ABP_SkillEffect_LightningStrike_C:DisableCollision() end
---@param EntryPoint int32
function ABP_SkillEffect_LightningStrike_C:ExecuteUbergraph_BP_SkillEffect_LightningStrike(EntryPoint) end


