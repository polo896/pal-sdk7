---@meta

---@class ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field Root USceneComponent
---@field TimeUntilFade double
---@field RootAction UBP_Action_Unique_DarkMechaDragon_WarpComet_C
---@field FixedRotation FRotator
local ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail_C = {}

---@param Scale double
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail_C:SetScale(Scale) end
---@param DeltaSecond double
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail_C:FadeOutEffect(DeltaSecond) end
---@param Duration double
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail_C:SetLifeTimer(Duration) end
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail_C:OnLifeTime() end
---@param DeltaSeconds float
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail_C:ReceiveTick(DeltaSeconds) end
---@param action UBP_Action_Unique_DarkMechaDragon_WarpComet_C
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail_C:SetRootAction(action) end
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail_C:SetFixedRotation() end
---@param NewRotation FRotator
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail_C:SetRotation(NewRotation) end
---@param EntryPoint int32
function ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail_C:ExecuteUbergraph_BP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail(EntryPoint) end


