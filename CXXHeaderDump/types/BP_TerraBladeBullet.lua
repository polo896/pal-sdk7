---@meta

---@class ABP_TerraBladeBullet_C : ABP_AttackBulletBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field Box UBoxComponent
---@field HittedActors TArray<AActor>
---@field IsFading boolean
---@field Life float
---@field destroyTime float
local ABP_TerraBladeBullet_C = {}

---@param HitComp UPrimitiveComponent
---@param OtherCharacter AActor
---@param OtherComp UPrimitiveComponent
---@param Hit FHitResult
---@return boolean
function ABP_TerraBladeBullet_C:IsDestroy(HitComp, OtherCharacter, OtherComp, Hit) end
function ABP_TerraBladeBullet_C:ReceiveBeginPlay() end
---@param RotRight boolean
function ABP_TerraBladeBullet_C:SetLRRot(RotRight) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_TerraBladeBullet_C:BndEvt__BP_TerraBladeBullet_Box_K2Node_ComponentBoundEvent_0_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
function ABP_TerraBladeBullet_C:BeginFade() end
---@param EntryPoint int32
function ABP_TerraBladeBullet_C:ExecuteUbergraph_BP_TerraBladeBullet(EntryPoint) end


