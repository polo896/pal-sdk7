---@meta

---@class ABP_ElectricArcAssaultRifle_C : ABP_NormalRifle_C
---@field UberGraphFrame FPointerToUberGraphFrame
local ABP_ElectricArcAssaultRifle_C = {}

---@param AmmoClass TSubclassOf<AActor>
function ABP_ElectricArcAssaultRifle_C:GetAmmoClass(AmmoClass) end
---@param Effect UNiagaraSystem
function ABP_ElectricArcAssaultRifle_C:GetMuzzleEffectAttached(Effect) end
---@param Particle_System UParticleSystem
function ABP_ElectricArcAssaultRifle_C:GetMuzzleEffectParticle(Particle_System) end
---@param NewParam UNiagaraSystem
function ABP_ElectricArcAssaultRifle_C:GetMuzzleEffect(NewParam) end
function ABP_ElectricArcAssaultRifle_C:StopWeaponAnim() end
---@param NotifyName FName
function ABP_ElectricArcAssaultRifle_C:OnNotifyEnd_31BE164E46A644E12F45EA90D6A6FA2D(NotifyName) end
---@param NotifyName FName
function ABP_ElectricArcAssaultRifle_C:OnNotifyBegin_31BE164E46A644E12F45EA90D6A6FA2D(NotifyName) end
---@param NotifyName FName
function ABP_ElectricArcAssaultRifle_C:OnInterrupted_31BE164E46A644E12F45EA90D6A6FA2D(NotifyName) end
---@param NotifyName FName
function ABP_ElectricArcAssaultRifle_C:OnBlendOut_31BE164E46A644E12F45EA90D6A6FA2D(NotifyName) end
---@param NotifyName FName
function ABP_ElectricArcAssaultRifle_C:OnCompleted_31BE164E46A644E12F45EA90D6A6FA2D(NotifyName) end
---@param bCanShootOnRelease boolean
function ABP_ElectricArcAssaultRifle_C:OnReleaseTrigger(bCanShootOnRelease) end
---@param BulletActor APalBullet
function ABP_ElectricArcAssaultRifle_C:OnShoot(BulletActor) end
---@param InReloadSpeedPlayRate float
function ABP_ElectricArcAssaultRifle_C:OnReloadStart(InReloadSpeedPlayRate) end
---@param EntryPoint int32
function ABP_ElectricArcAssaultRifle_C:ExecuteUbergraph_BP_ElectricArcAssaultRifle(EntryPoint) end


