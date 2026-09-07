---@meta

---@class ABP_SkillEffect_PoseidonOrca_ShortDash_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Sphere USphereComponent
---@field NiagaraEffect UNiagaraComponent
local ABP_SkillEffect_PoseidonOrca_ShortDash_C = {}

---@param DeltaSecond double
function ABP_SkillEffect_PoseidonOrca_ShortDash_C:FadeOutEffect(DeltaSecond) end
function ABP_SkillEffect_PoseidonOrca_ShortDash_C:OnEndAction() end
function ABP_SkillEffect_PoseidonOrca_ShortDash_C:ReceiveBeginPlay() end
---@param Defencer AActor
---@param DamageInfo FPalDamageInfo
---@param HitCount int32
---@param AttackerComponent UPrimitiveComponent
function ABP_SkillEffect_PoseidonOrca_ShortDash_C:BndEvt__BP_SkillEffectShadowBall_AttackFilter_K2Node_ComponentBoundEvent_1_OnAttackDelegate__DelegateSignature(Defencer, DamageInfo, HitCount, AttackerComponent) end
---@param EntryPoint int32
function ABP_SkillEffect_PoseidonOrca_ShortDash_C:ExecuteUbergraph_BP_SkillEffect_PoseidonOrca_ShortDash(EntryPoint) end


