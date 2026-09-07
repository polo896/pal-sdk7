#ifndef UE4SS_SDK_BP_UniqueAction_PoseidonOrca_TorrentLaser_HPP
#define UE4SS_SDK_BP_UniqueAction_PoseidonOrca_TorrentLaser_HPP

class UBP_UniqueAction_PoseidonOrca_TorrentLaser_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    TArray<FReserveMontage> Montage List;                                             // 0x02A0 (size: 0x10)
    FVector BeamStartOffset;                                                          // 0x02B0 (size: 0x18)
    FVector BeamEndOffset;                                                            // 0x02C8 (size: 0x18)
    class ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Beam_C* CurrentLaser;       // 0x02E0 (size: 0x8)
    double LaserMaxLength;                                                            // 0x02E8 (size: 0x8)
    bool EnableRotate;                                                                // 0x02F0 (size: 0x1)
    float Timer;                                                                      // 0x02F4 (size: 0x4)
    class UCurveFloat* LerpCurve;                                                     // 0x02F8 (size: 0x8)
    EVisibilityBasedAnimTickOption Original Anim Tick Option;                         // 0x0300 (size: 0x1)
    TArray<class ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Mark_C*> Marks;      // 0x0308 (size: 0x10)
    float BurstDelay;                                                                 // 0x0318 (size: 0x4)
    FTimerHandle MarkCreateTimer;                                                     // 0x0320 (size: 0x8)
    bool LastHittedGround;                                                            // 0x0328 (size: 0x1)
    FVector CurrentValidMarkLocation;                                                 // 0x0330 (size: 0x18)
    FVector LastValidMarkLocation;                                                    // 0x0348 (size: 0x18)
    bool IsHorizontal;                                                                // 0x0360 (size: 0x1)
    double BurstIntervalDistance;                                                     // 0x0368 (size: 0x8)

    void TraceBeam(float InTime);
    void CreateMark();
    void DelayBurst();
    void TransformLocalOffset(class AActor* Actor, FVector LocalOffset, FVector& Offset);
    void GetGroundOrWaterPlaneTrace(const FVector Start, const FVector End, FVector& Location, bool& Hitted, bool& IsWater);
    void TickAction(float DeltaTime);
    void OnMontageNotifyEnd(class UAnimMontage* Montage, FName NotifyName);
    void OnMontageNotifyBegin(class UAnimMontage* Montage, FName NotifyName);
    void OnBeginAction();
    void OnEndAction();
    void OnMontageEnded(class UAnimMontage* Montage, bool bInterrupted);
    void ExecuteUbergraph_BP_UniqueAction_PoseidonOrca_TorrentLaser(int32 EntryPoint);
}; // Size: 0x370

#endif
