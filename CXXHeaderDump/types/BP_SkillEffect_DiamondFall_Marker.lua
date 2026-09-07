---@meta

---@class ABP_SkillEffect_DiamondFall_Marker_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field HalfMaxRange double
---@field AmbienceFallCount int32
---@field PredictFallCount int32
---@field DirectFallCount int32
---@field FallInterval double
---@field FallTimer FTimerHandle
---@field CurrentCeiling int32
---@field CeilingCount int32
local ABP_SkillEffect_DiamondFall_Marker_C = {}

---@param NoAmbience boolean
---@param Type int32
function ABP_SkillEffect_DiamondFall_Marker_C:GetRandomFallType(NoAmbience, Type) end
function ABP_SkillEffect_DiamondFall_Marker_C:SpawnDiamond() end
function ABP_SkillEffect_DiamondFall_Marker_C:OnInitialize() end
---@param EntryPoint int32
function ABP_SkillEffect_DiamondFall_Marker_C:ExecuteUbergraph_BP_SkillEffect_DiamondFall_Marker(EntryPoint) end


