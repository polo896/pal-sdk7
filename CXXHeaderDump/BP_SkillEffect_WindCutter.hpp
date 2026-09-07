#ifndef UE4SS_SDK_BP_SkillEffect_WindCutter_HPP
#define UE4SS_SDK_BP_SkillEffect_WindCutter_HPP

class ABP_SkillEffect_WindCutter_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UNiagaraComponent* NS_WindCutterBullet;                                     // 0x0438 (size: 0x8)
    class UBoxComponent* Box;                                                         // 0x0440 (size: 0x8)
    class UProjectileMovementComponent* ProjectileMovement;                           // 0x0448 (size: 0x8)

    void ReceiveBeginPlay();
    void BndEvt__BP_SkillEffect_WindCutter_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(class UPrimitiveComponent* HitComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
    void FadeOutEffect(double DeltaSecond);
    void BndEvt__BP_SkillEffect_WindCutter_AttackFilter_K2Node_ComponentBoundEvent_1_OnAttackDelegate__DelegateSignature(class AActor* Defencer, FPalDamageInfo DamageInfo, int32 HitCount, class UPrimitiveComponent* AttackerComponent);
    void ExecuteUbergraph_BP_SkillEffect_WindCutter(int32 EntryPoint);
}; // Size: 0x450

#endif
