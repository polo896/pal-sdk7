#ifndef UE4SS_SDK_BP_Action_CommetRain_HPP
#define UE4SS_SDK_BP_Action_CommetRain_HPP

class UBP_Action_CommetRain_C : public UBP_ActionGeneralAttackFarBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x02E8 (size: 0x8)
    float Interval;                                                                   // 0x02F0 (size: 0x4)
    int32 CommetCount;                                                                // 0x02F4 (size: 0x4)
    int32 MaxCommetCount;                                                             // 0x02F8 (size: 0x4)
    float OffsetDistance;                                                             // 0x02FC (size: 0x4)
    FTimerHandle Timer;                                                               // 0x0300 (size: 0x8)
    FVector TargetLocation;                                                           // 0x0308 (size: 0x18)

    void OnStartProcessAnimation();
    void CreateCommet();
    void OnEndAction();
    void OnSpawnEffect(class APalSkillEffectBase* Effect);
    void ExecuteUbergraph_BP_Action_CommetRain(int32 EntryPoint);
}; // Size: 0x320

#endif
