#ifndef UE4SS_SDK_BP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_HPP
#define UE4SS_SDK_BP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_HPP

class ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UPalProjectileMovementComponent* PalProjectileMovement;                     // 0x0438 (size: 0x8)
    class UCapsuleComponent* Capsule;                                                 // 0x0440 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0448 (size: 0x8)
    double TimeUntilFade;                                                             // 0x0450 (size: 0x8)
    FVector2D HomingTimeRange;                                                        // 0x0458 (size: 0x10)
    double TargetLocationNoiseRadius;                                                 // 0x0468 (size: 0x8)
    FVector TargetLocationNoise;                                                      // 0x0470 (size: 0x18)
    bool EnableUserHorming;                                                           // 0x0488 (size: 0x1)
    double ForceTargetRate;                                                           // 0x0490 (size: 0x8)
    class UNiagaraSystem* NiagaraOnHit;                                               // 0x0498 (size: 0x8)
    bool EnableUseHitEffect;                                                          // 0x04A0 (size: 0x1)
    double ScaleCache;                                                                // 0x04A8 (size: 0x8)
    double CurrentSpeed;                                                              // 0x04B0 (size: 0x8)
    FVector ForceLocation;                                                            // 0x04B8 (size: 0x18)

    void SetTargetLocation(FVector Location);
    void SetDirection(FRotator Direction);
    void SetTarget(class AActor* Target);
    void FadeOutEffect(double DeltaSecond);
    void ReceiveBeginPlay();
    void OnTime();
    void StartHoming();
    void EndHoming();
    void ReceiveTick(float DeltaSeconds);
    void SetScale(double Scale);
    void BndEvt__BP_SkillEffect_FlareArrow_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(class UPrimitiveComponent* HitComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
    void BndEvt__BP_SkillEffect_FlareArrow_AttackFilter_K2Node_ComponentBoundEvent_1_OnAttackDelegate__DelegateSignature(class AActor* Defencer, FPalDamageInfo DamageInfo, int32 HitCount, class UPrimitiveComponent* AttackerComponent);
    void EndProjectile();
    void ExecuteUbergraph_BP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Projectile(int32 EntryPoint);
}; // Size: 0x4D0

#endif
