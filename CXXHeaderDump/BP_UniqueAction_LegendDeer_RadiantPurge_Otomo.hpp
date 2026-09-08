#ifndef UE4SS_SDK_BP_UniqueAction_LegendDeer_RadiantPurge_Otomo_HPP
#define UE4SS_SDK_BP_UniqueAction_LegendDeer_RadiantPurge_Otomo_HPP

class UBP_UniqueAction_LegendDeer_RadiantPurge_Otomo_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    TArray<FReserveMontage> Montage List;                                             // 0x02A0 (size: 0x10)
    TEnumAsByte<Enum_RadiantPurge_State::Type> State;                                 // 0x02B0 (size: 0x1)
    double ChargeTime;                                                                // 0x02B8 (size: 0x8)
    FTimerHandle CurrentTimer;                                                        // 0x02C0 (size: 0x8)
    float ActTime;                                                                    // 0x02C8 (size: 0x4)
    FVector OriginalLocation;                                                         // 0x02D0 (size: 0x18)
    double JumpHeight;                                                                // 0x02E8 (size: 0x8)
    float CurrentOffsetAlpha;                                                         // 0x02F0 (size: 0x4)
    bool Landing;                                                                     // 0x02F4 (size: 0x1)
    class ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Ball_C* BallEffect;     // 0x02F8 (size: 0x8)
    double Ball_Height;                                                               // 0x0300 (size: 0x8)

    void TickAction(float DeltaTime);
    void GetMontageListByState(TArray<FReserveMontage>& montageList);
    void OnNotifyEnd_53B9EC8A4DCE6F86D0C02BB1828E2148(FName NotifyName);
    void OnNotifyBegin_53B9EC8A4DCE6F86D0C02BB1828E2148(FName NotifyName);
    void OnInterrupted_53B9EC8A4DCE6F86D0C02BB1828E2148(FName NotifyName);
    void OnBlendOut_53B9EC8A4DCE6F86D0C02BB1828E2148(FName NotifyName);
    void OnCompleted_53B9EC8A4DCE6F86D0C02BB1828E2148(FName NotifyName);
    void OnBeginAction();
    void OnEndAction();
    void Act();
    void ActEnd();
    void OnMontageEnd(class UAnimMontage* Montage, bool bInterrupted);
    void OnMontageNotify(class UAnimMontage* Montage, FName NotifyName);
    void ExecuteUbergraph_BP_UniqueAction_LegendDeer_RadiantPurge_Otomo(int32 EntryPoint);
}; // Size: 0x308

#endif
