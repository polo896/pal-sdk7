---@meta

---@class ABP_SkillEffect_HyperBeam_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field Capsule UCapsuleComponent
---@field Sphere USphereComponent
---@field StartCollisionTime double
---@field EndCollisionTime double
local ABP_SkillEffect_HyperBeam_C = {}

function ABP_SkillEffect_HyperBeam_C:ReceiveBeginPlay() end
function ABP_SkillEffect_HyperBeam_C:EnableCollision() end
function ABP_SkillEffect_HyperBeam_C:EndCollision() end
---@param EntryPoint int32
function ABP_SkillEffect_HyperBeam_C:ExecuteUbergraph_BP_SkillEffect_HyperBeam(EntryPoint) end


