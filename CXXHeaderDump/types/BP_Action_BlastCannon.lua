---@meta

---@class UBP_Action_BlastCannon_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field bShowPredictLocation boolean
---@field PredictDistanceRate double
---@field IgnoreHeightDistance double
local UBP_Action_BlastCannon_C = {}

---@param Location FVector
function UBP_Action_BlastCannon_C:GetPredictedTargetLocation(Location) end
---@param Effect APalSkillEffectBase
function UBP_Action_BlastCannon_C:OnSpawnEffect(Effect) end
function UBP_Action_BlastCannon_C:OnBeginAction() end
---@param DeltaTime float
function UBP_Action_BlastCannon_C:TickAction(DeltaTime) end
---@param EntryPoint int32
function UBP_Action_BlastCannon_C:ExecuteUbergraph_BP_Action_BlastCannon(EntryPoint) end


