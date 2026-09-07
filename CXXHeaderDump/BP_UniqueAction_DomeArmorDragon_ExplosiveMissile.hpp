#ifndef UE4SS_SDK_BP_UniqueAction_DomeArmorDragon_ExplosiveMissile_HPP
#define UE4SS_SDK_BP_UniqueAction_DomeArmorDragon_ExplosiveMissile_HPP

class UBP_UniqueAction_DomeArmorDragon_ExplosiveMissile_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    TArray<FReserveMontage> Montage List;                                             // 0x02A0 (size: 0x10)
    int32 FireCount;                                                                  // 0x02B0 (size: 0x4)
    int32 MaxFireCount;                                                               // 0x02B4 (size: 0x4)
    bool EnableRotate;                                                                // 0x02B8 (size: 0x1)
    bool Aiming;                                                                      // 0x02B9 (size: 0x1)
    float BlendAlpha;                                                                 // 0x02BC (size: 0x4)

    void TickAction(float DeltaTime);
    void Fire(int32 Index);
    void OnNotifyEnd_0CD8850C48FAA04E75AC14A2232309E8(FName NotifyName);
    void OnNotifyBegin_0CD8850C48FAA04E75AC14A2232309E8(FName NotifyName);
    void OnInterrupted_0CD8850C48FAA04E75AC14A2232309E8(FName NotifyName);
    void OnBlendOut_0CD8850C48FAA04E75AC14A2232309E8(FName NotifyName);
    void OnCompleted_0CD8850C48FAA04E75AC14A2232309E8(FName NotifyName);
    void OnBeginAction();
    void OnEndAction();
    void OnMontageNotify(class UAnimMontage* Montage, FName NotifyName);
    void ActEnd();
    void ExecuteUbergraph_BP_UniqueAction_DomeArmorDragon_ExplosiveMissile(int32 EntryPoint);
}; // Size: 0x2C0

#endif
