#ifndef UE4SS_SDK_BP_UniqueAction_Mothman_GiantSpore_HPP
#define UE4SS_SDK_BP_UniqueAction_Mothman_GiantSpore_HPP

class UBP_UniqueAction_Mothman_GiantSpore_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    TArray<FReserveMontage> Montage List;                                             // 0x02A0 (size: 0x10)
    FTimerHandle CurrentTimer;                                                        // 0x02B0 (size: 0x8)
    float ChargeTime;                                                                 // 0x02B8 (size: 0x4)
    bool EnableRotate;                                                                // 0x02BC (size: 0x1)
    class ABP_UniqueSkillEffect_Mothman_GiantSpore_Spore_C* SporeEffect;              // 0x02C0 (size: 0x8)

    void TickAction(float DeltaTime);
    void OnNotifyEnd_760FDD04434D7E9442D03C85A69DB20B(FName NotifyName);
    void OnNotifyBegin_760FDD04434D7E9442D03C85A69DB20B(FName NotifyName);
    void OnInterrupted_760FDD04434D7E9442D03C85A69DB20B(FName NotifyName);
    void OnBlendOut_760FDD04434D7E9442D03C85A69DB20B(FName NotifyName);
    void OnCompleted_760FDD04434D7E9442D03C85A69DB20B(FName NotifyName);
    void OnBeginAction();
    void OnEndAction();
    void Act();
    void ActEnd();
    void OnMontageEnd(class UAnimMontage* Montage, bool bInterrupted);
    void ExecuteUbergraph_BP_UniqueAction_Mothman_GiantSpore(int32 EntryPoint);
}; // Size: 0x2C8

#endif
