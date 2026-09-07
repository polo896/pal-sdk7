#ifndef UE4SS_SDK_BP_UniqueAction_BlueSkyDragon_SweepBreath_HPP
#define UE4SS_SDK_BP_UniqueAction_BlueSkyDragon_SweepBreath_HPP

class UBP_UniqueAction_BlueSkyDragon_SweepBreath_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    bool EnableRotate;                                                                // 0x02A0 (size: 0x1)
    bool RotateReturn;                                                                // 0x02A1 (size: 0x1)
    class ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathManager_C* BreathManager; // 0x02A8 (size: 0x8)
    bool EnableHeightAdjust;                                                          // 0x02B0 (size: 0x1)
    double HeightAdjustSpeed;                                                         // 0x02B8 (size: 0x8)
    double AccHeight;                                                                 // 0x02C0 (size: 0x8)
    FVector OriginalLocation;                                                         // 0x02C8 (size: 0x18)

    void GetRotation(double DeltaTime, bool NoInterp, FRotator& Rotation);
    void TickAction(float DeltaTime);
    void OnNotifyEnd_B748556441A2BBC880E05EA4DE81F2C1(FName NotifyName);
    void OnNotifyBegin_B748556441A2BBC880E05EA4DE81F2C1(FName NotifyName);
    void OnInterrupted_B748556441A2BBC880E05EA4DE81F2C1(FName NotifyName);
    void OnBlendOut_B748556441A2BBC880E05EA4DE81F2C1(FName NotifyName);
    void OnCompleted_B748556441A2BBC880E05EA4DE81F2C1(FName NotifyName);
    void OnBeginAction();
    void OnEndAction();
    void ExecuteUbergraph_BP_UniqueAction_BlueSkyDragon_SweepBreath(int32 EntryPoint);
}; // Size: 0x2E0

#endif
