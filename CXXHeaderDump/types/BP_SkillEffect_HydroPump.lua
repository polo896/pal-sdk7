---@meta

---@class ABP_SkillEffect_HydroPump_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field Capsule UCapsuleComponent
---@field Sphere USphereComponent
---@field StartCollisionTime double
---@field EndCollisionTime double
---@field BeamLength double
---@field BeamRadius double
local ABP_SkillEffect_HydroPump_C = {}

function ABP_SkillEffect_HydroPump_C:ReceiveBeginPlay() end
function ABP_SkillEffect_HydroPump_C:EnableCollision() end
function ABP_SkillEffect_HydroPump_C:EndCollision() end
---@param PSystem UNiagaraComponent
function ABP_SkillEffect_HydroPump_C:BndEvt__BP_SkillEffect_HydroPump_Niagara_K2Node_ComponentBoundEvent_0_OnNiagaraSystemFinished__DelegateSignature(PSystem) end
---@param EntryPoint int32
function ABP_SkillEffect_HydroPump_C:ExecuteUbergraph_BP_SkillEffect_HydroPump(EntryPoint) end


