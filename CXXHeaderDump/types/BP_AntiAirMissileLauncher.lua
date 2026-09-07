---@meta

---@class ABP_AntiAirMissileLauncher_C : APalAntiAirMissileLauncher
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_CannonDamageReactionComponent UBP_CannonDamageReactionComponent_C
---@field TowerMesh UStaticMeshComponent
---@field BP_InteractableSphere UPalInteractableSphereComponentNative
---@field Sphere USphereComponent
---@field PitchMesh UStaticMeshComponent
---@field YawMesh UStaticMeshComponent
---@field BaseMesh UStaticMeshComponent
---@field DefaultSceneRoot USceneComponent
---@field WeaponDamage int32
---@field TimerHandle FTimerHandle
---@field Const_OneBulletShootInterval float
---@field IsRightMuzzle boolean
---@field Const_OneCycleShootNum int32
---@field CurrentShootCount int32
---@field ActionType EPalActionType
---@field DebugTimerHandle FTimerHandle
local ABP_AntiAirMissileLauncher_C = {}

---@param IsActive boolean
function ABP_AntiAirMissileLauncher_C:SetActiveGunMesh(IsActive) end
---@param Other AActor
---@param IndicatorType EPalInteractiveObjectIndicatorType
ABP_AntiAirMissileLauncher_C['Stop Animation'] = function(self, Other, IndicatorType) end
---@param Other AActor
---@param IndicatorType EPalInteractiveObjectIndicatorType
ABP_AntiAirMissileLauncher_C['Start Animation'] = function(self, Other, IndicatorType) end
---@param Other AActor
---@param IndicatorType EPalInteractiveObjectIndicatorType
ABP_AntiAirMissileLauncher_C['Interact Completed'] = function(self, Other, IndicatorType) end
---@return EPalInteractiveObjectIndicatorType
function ABP_AntiAirMissileLauncher_C:GetIndicatorType() end
---@return USceneComponent
function ABP_AntiAirMissileLauncher_C:GetYawMesh() end
---@param MuzzleTF FTransform
function ABP_AntiAirMissileLauncher_C:GetMuzzleTransform(MuzzleTF) end
function ABP_AntiAirMissileLauncher_C:ShootBullet() end
---@return USceneComponent
function ABP_AntiAirMissileLauncher_C:GetPitchMesh() end
function ABP_AntiAirMissileLauncher_C:PullTrigger_BP() end
function ABP_AntiAirMissileLauncher_C:ReleaseTrigger_BP() end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_AntiAirMissileLauncher_C:BndEvt__BP_AntiAirMissileLauncher_Sphere_K2Node_ComponentBoundEvent_0_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
function ABP_AntiAirMissileLauncher_C:BndEvt__BP_AntiAirMissileLauncher_Sphere_K2Node_ComponentBoundEvent_1_ComponentEndOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex) end
function ABP_AntiAirMissileLauncher_C:ReceiveBeginPlay() end
function ABP_AntiAirMissileLauncher_C:OnDestroyWeapon_BP() end
---@param EndPlayReason EEndPlayReason::Type
function ABP_AntiAirMissileLauncher_C:ReceiveEndPlay(EndPlayReason) end
function ABP_AntiAirMissileLauncher_C:DebugPrint() end
---@param EntryPoint int32
function ABP_AntiAirMissileLauncher_C:ExecuteUbergraph_BP_AntiAirMissileLauncher(EntryPoint) end


