---@meta

---@class UBP_Action_BubbleShot_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
local UBP_Action_BubbleShot_C = {}

function UBP_Action_BubbleShot_C:OnBeginAction() end
---@param DeltaTime float
function UBP_Action_BubbleShot_C:TickAction(DeltaTime) end
---@param Effect APalSkillEffectBase
function UBP_Action_BubbleShot_C:OnSpawnEffect(Effect) end
---@param EntryPoint int32
function UBP_Action_BubbleShot_C:ExecuteUbergraph_BP_Action_BubbleShot(EntryPoint) end


