---@meta

---@class ABP_SkillEffect_Unique_MoonQueen_MoonBlade_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field CapsuleCollision UCapsuleComponent
---@field NS_CommonSkill_IceBlade UNiagaraComponent
---@field MoonBladeView USceneComponent
---@field MoonBlade USceneComponent
---@field ProjectileMovement UProjectileMovementComponent
---@field Speed double
---@field TimeUntilFade double
---@field HomingZIgnoreDistance double
---@field TargetActor AActor
---@field EnableZDirectionThresholdUpper double
---@field EnableZDirectionThresholdLower double
local ABP_SkillEffect_Unique_MoonQueen_MoonBlade_C = {}

function ABP_SkillEffect_Unique_MoonQueen_MoonBlade_C:ReceiveBeginPlay() end
function ABP_SkillEffect_Unique_MoonQueen_MoonBlade_C:OnLifeTime() end
---@param DeltaSecond double
function ABP_SkillEffect_Unique_MoonQueen_MoonBlade_C:FadeOutEffect(DeltaSecond) end
function ABP_SkillEffect_Unique_MoonQueen_MoonBlade_C:Init() end
---@param EntryPoint int32
function ABP_SkillEffect_Unique_MoonQueen_MoonBlade_C:ExecuteUbergraph_BP_SkillEffect_Unique_MoonQueen_MoonBlade(EntryPoint) end


