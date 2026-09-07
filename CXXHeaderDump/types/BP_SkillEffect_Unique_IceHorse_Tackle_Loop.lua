---@meta

---@class ABP_SkillEffect_Unique_IceHorse_Tackle_Loop_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara_WingL UNiagaraComponent
---@field Niagara_WingR UNiagaraComponent
---@field NiagaraEffect UNiagaraComponent
local ABP_SkillEffect_Unique_IceHorse_Tackle_Loop_C = {}

---@param DeltaSecond double
function ABP_SkillEffect_Unique_IceHorse_Tackle_Loop_C:FadeOutEffect(DeltaSecond) end
function ABP_SkillEffect_Unique_IceHorse_Tackle_Loop_C:OnEndAction() end
---@param OwnerCharacter APalCharacter
function ABP_SkillEffect_Unique_IceHorse_Tackle_Loop_C:AttachWing(OwnerCharacter) end
function ABP_SkillEffect_Unique_IceHorse_Tackle_Loop_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_SkillEffect_Unique_IceHorse_Tackle_Loop_C:ExecuteUbergraph_BP_SkillEffect_Unique_IceHorse_Tackle_Loop(EntryPoint) end


