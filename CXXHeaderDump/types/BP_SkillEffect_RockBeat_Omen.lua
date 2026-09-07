---@meta

---@class ABP_SkillEffect_RockBeat_Omen_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field DelaySpawnRock double
---@field RockSpawnOffsetLocationZ double
---@field CameraShakeRadius double
local ABP_SkillEffect_RockBeat_Omen_C = {}

---@param BaesLocation FVector
---@param Location FVector
function ABP_SkillEffect_RockBeat_Omen_C:CalcLocationOnFloor(BaesLocation, Location) end
function ABP_SkillEffect_RockBeat_Omen_C:SpawnRock() end
function ABP_SkillEffect_RockBeat_Omen_C:ReceiveBeginPlay() end
function ABP_SkillEffect_RockBeat_Omen_C:CustomEvent() end
---@param EntryPoint int32
function ABP_SkillEffect_RockBeat_Omen_C:ExecuteUbergraph_BP_SkillEffect_RockBeat_Omen(EntryPoint) end


