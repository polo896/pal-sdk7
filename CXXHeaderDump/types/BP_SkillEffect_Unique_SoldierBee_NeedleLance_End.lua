---@meta

---@class ABP_SkillEffect_Unique_SoldierBee_NeedleLance_End_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field NS_Environment_Butterfly UNiagaraComponent
---@field TimeUntilFade double
local ABP_SkillEffect_Unique_SoldierBee_NeedleLance_End_C = {}

function ABP_SkillEffect_Unique_SoldierBee_NeedleLance_End_C:ReceiveBeginPlay() end
function ABP_SkillEffect_Unique_SoldierBee_NeedleLance_End_C:OnLifeTime() end
---@param DeltaSecond double
function ABP_SkillEffect_Unique_SoldierBee_NeedleLance_End_C:FadeOutEffect(DeltaSecond) end
---@param EntryPoint int32
function ABP_SkillEffect_Unique_SoldierBee_NeedleLance_End_C:ExecuteUbergraph_BP_SkillEffect_Unique_SoldierBee_NeedleLance_End(EntryPoint) end


