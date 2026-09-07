#ifndef UE4SS_SDK_BP_Action_Unique_NightLady_NightmareFlame_HPP
#define UE4SS_SDK_BP_Action_Unique_NightLady_NightmareFlame_HPP

class UBP_Action_Unique_NightLady_NightmareFlame_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    TArray<FReserveMontage> Montage List;                                             // 0x02A0 (size: 0x10)
    FTimerHandle LaunchFlameTimer;                                                    // 0x02B0 (size: 0x8)
    int32 FlameCount;                                                                 // 0x02B8 (size: 0x4)
    float EnemySearchDistance;                                                        // 0x02BC (size: 0x4)
    float FlameLaunchInterval;                                                        // 0x02C0 (size: 0x4)
    int32 MaxFlameCount;                                                              // 0x02C4 (size: 0x4)

    void GetActorRootLocationZ(class AActor* Actor, double& LocationZ);
    void OnMontageNotify(class UAnimMontage* Montage, FName NotifyName);
    void CreateHommingFlame();
    void OnBeginAction();
    void OnMontageEnd(class UAnimMontage* Montage, bool bInterrupted);
    void OnEndAction();
    void ExecuteUbergraph_BP_Action_Unique_NightLady_NightmareFlame(int32 EntryPoint);
}; // Size: 0x2C8

#endif
