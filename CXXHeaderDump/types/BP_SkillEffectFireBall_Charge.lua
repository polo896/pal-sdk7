---@meta

---@class ABP_SkillEffectFireBall_Charge_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Charge UNiagaraComponent
---@field ReadyTime double
---@field TargetActor AActor
local ABP_SkillEffectFireBall_Charge_C = {}

function ABP_SkillEffectFireBall_Charge_C:ReceiveBeginPlay() end
---@param OtherActor AActor
function ABP_SkillEffectFireBall_Charge_C:ReceiveActorBeginOverlap(OtherActor) end
---@param EntryPoint int32
function ABP_SkillEffectFireBall_Charge_C:ExecuteUbergraph_BP_SkillEffectFireBall_Charge(EntryPoint) end


