#ifndef UE4SS_SDK_BP_UniqueAction_BlueSkyDragon_DrainStorm_HPP
#define UE4SS_SDK_BP_UniqueAction_BlueSkyDragon_DrainStorm_HPP

class UBP_UniqueAction_BlueSkyDragon_DrainStorm_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    TArray<FReserveMontage> Montage List;                                             // 0x02A0 (size: 0x10)
    class ABP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_C* StormEffect;        // 0x02B0 (size: 0x8)
    float PullTime;                                                                   // 0x02B8 (size: 0x4)

    void OnBeginAction();
    void OnEndAction();
    void OnMontageEnd(class UAnimMontage* Montage, bool bInterrupted);
    void OnMontageNotify(class UAnimMontage* Montage, FName NotifyName);
    void ExecuteUbergraph_BP_UniqueAction_BlueSkyDragon_DrainStorm(int32 EntryPoint);
}; // Size: 0x2BC

#endif
