#ifndef UE4SS_SDK_BP_SkillEffect_FireSeed_Bullet_HPP
#define UE4SS_SDK_BP_SkillEffect_FireSeed_Bullet_HPP

class ABP_SkillEffect_FireSeed_Bullet_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class USphereComponent* Collision_0;                                              // 0x0438 (size: 0x8)
    class UProjectileMovementComponent* ProjectileMovement_0;                         // 0x0440 (size: 0x8)
    class UNiagaraComponent* NS_FireSeed_Bullet;                                      // 0x0448 (size: 0x8)
    float RandSpeed;                                                                  // 0x0450 (size: 0x4)
    double Gravity;                                                                   // 0x0458 (size: 0x8)
    double MinSpeed;                                                                  // 0x0460 (size: 0x8)
    FRandomStream RandomStream_0;                                                     // 0x0468 (size: 0x8)
    float EffectLifeTime;                                                             // 0x0470 (size: 0x4)

    void ReceiveBeginPlay();
    void FadeOutEffect(double DeltaSecond);
    void BndEvt__BP_SkillEffect_FireSeed_Bullet_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(class UPrimitiveComponent* HitComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
    void BndEvt__BP_SkillEffect_AirCanon_AttackFilter_K2Node_ComponentBoundEvent_0_OnAttackDelegate__DelegateSignature(class AActor* Defencer, FPalDamageInfo DamageInfo, int32 HitCount, class UPrimitiveComponent* AttackerComponent);
    void ExecuteUbergraph_BP_SkillEffect_FireSeed_Bullet(int32 EntryPoint);
}; // Size: 0x474

#endif
