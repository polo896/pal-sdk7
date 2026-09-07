---@meta

---@class ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Purge_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Sphere USphereComponent
---@field Niagara UNiagaraComponent
---@field ExtraTimer FTimerHandle
local ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Purge_C = {}

function ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Purge_C:CrateFlash() end
function ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Purge_C:ReceiveBeginPlay() end
function ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Purge_C:EndPurge() end
function ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Purge_C:CrateExtraEffect() end
---@param EntryPoint int32
function ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Purge_C:ExecuteUbergraph_BP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Purge(EntryPoint) end


