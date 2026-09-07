---@meta

---@class ABP_SkillEffect_WindCutterShot_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field NS_WindCutterShoot UNiagaraComponent
---@field ShootIntervalTime double
---@field TimeHandle FTimerHandle
---@field BulletClass TSubclassOf<AActor>
---@field OnSpawnBulletDelegate FBP_SkillEffect_WindCutterShot_COnSpawnBulletDelegate
local ABP_SkillEffect_WindCutterShot_C = {}

---@param TargetLocation FVector
function ABP_SkillEffect_WindCutterShot_C:SetTargetLocation(TargetLocation) end
function ABP_SkillEffect_WindCutterShot_C:ReceiveBeginPlay() end
function ABP_SkillEffect_WindCutterShot_C:Shoot() end
---@param EndPlayReason EEndPlayReason::Type
function ABP_SkillEffect_WindCutterShot_C:ReceiveEndPlay(EndPlayReason) end
---@param EntryPoint int32
function ABP_SkillEffect_WindCutterShot_C:ExecuteUbergraph_BP_SkillEffect_WindCutterShot(EntryPoint) end
---@param Bullet AActor
function ABP_SkillEffect_WindCutterShot_C:OnSpawnBulletDelegate__DelegateSignature(Bullet) end


