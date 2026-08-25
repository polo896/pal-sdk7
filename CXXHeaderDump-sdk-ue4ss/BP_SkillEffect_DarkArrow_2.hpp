#ifndef UE4SS_SDK_BP_SkillEffect_DarkArrow_2_HPP
#define UE4SS_SDK_BP_SkillEffect_DarkArrow_2_HPP

class ABP_SkillEffect_DarkArrow_2_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UCapsuleComponent* Capsule;                                                 // 0x0438 (size: 0x8)
    class UNiagaraComponent* NS_FireBlastOura;                                        // 0x0440 (size: 0x8)
    class UProjectileMovementComponent* ProjectileMovement;                           // 0x0448 (size: 0x8)
    bool IsHoming;                                                                    // 0x0450 (size: 0x1)
    double HomingOffDistance;                                                         // 0x0458 (size: 0x8)

    void ReceiveBeginPlay();
    void BndEvt__BP_SkillEffect_FlareArrow_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(class UPrimitiveComponent* HitComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
    void BndEvt__BP_SkillEffect_FlareArrow_AttackFilter_K2Node_ComponentBoundEvent_1_OnAttackDelegate__DelegateSignature(class AActor* Defencer, FPalDamageInfo DamageInfo, int32 HitCount, class UPrimitiveComponent* AttackerComponent);
    void FadeOutEffect(double DeltaSecond);
    void ExecuteUbergraph_BP_SkillEffect_DarkArrow_2(int32 EntryPoint);
}; // Size: 0x460

#endif
