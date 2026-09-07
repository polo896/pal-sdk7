---@meta

---@class ABP_SkillEfffect_SandTwister_Tornado2_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Capsule UCapsuleComponent
---@field Niagara UNiagaraComponent
---@field Life double
local ABP_SkillEfffect_SandTwister_Tornado2_C = {}

function ABP_SkillEfffect_SandTwister_Tornado2_C:ReceiveBeginPlay() end
---@param DeltaSecond double
function ABP_SkillEfffect_SandTwister_Tornado2_C:FadeOutEffect(DeltaSecond) end
function ABP_SkillEfffect_SandTwister_Tornado2_C:OnLifeEnd() end
---@param EntryPoint int32
function ABP_SkillEfffect_SandTwister_Tornado2_C:ExecuteUbergraph_BP_SkillEfffect_SandTwister_Tornado2(EntryPoint) end


