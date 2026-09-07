---@meta

---@class UBP_CoopSkill_StatusUp_GrassMinotaur_C : UPalCoopSkillModuleAssignPassiveSkill
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Effect UNiagaraComponent
local UBP_CoopSkill_StatusUp_GrassMinotaur_C = {}

function UBP_CoopSkill_StatusUp_GrassMinotaur_C:OnSkillOverheat() end
function UBP_CoopSkill_StatusUp_GrassMinotaur_C:OnStartSkill() end
---@param DeltaTime float
function UBP_CoopSkill_StatusUp_GrassMinotaur_C:OnTick(DeltaTime) end
---@param EntryPoint int32
function UBP_CoopSkill_StatusUp_GrassMinotaur_C:ExecuteUbergraph_BP_CoopSkill_StatusUp_GrassMinotaur(EntryPoint) end


