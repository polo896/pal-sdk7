---@meta

---@class ABP_SkillEffect_BubbleShot_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Collision USphereComponent
---@field BubbleShot UNiagaraComponent
---@field SpawnPos USphereComponent
---@field ProjectileMovement UProjectileMovementComponent
---@field Shot_volume int32
---@field Shot_extent double
---@field ShotSpan double
---@field ['Temp time'] double
---@field Shot_Count int32
local ABP_SkillEffect_BubbleShot_C = {}

---@param MyComp UPrimitiveComponent
---@param Other AActor
---@param OtherComp UPrimitiveComponent
---@param bSelfMoved boolean
---@param HitLocation FVector
---@param HitNormal FVector
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_BubbleShot_C:ReceiveHit(MyComp, Other, OtherComp, bSelfMoved, HitLocation, HitNormal, NormalImpulse, Hit) end
function ABP_SkillEffect_BubbleShot_C:Explosion() end
function ABP_SkillEffect_BubbleShot_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function ABP_SkillEffect_BubbleShot_C:ReceiveTick(DeltaSeconds) end
---@param EntryPoint int32
function ABP_SkillEffect_BubbleShot_C:ExecuteUbergraph_BP_SkillEffect_BubbleShot(EntryPoint) end


