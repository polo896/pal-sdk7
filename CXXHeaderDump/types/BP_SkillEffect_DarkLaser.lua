---@meta

---@class ABP_SkillEffect_DarkLaser_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field Capsule UCapsuleComponent
---@field Sphere USphereComponent
---@field StartCollisionTime double
---@field EndCollisionTime double
local ABP_SkillEffect_DarkLaser_C = {}

function ABP_SkillEffect_DarkLaser_C:ReceiveBeginPlay() end
function ABP_SkillEffect_DarkLaser_C:EnableCollision() end
function ABP_SkillEffect_DarkLaser_C:EndCollision() end
---@param EntryPoint int32
function ABP_SkillEffect_DarkLaser_C:ExecuteUbergraph_BP_SkillEffect_DarkLaser(EntryPoint) end


