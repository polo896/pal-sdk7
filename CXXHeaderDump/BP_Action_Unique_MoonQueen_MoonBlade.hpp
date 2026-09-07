#ifndef UE4SS_SDK_BP_Action_Unique_MoonQueen_MoonBlade_HPP
#define UE4SS_SDK_BP_Action_Unique_MoonQueen_MoonBlade_HPP

class UBP_Action_Unique_MoonQueen_MoonBlade_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    TEnumAsByte<EAction_MoonQueenMoonBladeModeType::Type> MoonBladeMode;              // 0x02A0 (size: 0x1)
    FName SocketName;                                                                 // 0x02A4 (size: 0x8)
    double HorizontalOffsetPosition;                                                  // 0x02B0 (size: 0x8)
    bool IsRotating;                                                                  // 0x02B8 (size: 0x1)
    TArray<FReserveMontage> MontageArray;                                             // 0x02C0 (size: 0x10)
    double SelfRotateSpeed;                                                           // 0x02D0 (size: 0x8)
    TArray<FTimerHandle> TimerHandles;                                                // 0x02D8 (size: 0x10)
    int32 NewVar;                                                                     // 0x02E8 (size: 0x4)
    TArray<FName> BladeNames;                                                         // 0x02F0 (size: 0x10)

    void Create Moon Blade(FName BladeName);
    void GetLocationZOffset(FName Name, double& RotationX);
    void GetRotationX(FName Name, double& RotationX);
    void StopMontage();
    void CalcMontageLength(TArray<FReserveMontage>& Montages, double& Length);
    void GetMontageArray(TArray<FReserveMontage>& Motages);
    void SpawnMoonBlade(class ABP_SkillEffect_Unique_MoonQueen_MoonBlade_C*& Instance);
    void OnBeginAction();
    void MoonBladeVertical();
    void MoonBladeHorizontal();
    void OnEndAction();
    void TickAction(float DeltaTime);
    void OnMontageNotify(class UAnimMontage* Montage, FName NotifyName);
    void OnMontageEnd(class UAnimMontage* Montage, bool bInterrupted);
    void ExecuteUbergraph_BP_Action_Unique_MoonQueen_MoonBlade(int32 EntryPoint);
}; // Size: 0x300

#endif
