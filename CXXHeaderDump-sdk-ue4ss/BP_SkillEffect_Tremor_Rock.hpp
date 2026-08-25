#ifndef UE4SS_SDK_BP_SkillEffect_Tremor_Rock_HPP
#define UE4SS_SDK_BP_SkillEffect_Tremor_Rock_HPP

class ABP_SkillEffect_Tremor_Rock_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UCapsuleComponent* Capsule;                                                 // 0x0438 (size: 0x8)
    class UProjectileMovementComponent* ProjectileMovement;                           // 0x0440 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0448 (size: 0x8)
    double EffectDuration;                                                            // 0x0450 (size: 0x8)
    double BaseSpeed;                                                                 // 0x0458 (size: 0x8)
    float RandSpeedRange;                                                             // 0x0460 (size: 0x4)
    double MinRockScale;                                                              // 0x0468 (size: 0x8)
    double MaxRockScale;                                                              // 0x0470 (size: 0x8)
    double CurrentScale;                                                              // 0x0478 (size: 0x8)

    void ReceiveBeginPlay();
    void OnBreakAction();
    void FadeOutEffect(double DeltaSecond);
    void BndEvt__BP_SkillEffectDragonMeteorBullet2_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(class UPrimitiveComponent* HitComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
    void BndEvt__BP_SkillEffectDragonMeteorBullet2_Capsule_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(class UPrimitiveComponent* OverlappedComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult);
    void ExecuteUbergraph_BP_SkillEffect_Tremor_Rock(int32 EntryPoint);
}; // Size: 0x480

#endif
