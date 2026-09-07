---@meta

---@class ABP_ShotgunBullet_C : ABP_AttackBulletBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field StaticMesh UStaticMeshComponent
---@field HitHolder UBP_HitTargetHolder_C
---@field HitEffect UNiagaraSystem
local ABP_ShotgunBullet_C = {}

function ABP_ShotgunBullet_C:ReceiveBeginPlay() end
---@param HitComp UPrimitiveComponent
---@param OtherCharacter AActor
---@param OtherComp UPrimitiveComponent
---@param Hit FHitResult
function ABP_ShotgunBullet_C:OnDestroy(HitComp, OtherCharacter, OtherComp, Hit) end
---@param EntryPoint int32
function ABP_ShotgunBullet_C:ExecuteUbergraph_BP_ShotgunBullet(EntryPoint) end


