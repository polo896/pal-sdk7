---@meta

---@class UBP_CoopSkill_StatusUp_Anubis_C : UPalCoopSkillModuleAssignPassiveSkill
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Effect UNiagaraComponent
local UBP_CoopSkill_StatusUp_Anubis_C = {}

function UBP_CoopSkill_StatusUp_Anubis_C:OnSkillOverheat() end
function UBP_CoopSkill_StatusUp_Anubis_C:OnStartSkill() end
---@param DeltaTime float
function UBP_CoopSkill_StatusUp_Anubis_C:OnTick(DeltaTime) end
---@param EntryPoint int32
function UBP_CoopSkill_StatusUp_Anubis_C:ExecuteUbergraph_BP_CoopSkill_StatusUp_Anubis(EntryPoint) end


