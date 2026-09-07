---@meta

---@class ABP_SkillEffect_AirBlade_Blade_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ProjectileMovement UProjectileMovementComponent
---@field Niagara UNiagaraComponent
---@field Box UBoxComponent
local ABP_SkillEffect_AirBlade_Blade_C = {}

function ABP_SkillEffect_AirBlade_Blade_C:ReceiveBeginPlay() end
---@param Life double
---@param NormalVelocity FVector
function ABP_SkillEffect_AirBlade_Blade_C:SetLifeAndVelocity(Life, NormalVelocity) end
function ABP_SkillEffect_AirBlade_Blade_C:End() end
---@param DeltaSecond double
function ABP_SkillEffect_AirBlade_Blade_C:FadeOutEffect(DeltaSecond) end
---@param EntryPoint int32
function ABP_SkillEffect_AirBlade_Blade_C:ExecuteUbergraph_BP_SkillEffect_AirBlade_Blade(EntryPoint) end


