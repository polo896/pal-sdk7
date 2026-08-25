#ifndef UE4SS_SDK_BP_SkillEffect_IceMissile_Bullet_HPP
#define UE4SS_SDK_BP_SkillEffect_IceMissile_Bullet_HPP

class ABP_SkillEffect_IceMissile_Bullet_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UPalProjectileMovementComponent* PalProjectileMovement;                     // 0x0438 (size: 0x8)
    class UCapsuleComponent* Capsule;                                                 // 0x0440 (size: 0x8)
    class UNiagaraComponent* NS_IceMissileBullet;                                     // 0x0448 (size: 0x8)
    class AActor* TargetActor;                                                        // 0x0450 (size: 0x8)
    double UpTime;                                                                    // 0x0458 (size: 0x8)
    double TurnAroundInterval;                                                        // 0x0460 (size: 0x8)
    bool IsTurnAround;                                                                // 0x0468 (size: 0x1)
    double Timer;                                                                     // 0x0470 (size: 0x8)
    double HomingOffDistance;                                                         // 0x0478 (size: 0x8)
    bool IsHoming;                                                                    // 0x0480 (size: 0x1)
    float HomingPowerRate;                                                            // 0x0484 (size: 0x4)
    class ABP_PredictedTarget_C* Predicted Target;                                    // 0x0488 (size: 0x8)

    FVector GetCurrentTargetLocation();
    void ReceiveBeginPlay();
    void ReceiveActorBeginOverlap(class AActor* OtherActor);
    void ReceiveTick(float DeltaSeconds);
    void StartTurnAround();
    void TurnAround(double DeltaTime);
    void OnHitDelegate_イベント_0(class UPrimitiveComponent* MyHitComponent, class AActor* OtherHitActor, class UPrimitiveComponent* OtherHitComponent, const TArray<int32>& FoliageIndex, FVector HitLocation, int32 HitCount);
    void BndEvt__BP_EnergyShotBullet_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(class UPrimitiveComponent* HitComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
    void BndEvt__BP_EnergyShotBullet_AttackFilter_K2Node_ComponentBoundEvent_1_OnAttackDelegate__DelegateSignature(class AActor* Defencer, FPalDamageInfo DamageInfo, int32 HitCount, class UPrimitiveComponent* AttackerComponent);
    void OnBreakAction();
    void FadeOutEffect(double DeltaSecond);
    void ExecuteUbergraph_BP_SkillEffect_IceMissile_Bullet(int32 EntryPoint);
}; // Size: 0x490

#endif
