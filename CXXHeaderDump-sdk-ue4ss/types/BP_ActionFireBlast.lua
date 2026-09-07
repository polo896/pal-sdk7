---@meta

---@class UBP_ActionFireBlast_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field IsShooted boolean
local UBP_ActionFireBlast_C = {}

---@param Effect APalSkillEffectBase
function UBP_ActionFireBlast_C:BulletHasShooted(Effect) end
---@return boolean
function UBP_ActionFireBlast_C:CanNextActionCancel() end
function UBP_ActionFireBlast_C:OnBeginAction() end
---@param EntryPoint int32
function UBP_ActionFireBlast_C:ExecuteUbergraph_BP_ActionFireBlast(EntryPoint) end


