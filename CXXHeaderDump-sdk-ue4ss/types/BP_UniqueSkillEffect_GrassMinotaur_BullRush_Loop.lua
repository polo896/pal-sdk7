---@meta

---@class ABP_UniqueSkillEffect_GrassMinotaur_BullRush_Loop_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field Sphere USphereComponent
---@field CameraShakeTimer FTimerHandle
local ABP_UniqueSkillEffect_GrassMinotaur_BullRush_Loop_C = {}

function ABP_UniqueSkillEffect_GrassMinotaur_BullRush_Loop_C:ReceiveBeginPlay() end
---@param DeltaSecond double
function ABP_UniqueSkillEffect_GrassMinotaur_BullRush_Loop_C:FadeOutEffect(DeltaSecond) end
---@param DeltaTime double
function ABP_UniqueSkillEffect_GrassMinotaur_BullRush_Loop_C:ProcessFade(DeltaTime) end
function ABP_UniqueSkillEffect_GrassMinotaur_BullRush_Loop_C:CameraShake() end
---@param EntryPoint int32
function ABP_UniqueSkillEffect_GrassMinotaur_BullRush_Loop_C:ExecuteUbergraph_BP_UniqueSkillEffect_GrassMinotaur_BullRush_Loop(EntryPoint) end


