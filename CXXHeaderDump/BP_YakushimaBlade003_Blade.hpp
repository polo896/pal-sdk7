#ifndef UE4SS_SDK_BP_YakushimaBlade003_Blade_HPP
#define UE4SS_SDK_BP_YakushimaBlade003_Blade_HPP

class ABP_YakushimaBlade003_Blade_C : public ABP_AttackBulletBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0420 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0428 (size: 0x8)
    class UCapsuleComponent* Capsule;                                                 // 0x0430 (size: 0x8)
    class UArrowComponent* Arrow3;                                                    // 0x0438 (size: 0x8)
    class UArrowComponent* Arrow2;                                                    // 0x0440 (size: 0x8)
    class UArrowComponent* Arrow1;                                                    // 0x0448 (size: 0x8)
    class USkeletalMeshComponent* SkeletalMesh;                                       // 0x0450 (size: 0x8)
    class USceneComponent* RotScene;                                                  // 0x0458 (size: 0x8)
    class USceneComponent* BladeScene;                                                // 0x0460 (size: 0x8)
    class UArrowComponent* Arrow;                                                     // 0x0468 (size: 0x8)
    class APalCharacter* CurrentTarget;                                               // 0x0470 (size: 0x8)
    class APalCharacter* OwnerCharacter;                                              // 0x0478 (size: 0x8)
    int32 Index;                                                                      // 0x0480 (size: 0x4)
    FQuaternionSpringState QuatSpring;                                                // 0x0490 (size: 0x40)
    FVectorSpringState Spring State;                                                  // 0x04D0 (size: 0x38)
    int32 Max Num;                                                                    // 0x0508 (size: 0x4)
    class ABP_YakushimaBlade003_C* OwnerWeapon;                                       // 0x0510 (size: 0x8)
    double DefaultBladeForwardDistance;                                               // 0x0518 (size: 0x8)
    double DefaultBladeRightDistance;                                                 // 0x0520 (size: 0x8)
    double DefaultBladeUpDistance;                                                    // 0x0528 (size: 0x8)
    double DefaultBladeAngle;                                                         // 0x0530 (size: 0x8)
    double FindEnemyAIMRange;                                                         // 0x0538 (size: 0x8)
    double FindEnemyAroundRange;                                                      // 0x0540 (size: 0x8)
    double BladeMaxDistance;                                                          // 0x0548 (size: 0x8)
    FString ThrustActionName;                                                         // 0x0550 (size: 0x10)
    FString CurrentActionName;                                                        // 0x0560 (size: 0x10)
    bool bThrustUp;                                                                   // 0x0570 (size: 0x1)
    double CurrentActionTime;                                                         // 0x0578 (size: 0x8)
    double ActionDelayTime;                                                           // 0x0580 (size: 0x8)
    bool bExecutingAction;                                                            // 0x0588 (size: 0x1)
    FString SlashActionName;                                                          // 0x0590 (size: 0x10)
    double ThrustUpTotalTime;                                                         // 0x05A0 (size: 0x8)
    double ThrustUpDistance;                                                          // 0x05A8 (size: 0x8)
    FVector ThrustInitialLocation;                                                    // 0x05B0 (size: 0x18)
    FVector ThrustFinalLocation;                                                      // 0x05C8 (size: 0x18)
    double ThrustOverrunDistance;                                                     // 0x05E0 (size: 0x8)
    double ThrustTotalTime;                                                           // 0x05E8 (size: 0x8)
    double OffsetTime;                                                                // 0x05F0 (size: 0x8)
    double CurrentTime;                                                               // 0x05F8 (size: 0x8)
    FRotator SlashInitialRotation;                                                    // 0x0600 (size: 0x18)
    FVector SlashInitialLocation;                                                     // 0x0618 (size: 0x18)
    bool bSlashWarmUp;                                                                // 0x0630 (size: 0x1)
    FVector SlashDir;                                                                 // 0x0638 (size: 0x18)
    bool bSlashForward;                                                               // 0x0650 (size: 0x1)
    double SlashTotalTime;                                                            // 0x0658 (size: 0x8)
    double SlashLeaveDistance;                                                        // 0x0660 (size: 0x8)
    double SlashAttackDistance;                                                       // 0x0668 (size: 0x8)
    double FloatingSpeed;                                                             // 0x0670 (size: 0x8)
    double FloatingAmplitude;                                                         // 0x0678 (size: 0x8)
    double FindEnemyFrontDegree;                                                      // 0x0680 (size: 0x8)
    bool bStartFadeOutEffect;                                                         // 0x0688 (size: 0x1)
    double FadeOutTimer;                                                              // 0x0690 (size: 0x8)
    double EndEffectTotalTime;                                                        // 0x0698 (size: 0x8)
    class UNiagaraSystem* FadeNiagara;                                                // 0x06A0 (size: 0x8)

    bool CanExecuteAction();
    void CheckOwnerLive();
    void GetCurrentTargetLocation(FVector& NewParam);
    bool IsDestroy(class UPrimitiveComponent* HitComp, class AActor* OtherCharacter, class UPrimitiveComponent* OtherComp, const FHitResult& Hit);
    void SetBladeLocationAndRotation(FVector NewLocation, FRotator NewRotation);
    void SetBladeLocation(FVector NewLocation);
    void GetBladeRotation(FRotator& Rotation);
    void GetBladeLocation(FVector& Location);
    void ResetActionTime();
    void GetTargetLocationAndRotation(FVector& Location, FRotator& Rotator);
    void GetDefaultPosition(FVector& Location, FRotator& Rotator);
    void UpdateThrust(double DeltaTime);
    void InitializeThrust();
    void UpdateSlash(double DeltaTime);
    void InitializeSlash();
    void Initialize(class ABP_YakushimaBlade003_C* OwnerWeapon, class APalCharacter* OwnerCharacter, int32 Index, int32 MaxNum);
    void ReceiveTick(float DeltaSeconds);
    void UpdateBladeLocationAndRotation(double DeltaTime);
    void UpdateTarget();
    void CancelCurrentAction();
    void ExecuteNextAction(FString Selection);
    void UpdateAction(double DeltaTime);
    void EndCurrentAction();
    void ReceiveBeginPlay();
    void OnHitToActor(class UPrimitiveComponent* HitComp, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, const FHitResult& Hit);
    void FadeOutEffect();
    void StartFadeOut();
    void ExecuteUbergraph_BP_YakushimaBlade003_Blade(int32 EntryPoint);
}; // Size: 0x6A8

#endif
