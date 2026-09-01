#ifndef UE4SS_SDK_BP_UniqueAction_Mothman_SporeScatter_HPP
#define UE4SS_SDK_BP_UniqueAction_Mothman_SporeScatter_HPP

class UBP_UniqueAction_Mothman_SporeScatter_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    FTimerHandle CurrentTimer;                                                        // 0x02A0 (size: 0x8)
    TArray<FReserveMontage> Montage List;                                             // 0x02A8 (size: 0x10)
    float ChargeTime;                                                                 // 0x02B8 (size: 0x4)
    float ScatterTime;                                                                // 0x02BC (size: 0x4)
    bool Moving;                                                                      // 0x02C0 (size: 0x1)
    class ABP_UniqueSkillEffect_Mothman_SporeScatter_Charge_C* ChargeEffect;          // 0x02C8 (size: 0x8)
    FVector TargetLocation;                                                           // 0x02D0 (size: 0x18)
    FTimerHandle ScatterTimer;                                                        // 0x02E8 (size: 0x8)
    int32 MaxSporeCount;                                                              // 0x02F0 (size: 0x4)
    int32 ExplosionCount;                                                             // 0x02F4 (size: 0x4)
    double MaxScatterRadius;                                                          // 0x02F8 (size: 0x8)
    int32 CurrentSporeCount;                                                          // 0x0300 (size: 0x4)
    int32 ScatterPerCall;                                                             // 0x0304 (size: 0x4)
    TArray<ABP_UniqueSkillEffect_Mothman_SporeScatter_Spore_C*> Spores;               // 0x0308 (size: 0x10)
    TArray<FVector> RandomPoints;                                                     // 0x0318 (size: 0x10)
    int32 DirectIndex;                                                                // 0x0328 (size: 0x4)
    FTimerHandle DetonateTimer;                                                       // 0x0330 (size: 0x8)

    void Detonate();
    void Scatter();
    void TickAction(float DeltaTime);
    void OnNotifyEnd_14384D3A41C543277A1D5691E249D0DE(FName NotifyName);
    void OnNotifyBegin_14384D3A41C543277A1D5691E249D0DE(FName NotifyName);
    void OnInterrupted_14384D3A41C543277A1D5691E249D0DE(FName NotifyName);
    void OnBlendOut_14384D3A41C543277A1D5691E249D0DE(FName NotifyName);
    void OnCompleted_14384D3A41C543277A1D5691E249D0DE(FName NotifyName);
    void OnBeginAction();
    void OnEndAction();
    void Act();
    void ActEnd();
    void OnNotifyBegin(class UAnimMontage* Montage, FName NotifyName);
    void ExecuteUbergraph_BP_UniqueAction_Mothman_SporeScatter(int32 EntryPoint);
}; // Size: 0x338

#endif
