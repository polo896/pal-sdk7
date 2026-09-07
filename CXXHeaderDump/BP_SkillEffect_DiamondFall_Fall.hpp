#ifndef UE4SS_SDK_BP_SkillEffect_DiamondFall_Fall_HPP
#define UE4SS_SDK_BP_SkillEffect_DiamondFall_Fall_HPP

class ABP_SkillEffect_DiamondFall_Fall_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0438 (size: 0x8)
    class UProjectileMovementComponent* ProjectileMovement;                           // 0x0440 (size: 0x8)
    class UCapsuleComponent* Capsule;                                                 // 0x0448 (size: 0x8)
    float FallingPrepareTime;                                                         // 0x0450 (size: 0x4)
    class UNiagaraComponent* sign;                                                    // 0x0458 (size: 0x8)
    double MinScale;                                                                  // 0x0460 (size: 0x8)
    double MaxScale;                                                                  // 0x0468 (size: 0x8)
    double CurrentScale;                                                              // 0x0470 (size: 0x8)

    void FadeOutEffect(double DeltaSecond);
    void BndEvt__BP_SkillEffect_SeedMine_Seed_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(class UPrimitiveComponent* HitComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
    void BndEvt__BP_EnergyShotBullet_AttackFilter_K2Node_ComponentBoundEvent_1_OnAttackDelegate__DelegateSignature(class AActor* Defencer, FPalDamageInfo DamageInfo, int32 HitCount, class UPrimitiveComponent* AttackerComponent);
    void OnBreakAction();
    void ReceiveBeginPlay();
    void EnableFall();
    void ExecuteUbergraph_BP_SkillEffect_DiamondFall_Fall(int32 EntryPoint);
}; // Size: 0x478

#endif
