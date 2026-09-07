---@meta

---@class ABP_AssaultRifle_NPC_GrassBoss_C : ABP_AssaultRifleBase_C
---@field SkeletalMesh USkeletalMeshComponent
---@field OnShootDelegate FBP_AssaultRifle_NPC_GrassBoss_COnShootDelegate
local ABP_AssaultRifle_NPC_GrassBoss_C = {}

---@return float
function ABP_AssaultRifle_NPC_GrassBoss_C:GetDefaultBlurAngle() end
---@return int32
function ABP_AssaultRifle_NPC_GrassBoss_C:GetNPCWeaponDamage() end
---@param NewParam UNiagaraSystem
function ABP_AssaultRifle_NPC_GrassBoss_C:GetMuzzleEffect(NewParam) end
---@return FTransform
function ABP_AssaultRifle_NPC_GrassBoss_C:GetLeftHandTransform() end
---@return boolean
function ABP_AssaultRifle_NPC_GrassBoss_C:IsUseLeftHandAttach() end
---@param BulletActor APalBullet
function ABP_AssaultRifle_NPC_GrassBoss_C:OnShoot(BulletActor) end
---@param NewParam TSubclassOf<APalBullet>
function ABP_AssaultRifle_NPC_GrassBoss_C:GetBulletClass(NewParam) end
---@param Time double
function ABP_AssaultRifle_NPC_GrassBoss_C:GetShootInterval(Time) end
---@param Rotator FRotator
function ABP_AssaultRifle_NPC_GrassBoss_C:GetMuzzleRotator(Rotator) end
---@param MuzzleLocation FVector
function ABP_AssaultRifle_NPC_GrassBoss_C:GetMuzzleLocation(MuzzleLocation) end
---@return int32
function ABP_AssaultRifle_NPC_GrassBoss_C:GetWeaponDamage() end
function ABP_AssaultRifle_NPC_GrassBoss_C:OnShootDelegate__DelegateSignature() end


