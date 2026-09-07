---@meta

---@class ABP_SkillEffect_BlastCannon_3wayEmitter_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field MaxSpawnNum int32
---@field RemainSpawnNum int32
---@field ['3-WayAngle'] double
---@field AngleArray TArray<double>
---@field BlastSpace double
---@field SpawnRate double
---@field IgnoreFloorDistance double
---@field LastPosHeights TArray<double>
---@field IgnoreWay TArray<boolean>
---@field StepUpDownRange double
local ABP_SkillEffect_BlastCannon_3wayEmitter_C = {}

function ABP_SkillEffect_BlastCannon_3wayEmitter_C:ReceiveBeginPlay() end
function ABP_SkillEffect_BlastCannon_3wayEmitter_C:SpawnIndicate() end
function ABP_SkillEffect_BlastCannon_3wayEmitter_C:PlaySound() end
---@param EntryPoint int32
function ABP_SkillEffect_BlastCannon_3wayEmitter_C:ExecuteUbergraph_BP_SkillEffect_BlastCannon_3wayEmitter(EntryPoint) end


