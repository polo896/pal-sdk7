---@meta

---@class ABP_GatlingGun_C : ABP_AssaultRifleBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field SkeletalMesh USkeletalMeshComponent
local ABP_GatlingGun_C = {}

---@param IsPlaying boolean
function ABP_GatlingGun_C:BP_GatlingGun_AutoGenFunc(IsPlaying) end
---@param isUse boolean
ABP_GatlingGun_C['Is UseEjectionPort'] = function(self, isUse) end
---@param AmmoClass TSubclassOf<AActor>
function ABP_GatlingGun_C:GetAmmoClass(AmmoClass) end
---@param Transform FTransform
function ABP_GatlingGun_C:GeyEjectionPortTransform(Transform) end
function ABP_GatlingGun_C:PlayReloadAnimation() end
function ABP_GatlingGun_C:StopFireLoopSound() end
function ABP_GatlingGun_C:PlayFireLoopSound() end
---@param targetPosition FVector
function ABP_GatlingGun_C:GetTargetPosition(targetPosition) end
---@return boolean
function ABP_GatlingGun_C:IsUseLeftHandAttach() end
---@return FTransform
function ABP_GatlingGun_C:GetLeftHandTransform() end
---@return float
function ABP_GatlingGun_C:GetDefaultBlurAngle() end
---@param NewParam UNiagaraSystem
function ABP_GatlingGun_C:GetMuzzleEffect(NewParam) end
---@param Time double
function ABP_GatlingGun_C:GetShootInterval(Time) end
---@param Rotator FRotator
function ABP_GatlingGun_C:GetMuzzleRotator(Rotator) end
---@param MuzzleLocation FVector
function ABP_GatlingGun_C:GetMuzzleLocation(MuzzleLocation) end
---@param bCanShootOnRelease boolean
function ABP_GatlingGun_C:OnReleaseTrigger(bCanShootOnRelease) end
function ABP_GatlingGun_C:OnPullTrigger() end
---@param EndPlayReason EEndPlayReason::Type
function ABP_GatlingGun_C:ReceiveEndPlay(EndPlayReason) end
---@param EntryPoint int32
function ABP_GatlingGun_C:ExecuteUbergraph_BP_GatlingGun(EntryPoint) end


