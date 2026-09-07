---@meta

---@class ABP_SkillEffect_BubbleShot_Bullet_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BulletBlockCollision USphereComponent
---@field PalProjectileMovement UPalProjectileMovementComponent
---@field AttackCollision USphereComponent
---@field DisableHomingTrigger USphereComponent
---@field BubbleShotEffect UNiagaraComponent
---@field RandSpeed float
---@field MinSpeed double
---@field Gravity double
---@field ['Max Homing'] double
---@field ['Add Homing'] double
---@field EffectDuration float
local ABP_SkillEffect_BubbleShot_Bullet_C = {}

---@param Dot double
function ABP_SkillEffect_BubbleShot_Bullet_C:GetHomingEndDot(Dot) end
---@param NiagaraComp UNiagaraComponent
function ABP_SkillEffect_BubbleShot_Bullet_C:SetRandomValueIntoNiagaraVariable(NiagaraComp) end
function ABP_SkillEffect_BubbleShot_Bullet_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function ABP_SkillEffect_BubbleShot_Bullet_C:ReceiveTick(DeltaSeconds) end
---@param OverlappedComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param OtherBodyIndex int32
---@param bFromSweep boolean
---@param SweepResult FHitResult
function ABP_SkillEffect_BubbleShot_Bullet_C:BndEvt__BP_SkillEffect_BubbleShot_Bullet_DisableHomingTrigger_K2Node_ComponentBoundEvent_0_ComponentBeginOverlapSignature__DelegateSignature(OverlappedComponent, OtherActor, OtherComp, OtherBodyIndex, bFromSweep, SweepResult) end
function ABP_SkillEffect_BubbleShot_Bullet_C:OnHitGround() end
---@param DeltaSecond double
function ABP_SkillEffect_BubbleShot_Bullet_C:FadeOutEffect(DeltaSecond) end
---@param Defencer AActor
---@param DamageInfo FPalDamageInfo
---@param HitCount int32
---@param AttackerComponent UPrimitiveComponent
function ABP_SkillEffect_BubbleShot_Bullet_C:BndEvt__BP_SkillEffect_BubbleShot_Bullet_AttackFilter_K2Node_ComponentBoundEvent_1_OnAttackDelegate__DelegateSignature(Defencer, DamageInfo, HitCount, AttackerComponent) end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_BubbleShot_Bullet_C:BndEvt__BP_SkillEffect_BubbleShot_Bullet_MovementSphereRoot_K2Node_ComponentBoundEvent_4_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
ABP_SkillEffect_BubbleShot_Bullet_C['カスタムイベント'] = function(self, ) end
---@param PSystem UNiagaraComponent
function ABP_SkillEffect_BubbleShot_Bullet_C:BndEvt__BP_SkillEffect_BubbleShot_Bullet_BubbleShotEffect_K2Node_ComponentBoundEvent_2_OnNiagaraSystemFinished__DelegateSignature(PSystem) end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_SkillEffect_BubbleShot_Bullet_C:BndEvt__BP_SkillEffect_BubbleShot_Bullet_AttackCollision1_K2Node_ComponentBoundEvent_3_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param EntryPoint int32
function ABP_SkillEffect_BubbleShot_Bullet_C:ExecuteUbergraph_BP_SkillEffect_BubbleShot_Bullet(EntryPoint) end


