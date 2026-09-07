#ifndef UE4SS_SDK_BP_UniqueSkillEffect_ClownRabbit_TrickShow_Bullet_HPP
#define UE4SS_SDK_BP_UniqueSkillEffect_ClownRabbit_TrickShow_Bullet_HPP

class ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Bullet_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UPalProjectileMovementComponent* PalProjectileMovement;                     // 0x0438 (size: 0x8)
    class UCapsuleComponent* Capsule;                                                 // 0x0440 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0448 (size: 0x8)
    double Life;                                                                      // 0x0450 (size: 0x8)
    float Max Speed;                                                                  // 0x0458 (size: 0x4)

    void SetHomingTarget(class AActor* Target, bool& Success);
    void ReceiveBeginPlay();
    void EndLife();
    void BndEvt__BP_UniqueSkillEffect_ClownRabbit_TrickShow_Bullet_AttackFilter_K2Node_ComponentBoundEvent_0_OnAttackDelegate__DelegateSignature(class AActor* Defencer, FPalDamageInfo DamageInfo, int32 HitCount, class UPrimitiveComponent* AttackerComponent);
    void BndEvt__BP_UniqueSkillEffect_ClownRabbit_TrickShow_Bullet_MovementSphereRoot_K2Node_ComponentBoundEvent_1_ComponentHitSignature__DelegateSignature(class UPrimitiveComponent* HitComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
    void FadeOutEffect(double DeltaSecond);
    void ExecuteUbergraph_BP_UniqueSkillEffect_ClownRabbit_TrickShow_Bullet(int32 EntryPoint);
}; // Size: 0x45C

#endif
