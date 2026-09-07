---@meta

---@class ABP_SkillEffect_RootLance_Lance_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Capsule UCapsuleComponent
---@field Niagara UNiagaraComponent
local ABP_SkillEffect_RootLance_Lance_C = {}

function ABP_SkillEffect_RootLance_Lance_C:ReceiveBeginPlay() end
function ABP_SkillEffect_RootLance_Lance_C:EndAttack() end
---@param Scale double
function ABP_SkillEffect_RootLance_Lance_C:SetScale(Scale) end
---@param EntryPoint int32
function ABP_SkillEffect_RootLance_Lance_C:ExecuteUbergraph_BP_SkillEffect_RootLance_Lance(EntryPoint) end


