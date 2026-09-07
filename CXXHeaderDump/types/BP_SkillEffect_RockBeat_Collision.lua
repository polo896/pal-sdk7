---@meta

---@class ABP_SkillEffect_RockBeat_Collision_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Sphere USphereComponent
---@field CurveFloat UCurveFloat
---@field Timer double
---@field StartLocation FVector
local ABP_SkillEffect_RockBeat_Collision_C = {}

function ABP_SkillEffect_RockBeat_Collision_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_SkillEffect_RockBeat_Collision_C:ExecuteUbergraph_BP_SkillEffect_RockBeat_Collision(EntryPoint) end


