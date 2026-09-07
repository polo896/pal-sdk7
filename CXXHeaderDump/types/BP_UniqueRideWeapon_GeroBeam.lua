---@meta

---@class ABP_UniqueRideWeapon_GeroBeam_C : APalUniqueRideWeaponBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field SM_PrismTower_AT UStaticMeshComponent
---@field SM_PrismTower_B UStaticMeshComponent
---@field DefaultSceneRoot USceneComponent
---@field IsShootingProgress boolean
---@field ConstBeamMaxRange double
---@field BeamLength double
---@field HitFilter UPalHitFilter
---@field AttackCollisionActor ABP_GeroBeamAttackCollision_C
---@field IsBeamEmitting boolean
---@field Debug EDrawDebugTrace::Type
---@field Niagara_Charge UNiagaraSystem
---@field Niagara_DamageHit UNiagaraSystem
---@field Niagara_GroundHit UNiagaraSystem
---@field BeamDirection FVector
---@field ConstBeamTime double
---@field NS_Component_GroundHit UNiagaraComponent
---@field HitActorMap TMap<AActor, UNiagaraComponent>
local ABP_UniqueRideWeapon_GeroBeam_C = {}

---@param MyHitComponent UPrimitiveComponent
---@param OtherHitActor AActor
---@param OtherHitComponent UPrimitiveComponent
function ABP_UniqueRideWeapon_GeroBeam_C:OnEndHit(MyHitComponent, OtherHitActor, OtherHitComponent) end
function ABP_UniqueRideWeapon_GeroBeam_C:DeleteAllEffect() end
---@param MyHitComponent UPrimitiveComponent
---@param OtherHitActor AActor
---@param OtherHitComponent UPrimitiveComponent
---@param FoliageIndex TArray<int32>
---@param HitLocation FVector
---@param HitCount int32
function ABP_UniqueRideWeapon_GeroBeam_C:OnHit_Damage(MyHitComponent, OtherHitActor, OtherHitComponent, FoliageIndex, HitLocation, HitCount) end
---@param TargetActor AActor
---@param EffectPos FVector
function ABP_UniqueRideWeapon_GeroBeam_C:CharacterHitEffectPos(TargetActor, EffectPos) end
function ABP_UniqueRideWeapon_GeroBeam_C:ShootingExit() end
function ABP_UniqueRideWeapon_GeroBeam_C:ShootingEnter() end
---@return FRotator
function ABP_UniqueRideWeapon_GeroBeam_C:GetMuzzleRotation() end
---@return FVector
function ABP_UniqueRideWeapon_GeroBeam_C:GetMuzzleLocation() end
function ABP_UniqueRideWeapon_GeroBeam_C:BeamControl() end
---@param DeltaSeconds float
function ABP_UniqueRideWeapon_GeroBeam_C:ReceiveTick(DeltaSeconds) end
function ABP_UniqueRideWeapon_GeroBeam_C:OnPullTrigger() end
function ABP_UniqueRideWeapon_GeroBeam_C:ReceiveBeginPlay() end
---@param MyHitComponent UPrimitiveComponent
---@param OtherHitActor AActor
---@param OtherHitComponent UPrimitiveComponent
---@param FoliageIndex TArray<int32>
---@param HitLocation FVector
---@param HitCount int32
function ABP_UniqueRideWeapon_GeroBeam_C:Hit(MyHitComponent, OtherHitActor, OtherHitComponent, FoliageIndex, HitLocation, HitCount) end
---@param EndPlayReason EEndPlayReason::Type
function ABP_UniqueRideWeapon_GeroBeam_C:ReceiveEndPlay(EndPlayReason) end
function ABP_UniqueRideWeapon_GeroBeam_C:OnCancellShooting() end
---@param EntryPoint int32
function ABP_UniqueRideWeapon_GeroBeam_C:ExecuteUbergraph_BP_UniqueRideWeapon_GeroBeam(EntryPoint) end


