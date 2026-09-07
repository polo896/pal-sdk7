---@meta

---@class ABP_SkillEffect_DragonWave_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Sphere USphereComponent
---@field Wave UNiagaraComponent
local ABP_SkillEffect_DragonWave_C = {}

---@param Data TArray<FBasicParticleData>
---@param NiagaraSystem UNiagaraSystem
---@param SimulationPositionOffset FVector
function ABP_SkillEffect_DragonWave_C:ReceiveParticleData(Data, NiagaraSystem, SimulationPositionOffset) end
function ABP_SkillEffect_DragonWave_C:ReceiveBeginPlay() end
function ABP_SkillEffect_DragonWave_C:DisableCollision() end
---@param EntryPoint int32
function ABP_SkillEffect_DragonWave_C:ExecuteUbergraph_BP_SkillEffect_DragonWave(EntryPoint) end


