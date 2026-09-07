---@meta

---@class ABP_SkillEffect_ThunderStorm_Storm_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Capsule UCapsuleComponent
---@field Niagara UNiagaraComponent
---@field StormDuration float
---@field HomingStrength double
local ABP_SkillEffect_ThunderStorm_Storm_C = {}

function ABP_SkillEffect_ThunderStorm_Storm_C:ReceiveBeginPlay() end
---@param DeltaSecond double
function ABP_SkillEffect_ThunderStorm_Storm_C:FadeOutEffect(DeltaSecond) end
function ABP_SkillEffect_ThunderStorm_Storm_C:EndStorm() end
---@param DeltaSeconds float
function ABP_SkillEffect_ThunderStorm_Storm_C:ReceiveTick(DeltaSeconds) end
---@param PSystem UNiagaraComponent
function ABP_SkillEffect_ThunderStorm_Storm_C:BndEvt__BP_SkillEffect_ThunderStorm_Storm_Niagara_K2Node_ComponentBoundEvent_0_OnNiagaraSystemFinished__DelegateSignature(PSystem) end
---@param EntryPoint int32
function ABP_SkillEffect_ThunderStorm_Storm_C:ExecuteUbergraph_BP_SkillEffect_ThunderStorm_Storm(EntryPoint) end


