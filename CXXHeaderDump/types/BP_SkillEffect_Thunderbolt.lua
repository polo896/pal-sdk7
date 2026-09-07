---@meta

---@class ABP_SkillEffect_Thunderbolt_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field Capsule UCapsuleComponent
---@field Sphere USphereComponent
---@field StartCollisionTime double
---@field EndCollisionTime double
---@field BeamLength double
---@field BeamRadius double
local ABP_SkillEffect_Thunderbolt_C = {}

function ABP_SkillEffect_Thunderbolt_C:ReceiveBeginPlay() end
function ABP_SkillEffect_Thunderbolt_C:EnableCollision() end
function ABP_SkillEffect_Thunderbolt_C:EndCollision() end
---@param EntryPoint int32
function ABP_SkillEffect_Thunderbolt_C:ExecuteUbergraph_BP_SkillEffect_Thunderbolt(EntryPoint) end


