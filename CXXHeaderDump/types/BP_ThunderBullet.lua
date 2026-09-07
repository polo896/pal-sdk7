---@meta

---@class ABP_ThunderBullet_C : ABP_AttackBulletBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field StaticMesh UStaticMeshComponent
local ABP_ThunderBullet_C = {}

---@param AttackType EPalAttackType
function ABP_ThunderBullet_C:GetBulletAttackType(AttackType) end
---@param NewParam EPalElementType
function ABP_ThunderBullet_C:GetBulletElementType(NewParam) end
---@param HitComp UPrimitiveComponent
---@param OtherCharacter AActor
---@param OtherComp UPrimitiveComponent
---@param Hit FHitResult
function ABP_ThunderBullet_C:OnDestroy(HitComp, OtherCharacter, OtherComp, Hit) end
---@param EntryPoint int32
function ABP_ThunderBullet_C:ExecuteUbergraph_BP_ThunderBullet(EntryPoint) end


