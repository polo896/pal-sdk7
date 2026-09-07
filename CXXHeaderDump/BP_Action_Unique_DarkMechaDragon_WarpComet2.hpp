#ifndef UE4SS_SDK_BP_Action_Unique_DarkMechaDragon_WarpComet2_HPP
#define UE4SS_SDK_BP_Action_Unique_DarkMechaDragon_WarpComet2_HPP

class UBP_Action_Unique_DarkMechaDragon_WarpComet2_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    TArray<FReserveMontage> Montage List;                                             // 0x02A0 (size: 0x10)
    TEnumAsByte<ENum_WarpComet_State::Type> ActionState;                              // 0x02B0 (size: 0x1)
    double WarpDuration;                                                              // 0x02B8 (size: 0x8)
    double CometDuration;                                                             // 0x02C0 (size: 0x8)
    FTimerHandle CurrentActionTimer;                                                  // 0x02C8 (size: 0x8)
    double CrashDuration;                                                             // 0x02D0 (size: 0x8)
    float BlinkDelay;                                                                 // 0x02D8 (size: 0x4)
    FTimerHandle BlinkTimer;                                                          // 0x02E0 (size: 0x8)
    bool FirstBlink;                                                                  // 0x02E8 (size: 0x1)
    bool Moveable;                                                                    // 0x02E9 (size: 0x1)
    class ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_WarpTrail_C* TrailEffect;  // 0x02F0 (size: 0x8)
    class UCurveFloat* CenterDistanceCurve;                                           // 0x02F8 (size: 0x8)
    double MoveTimer;                                                                 // 0x0300 (size: 0x8)
    FVector CenterLocation;                                                           // 0x0308 (size: 0x18)
    double HeightMultiplier;                                                          // 0x0320 (size: 0x8)
    double AngleMultiplier;                                                           // 0x0328 (size: 0x8)
    bool EnableTrailRotate;                                                           // 0x0330 (size: 0x1)
    bool EnableActorRotate;                                                           // 0x0331 (size: 0x1)
    FVector TargetGroundLocation;                                                     // 0x0338 (size: 0x18)
    double DescendSpeed;                                                              // 0x0350 (size: 0x8)
    class ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail_C* TackleTrailSkillEffect; // 0x0358 (size: 0x8)
    FTimerHandle CometTimer;                                                          // 0x0360 (size: 0x8)
    TArray<FName> WingSockets;                                                        // 0x0368 (size: 0x10)
    int32 CometCount;                                                                 // 0x0378 (size: 0x4)
    float OriginalGravity;                                                            // 0x037C (size: 0x4)
    float OriginalAirControl;                                                         // 0x0380 (size: 0x4)
    double OriginalAcc;                                                               // 0x0388 (size: 0x8)
    float OriginalSpeed;                                                              // 0x0390 (size: 0x4)
    bool IsRideMode;                                                                  // 0x0394 (size: 0x1)
    class UNiagaraComponent* sign;                                                    // 0x0398 (size: 0x8)
    EVisibilityBasedAnimTickOption OriginalTickOption;                                // 0x03A0 (size: 0x1)
    float CometLauchDuration;                                                         // 0x03A4 (size: 0x4)
    FTimerHandle ForceEndTimer;                                                       // 0x03A8 (size: 0x8)
    FVector PreWarpLocation;                                                          // 0x03B0 (size: 0x18)
    bool Has Floor;                                                                   // 0x03C8 (size: 0x1)
    TArray<class APalPlayerCharacter*> LoupeAddedPlayers;                             // 0x03D0 (size: 0x10)
    double HeightLimit;                                                               // 0x03E0 (size: 0x8)
    class APalCharacter* CacheRider;                                                  // 0x03E8 (size: 0x8)

    void ActCameraOffset(bool Enable);
    void Get Height Limit(const FVector Start, double& Height);
    void OnMontageNotify(class UAnimMontage* Montage, FName NotifyName);
    void Switch Rider State(bool Visible, bool Moveable);
    void SpawnComet();
    void Switch Character Group Visibility(bool Visible);
    void TickAction(float DeltaTime);
    void On Montage List Ended();
    void GetNextMontageList(TArray<FReserveMontage>& Montage List);
    void OnBeginAction();
    void OnEndAction();
    void OnMontageEnded(class UAnimMontage* Montage, bool bInterrupted);
    void Blink();
    void ResetPlayerState(class AActor* RideActor);
    void LuanchEnd();
    void ForceEnd();
    void ExecuteUbergraph_BP_Action_Unique_DarkMechaDragon_WarpComet2(int32 EntryPoint);
}; // Size: 0x3F0

#endif
