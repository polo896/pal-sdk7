---@meta

---@class ABP_OilRigCannon_LaserTower_C : ABP_OilRigCannonBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Mesh_AATowerBase UStaticMeshComponent
---@field NS_CommonSkill_HyperBeam UNiagaraComponent
---@field NS_CommonSkill_HyperBeam_charge UNiagaraComponent
---@field Cube UStaticMeshComponent
---@field Sphere USphereComponent
---@field Mesh_AATowerHead UStaticMeshComponent
---@field Mesh_AATowerBody UStaticMeshComponent
---@field TimerHandle_LayCast FTimerHandle
---@field Const_LaserRadius float
---@field IsDebugView boolean
---@field TempElecEffect UNiagaraComponent
---@field tempSmokeEffect UNiagaraComponent
local ABP_OilRigCannon_LaserTower_C = {}

---@param IsActive boolean
function ABP_OilRigCannon_LaserTower_C:SetActiveHeadMesh(IsActive) end
function ABP_OilRigCannon_LaserTower_C:ChangeDefaultMesh() end
ABP_OilRigCannon_LaserTower_C['Damage Ray Cast'] = function(self, ) end
---@return USceneComponent
function ABP_OilRigCannon_LaserTower_C:GetPitchMesh() end
---@return USceneComponent
function ABP_OilRigCannon_LaserTower_C:GetYawMesh() end
---@param DeltaSeconds float
function ABP_OilRigCannon_LaserTower_C:ReceiveTick(DeltaSeconds) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_OilRigCannon_LaserTower_C:BndEvt__BP_OilRigCannon_AATower_Sphere_K2Node_ComponentBoundEvent_0_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
function ABP_OilRigCannon_LaserTower_C:BndEvt__BP_OilRigCannon_AATower_Sphere_K2Node_ComponentBoundEvent_1_ComponentEndOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex) end
function ABP_OilRigCannon_LaserTower_C:PullTrigger_BP() end
function ABP_OilRigCannon_LaserTower_C:ReceiveBeginPlay() end
function ABP_OilRigCannon_LaserTower_C:OnDestroyedWeapon_ForBP() end
function ABP_OilRigCannon_LaserTower_C:ChangeDefaultVisual_BP() end
---@param EndPlayReason EEndPlayReason::Type
function ABP_OilRigCannon_LaserTower_C:ReceiveEndPlay(EndPlayReason) end
---@param EntryPoint int32
function ABP_OilRigCannon_LaserTower_C:ExecuteUbergraph_BP_OilRigCannon_LaserTower(EntryPoint) end


