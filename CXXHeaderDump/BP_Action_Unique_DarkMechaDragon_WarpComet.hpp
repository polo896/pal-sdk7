#ifndef UE4SS_SDK_BP_Action_Unique_DarkMechaDragon_WarpComet_HPP
#define UE4SS_SDK_BP_Action_Unique_DarkMechaDragon_WarpComet_HPP

class UBP_Action_Unique_DarkMechaDragon_WarpComet_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    class UNiagaraSystem* WarpEffectClass;                                            // 0x02A0 (size: 0x8)
    double StartingMoveFromStart;                                                     // 0x02A8 (size: 0x8)
    double StartingMoveSpeed;                                                         // 0x02B0 (size: 0x8)
    double StartingMoveRotateSpeed;                                                   // 0x02B8 (size: 0x8)
    double StartingMoveDuration;                                                      // 0x02C0 (size: 0x8)
    TArray<FTimerHandle> TimerHandles;                                                // 0x02C8 (size: 0x10)
    TArray<FReserveMontage> StartingMontages;                                         // 0x02D8 (size: 0x10)
    TArray<FReserveMontage> CometMontages;                                            // 0x02E8 (size: 0x10)
    TArray<FReserveMontage> TackleMontages;                                           // 0x02F8 (size: 0x10)
    TArray<FReserveMontage> EndMontage;                                               // 0x0308 (size: 0x10)
    double ScaleCache;                                                                // 0x0318 (size: 0x8)
    bool EnableStartMove;                                                             // 0x0320 (size: 0x1)
    class UNiagaraSystem* WarpEffectClass2;                                           // 0x0328 (size: 0x8)
    FVector WarpDistance;                                                             // 0x0330 (size: 0x18)
    double WarpDelayTimeFromStart;                                                    // 0x0348 (size: 0x8)
    double CometLoopAnimationDuration;                                                // 0x0350 (size: 0x8)
    double TackleSpeed;                                                               // 0x0358 (size: 0x8)
    double TackleLoopAnimationDurataion;                                              // 0x0360 (size: 0x8)
    bool EnableComet;                                                                 // 0x0368 (size: 0x1)
    double CheckGroundHeight;                                                         // 0x0370 (size: 0x8)
    int32 NumComet;                                                                   // 0x0378 (size: 0x4)
    double CometInterval;                                                             // 0x0380 (size: 0x8)
    double StartingMoveTimer;                                                         // 0x0388 (size: 0x8)
    double CometTimer;                                                                // 0x0390 (size: 0x8)
    TArray<FVector> CometSpawnLocationOffsets;                                        // 0x0398 (size: 0x10)
    double TackleTimer;                                                               // 0x03A8 (size: 0x8)
    int32 CometCounter;                                                               // 0x03B0 (size: 0x4)
    FVector2D CometPitchRange;                                                        // 0x03B8 (size: 0x10)
    FVector2D CometYawRange;                                                          // 0x03C8 (size: 0x10)
    double WarpEffectLocationOffset;                                                  // 0x03D8 (size: 0x8)
    double TackleDelayTime;                                                           // 0x03E0 (size: 0x8)
    class UCurveFloat* StartingMoveSpeedRateCurve;                                    // 0x03E8 (size: 0x8)
    class UCurveFloat* TackleSpeedRateCurve;                                          // 0x03F0 (size: 0x8)
    double WarpDistanceXYBetweenTarget;                                               // 0x03F8 (size: 0x8)
    double WarpHideTime;                                                              // 0x0400 (size: 0x8)
    double WarpCornerSlerpDistance;                                                   // 0x0408 (size: 0x8)
    bool IsHiding;                                                                    // 0x0410 (size: 0x1)
    bool IsWarping;                                                                   // 0x0411 (size: 0x1)
    FVector WarpOrigin;                                                               // 0x0418 (size: 0x18)
    FVector WarpDestination;                                                          // 0x0430 (size: 0x18)
    double WarpHideTimer;                                                             // 0x0448 (size: 0x8)
    class ABP_SkillEffectBase_C* WarpingSkillEffect;                                  // 0x0450 (size: 0x8)
    FVector WarpSlerpStartLocation;                                                   // 0x0458 (size: 0x18)
    bool IsSlerping;                                                                  // 0x0470 (size: 0x1)
    double SlerpTimer;                                                                // 0x0478 (size: 0x8)
    double SlerpTime;                                                                 // 0x0480 (size: 0x8)
    FVector SlerpCenter;                                                              // 0x0488 (size: 0x18)
    TEnumAsByte<EAction_DarkMechaDragonWarpCometType::Type> WarpCometState;           // 0x04A0 (size: 0x1)
    double StartingMoveDistance;                                                      // 0x04A8 (size: 0x8)
    FVector StartingMoveOrigin;                                                       // 0x04B0 (size: 0x18)
    class ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail_C* TackleTrailSkillEffect; // 0x04C8 (size: 0x8)
    FVector LastLocation;                                                             // 0x04D0 (size: 0x18)

    void CalcWarpDestination(FVector& Destination);
    void SetHideInGame(bool IsHide);
    void SpawnComet(FVector OffsetLocation, bool IsRight);
    void GetTackleDirection(FVector& Result);
    void IsCloseToGround(bool& IsGround);
    void IsEndState(bool& Result);
    void IsTackleState(bool& Result);
    void IsCometState(bool& Result);
    void IsStartState(bool& Result);
    void StopMontage();
    void OnBeginAction();
    void OnMontageEnded(class UAnimMontage* Montage, bool bInterrupted);
    void OnEndAction();
    void OnMontageNotifyBegin(class UAnimMontage* Montage, FName NotifyName);
    void OnMontageNotifyEnd(class UAnimMontage* Montage, FName NotifyName);
    void TickAction(float DeltaTime);
    void OnMontageStarted(class UAnimMontage* Montage);
    void OnActorBeginOverlap(class AActor* OverlappedActor, class AActor* OtherActor);
    void OnActorHit(class AActor* SelfActor, class AActor* OtherActor, FVector NormalImpulse, const FHitResult& Hit);
    void StartWarp();
    void StartMove();
    void EndTackle();
    void StartWarpInternal();
    void CustomEvent();
    void EndComet();
    void DisableCometAttack();
    void DisableMove();
    void ExecuteUbergraph_BP_Action_Unique_DarkMechaDragon_WarpComet(int32 EntryPoint);
}; // Size: 0x4E8

#endif
