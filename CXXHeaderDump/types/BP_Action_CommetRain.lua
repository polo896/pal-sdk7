---@meta

---@class UBP_Action_CommetRain_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Interval float
---@field CommetCount int32
---@field MaxCommetCount int32
---@field OffsetDistance float
---@field Timer FTimerHandle
---@field TargetLocation FVector
local UBP_Action_CommetRain_C = {}

function UBP_Action_CommetRain_C:OnStartProcessAnimation() end
function UBP_Action_CommetRain_C:CreateCommet() end
function UBP_Action_CommetRain_C:OnEndAction() end
---@param Effect APalSkillEffectBase
function UBP_Action_CommetRain_C:OnSpawnEffect(Effect) end
---@param EntryPoint int32
function UBP_Action_CommetRain_C:ExecuteUbergraph_BP_Action_CommetRain(EntryPoint) end


