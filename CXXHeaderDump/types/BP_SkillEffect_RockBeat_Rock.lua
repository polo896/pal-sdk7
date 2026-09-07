---@meta

---@class ABP_SkillEffect_RockBeat_Rock_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field UpTime double
---@field DownTime double
---@field CurveFloatUp UCurveFloat
---@field CurveFloatDown UCurveFloat
---@field Timer double
---@field DistanceZ double
---@field CameraShakeRadius double
---@field StartLocation FVector
---@field UpCollision ABP_SkillEffectBase_C
---@field DownCollision ABP_SkillEffectBase_C
local ABP_SkillEffect_RockBeat_Rock_C = {}

---@param DeltaSeconds float
function ABP_SkillEffect_RockBeat_Rock_C:ReceiveTick(DeltaSeconds) end
function ABP_SkillEffect_RockBeat_Rock_C:OnSpawned() end
function ABP_SkillEffect_RockBeat_Rock_C:ReceiveBeginPlay() end
function ABP_SkillEffect_RockBeat_Rock_C:SetFade() end
---@param DeltaSecond double
function ABP_SkillEffect_RockBeat_Rock_C:FadeOutEffect(DeltaSecond) end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_RockBeat_Rock_C:BndEvt__BP_SkillEffect_RockBeat_Rock_MovementSphereRoot_K2Node_ComponentBoundEvent_2_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param EntryPoint int32
function ABP_SkillEffect_RockBeat_Rock_C:ExecuteUbergraph_BP_SkillEffect_RockBeat_Rock(EntryPoint) end


