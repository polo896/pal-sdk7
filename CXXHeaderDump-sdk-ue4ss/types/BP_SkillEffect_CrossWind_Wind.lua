---@meta

---@class ABP_SkillEffect_CrossWind_Wind_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ProjectileMovement UProjectileMovementComponent
---@field Box UBoxComponent
---@field Niagara UNiagaraComponent
---@field Life double
---@field LaunchDelay double
local ABP_SkillEffect_CrossWind_Wind_C = {}

function ABP_SkillEffect_CrossWind_Wind_C:ReceiveBeginPlay() end
function ABP_SkillEffect_CrossWind_Wind_C:Launch() end
function ABP_SkillEffect_CrossWind_Wind_C:SetFade() end
---@param DeltaSecond double
function ABP_SkillEffect_CrossWind_Wind_C:FadeOutEffect(DeltaSecond) end
---@param EntryPoint int32
function ABP_SkillEffect_CrossWind_Wind_C:ExecuteUbergraph_BP_SkillEffect_CrossWind_Wind(EntryPoint) end


