---@meta

---@class UBP_ActionAquaJet_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field IsShooted boolean
local UBP_ActionAquaJet_C = {}

---@param Effect APalSkillEffectBase
function UBP_ActionAquaJet_C:BulletHasShooted(Effect) end
---@param Effect APalSkillEffectBase
function UBP_ActionAquaJet_C:SetHomingTarget(Effect) end
function UBP_ActionAquaJet_C:OnShoot() end
function UBP_ActionAquaJet_C:OnStartProcessAnimation() end
---@param Effect APalSkillEffectBase
function UBP_ActionAquaJet_C:OnSpawnEffect(Effect) end
---@param EntryPoint int32
function UBP_ActionAquaJet_C:ExecuteUbergraph_BP_ActionAquaJet(EntryPoint) end


