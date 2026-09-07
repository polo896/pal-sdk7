#ifndef UE4SS_SDK_BP_Action_Unique_DarkMechaDragon_FunnelLaser_HPP
#define UE4SS_SDK_BP_Action_Unique_DarkMechaDragon_FunnelLaser_HPP

class UBP_Action_Unique_DarkMechaDragon_FunnelLaser_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    double DelaySetFunnel;                                                            // 0x02A0 (size: 0x8)
    TArray<FReserveMontage> montageList;                                              // 0x02A8 (size: 0x10)
    double ReadyAnimationTime;                                                        // 0x02B8 (size: 0x8)
    double ProcessAnimationTime;                                                      // 0x02C0 (size: 0x8)
    double AfterAnimationTime;                                                        // 0x02C8 (size: 0x8)
    TArray<FVector> LocationOffsets;                                                  // 0x02D0 (size: 0x10)
    TArray<FVector2D> HomingLocationYRanges;                                          // 0x02E0 (size: 0x10)
    TArray<FTimerHandle> TimerHandles;                                                // 0x02F0 (size: 0x10)
    TArray<class UCurveVector*> CurveVectors;                                         // 0x0300 (size: 0x10)
    bool EnableRotate;                                                                // 0x0310 (size: 0x1)
    TArray<class ABP_SkillEffect_Unique_DarkMechaDragon_FunnelLaser_Laser_C*> Lasers; // 0x0318 (size: 0x10)
    bool IsRaidBoss;                                                                  // 0x0328 (size: 0x1)

    void StopMontage();
    void GetAfterMontages(TArray<FReserveMontage>& Montages);
    void GetProcessMontages(TArray<FReserveMontage>& Montages);
    void GetReadyMontages(TArray<FReserveMontage>& Montages);
    void OnBeginAction();
    void TickAction(float DeltaTime);
    void OnEndAction();
    void SpawnFunnel();
    void CallSetFunnel();
    void CallProcess();
    void CallAfter();
    void CallEnd();
    void ExecuteUbergraph_BP_Action_Unique_DarkMechaDragon_FunnelLaser(int32 EntryPoint);
}; // Size: 0x329

#endif
