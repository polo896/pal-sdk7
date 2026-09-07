---@meta

---@class ABP_Bowgun_C : ABP_AssaultRifleBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_RightHandChildArrow UChildActorComponent
---@field Weapon USkeletalMeshComponent
---@field MuzzleEffect UNiagaraSystem
---@field TestPull boolean
local ABP_Bowgun_C = {}

function ABP_Bowgun_C:PlayReloadSound() end
function ABP_Bowgun_C:PlayFireSound() end
---@return float
function ABP_Bowgun_C:GetDefaultBlurAngle() end
---@param IsShoted boolean
function ABP_Bowgun_C:ShootArrowInternal(IsShoted) end
function ABP_Bowgun_C:ShootArrow() end
function ABP_Bowgun_C:ShootBullet() end
---@return FTransform
function ABP_Bowgun_C:GetLeftHandTransform() end
---@param isUse boolean
ABP_Bowgun_C['Is UseEjectionPort'] = function(self, isUse) end
---@param Transform FTransform
function ABP_Bowgun_C:GeyEjectionPortTransform(Transform) end
function ABP_Bowgun_C:GetShotAnimation() end
---@return boolean
function ABP_Bowgun_C:IsUseLeftHandAttach() end
---@param BulletActor APalBullet
function ABP_Bowgun_C:OnShoot(BulletActor) end
---@param Rotator FRotator
function ABP_Bowgun_C:GetMuzzleRotator(Rotator) end
---@param Time double
function ABP_Bowgun_C:GetShootInterval(Time) end
---@param MuzzleLocation FVector
function ABP_Bowgun_C:GetMuzzleLocation(MuzzleLocation) end
---@return FName
function ABP_Bowgun_C:GetEquipSocketName() end
---@param isHidden boolean
function ABP_Bowgun_C:HiddenWeaponSubPart(isHidden) end
function ABP_Bowgun_C:ReceiveBeginPlay() end
function ABP_Bowgun_C:OnPullTrigger() end
---@param InReloadSpeedPlayRate float
function ABP_Bowgun_C:OnReloadStart(InReloadSpeedPlayRate) end
---@param attachActor AActor
function ABP_Bowgun_C:OnAttachWeapon(attachActor) end
---@param detachActor AActor
function ABP_Bowgun_C:OnDetachWeapon(detachActor) end
---@param Type EWeaponNotifyType
function ABP_Bowgun_C:OnWeaponNotify(Type) end
---@param action UPalActionBase
function ABP_Bowgun_C:StopReloadWhenRoll(action) end
---@param Notify E_PalWeaponAnimationNotify::Type
function ABP_Bowgun_C:OnNotify(Notify) end
---@param EntryPoint int32
function ABP_Bowgun_C:ExecuteUbergraph_BP_Bowgun(EntryPoint) end


