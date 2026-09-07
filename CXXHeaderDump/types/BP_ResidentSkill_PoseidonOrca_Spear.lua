---@meta

---@class UBP_ResidentSkill_PoseidonOrca_Spear_C : UPalResidentSkillPoseidonOrca_SpearBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BulletMax int32
---@field ShootInteraval double
---@field IsShootCool_Server boolean
---@field IsActiveOtomo boolean
---@field CurrentBulletNum_Local int32
---@field BulletLocationOffset TArray<FVector>
---@field BulletEffectList TArray<ABP_SkillEffectPoseidonOrca_SpearBullet_C>
---@field OpenIntervalTime double
---@field IsOpenInterval boolean
---@field OpenIntervalTimer FTimerHandle
---@field BulletChargeTimer FTimerHandle
---@field BulletCloseTimer FTimerHandle
---@field BulletCloseTime double
---@field BulletSpawnEffect UNiagaraSystem
---@field BulletShootEffect UNiagaraSystem
---@field flagName FName
local UBP_ResidentSkill_PoseidonOrca_Spear_C = {}

---@param IsNeedOpen boolean
function UBP_ResidentSkill_PoseidonOrca_Spear_C:IsNeedBulletOpen(IsNeedOpen) end
---@param IsEnable boolean
function UBP_ResidentSkill_PoseidonOrca_Spear_C:SetEnableSendReticleTarget(IsEnable) end
function UBP_ResidentSkill_PoseidonOrca_Spear_C:UpdateShootByMeleeAttack() end
---@param NotifyName FName
---@param NotifyParameter FPalResidentSkillNotifyParameter
function UBP_ResidentSkill_PoseidonOrca_Spear_C:OnNotify(NotifyName, NotifyParameter) end
---@return boolean
function UBP_ResidentSkill_PoseidonOrca_Spear_C:IsBattleMode() end
function UBP_ResidentSkill_PoseidonOrca_Spear_C:UpdateOpenMode() end
---@return boolean
function UBP_ResidentSkill_PoseidonOrca_Spear_C:IsMeleeAttacking() end
---@param CanShoot boolean
function UBP_ResidentSkill_PoseidonOrca_Spear_C:CanShootSpear(CanShoot) end
---@param Target APalCharacter
function UBP_ResidentSkill_PoseidonOrca_Spear_C:FindTarget(Target) end
---@param Target APalCharacter
UBP_ResidentSkill_PoseidonOrca_Spear_C['On Shoot Bullet'] = function(self, Target) end
---@param BulletIndex int32
function UBP_ResidentSkill_PoseidonOrca_Spear_C:CreateBullet(BulletIndex) end
---@param Effect APalSkillEffectBase
---@param Offset FVector
function UBP_ResidentSkill_PoseidonOrca_Spear_C:AttachToOwner(Effect, Offset) end
function UBP_ResidentSkill_PoseidonOrca_Spear_C:ChargeBullets() end
UBP_ResidentSkill_PoseidonOrca_Spear_C['カスタムイベント_0'] = function(self, ) end
UBP_ResidentSkill_PoseidonOrca_Spear_C['カスタムイベント_1'] = function(self, ) end
function UBP_ResidentSkill_PoseidonOrca_Spear_C:OnActivatedAsOtomo() end
function UBP_ResidentSkill_PoseidonOrca_Spear_C:OnInactivatedAsOtomo() end
---@param Target APalCharacter
function UBP_ResidentSkill_PoseidonOrca_Spear_C:ShootBullet(Target) end
---@param DeltaTime float
function UBP_ResidentSkill_PoseidonOrca_Spear_C:OnTick(DeltaTime) end
function UBP_ResidentSkill_PoseidonOrca_Spear_C:OpenBullets() end
function UBP_ResidentSkill_PoseidonOrca_Spear_C:CloseBullets() end
function UBP_ResidentSkill_PoseidonOrca_Spear_C:OnShooterShootBulletDelegate() end
UBP_ResidentSkill_PoseidonOrca_Spear_C['カスタムイベント'] = function(self, ) end
function UBP_ResidentSkill_PoseidonOrca_Spear_C:OnInitialize() end
function UBP_ResidentSkill_PoseidonOrca_Spear_C:OnBulletCloseTimer() end
function UBP_ResidentSkill_PoseidonOrca_Spear_C:OnShooterPullTrigger() end
---@param EntryPoint int32
function UBP_ResidentSkill_PoseidonOrca_Spear_C:ExecuteUbergraph_BP_ResidentSkill_PoseidonOrca_Spear(EntryPoint) end


