---@meta

---@class ABP_SkillEffect_RootLance_Marker_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field SecondAttackOffsetTime float
---@field OffsetDistance float
---@field LanceCount int32
local ABP_SkillEffect_RootLance_Marker_C = {}

function ABP_SkillEffect_RootLance_Marker_C:ReceiveBeginPlay() end
function ABP_SkillEffect_RootLance_Marker_C:SpawnFirstLance() end
function ABP_SkillEffect_RootLance_Marker_C:SecondAttack() end
---@param EntryPoint int32
function ABP_SkillEffect_RootLance_Marker_C:ExecuteUbergraph_BP_SkillEffect_RootLance_Marker(EntryPoint) end


