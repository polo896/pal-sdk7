---@meta

---@class ABP_SkillEffect_ElecWave_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Sphere USphereComponent
---@field NS_DarkWave UNiagaraComponent
local ABP_SkillEffect_ElecWave_C = {}

---@param Data TArray<FBasicParticleData>
---@param NiagaraSystem UNiagaraSystem
---@param SimulationPositionOffset FVector
function ABP_SkillEffect_ElecWave_C:ReceiveParticleData(Data, NiagaraSystem, SimulationPositionOffset) end
function ABP_SkillEffect_ElecWave_C:ReceiveBeginPlay() end
function ABP_SkillEffect_ElecWave_C:DisableCollision() end
---@param EntryPoint int32
function ABP_SkillEffect_ElecWave_C:ExecuteUbergraph_BP_SkillEffect_ElecWave(EntryPoint) end


