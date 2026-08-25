#ifndef UE4SS_SDK_BP_SkillEffect_SpreadPulse_Bullet_HPP
#define UE4SS_SDK_BP_SkillEffect_SpreadPulse_Bullet_HPP

class ABP_SkillEffect_SpreadPulse_Bullet_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class USphereComponent* SphereCollision;                                          // 0x0438 (size: 0x8)
    class UNiagaraComponent* MainEffect;                                              // 0x0440 (size: 0x8)
    class UProjectileMovementComponent* ProjectileMovement;                           // 0x0448 (size: 0x8)
    float EffectDuration;                                                             // 0x0450 (size: 0x4)

    void SetRandomValueIntoNiagaraVariable(class UNiagaraComponent* NiagaraComp);
    void IsValidHit(class AActor* SelfActor, class AActor* OtherHitActor, bool& IsHit);
    void ReceiveBeginPlay();
    void OnHitDelegate_イベント_0(class UPrimitiveComponent* MyHitComponent, class AActor* OtherHitActor, class UPrimitiveComponent* OtherHitComponent, const TArray<int32>& FoliageIndex, FVector HitLocation, int32 HitCount);
    void FadeOutEffect(double DeltaSecond);
    void OnHitGround();
    void BndEvt__BP_SkillEffect_SpreadPulse_Bullet_AttackFilter_K2Node_ComponentBoundEvent_1_OnAttackDelegate__DelegateSignature(class AActor* Defencer, FPalDamageInfo DamageInfo, int32 HitCount, class UPrimitiveComponent* AttackerComponent);
    void ReachEndLife();
    void BndEvt__BP_SkillEffect_SpreadPulse_Bullet_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(class UPrimitiveComponent* HitComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
    void ExecuteUbergraph_BP_SkillEffect_SpreadPulse_Bullet(int32 EntryPoint);
}; // Size: 0x454

#endif
