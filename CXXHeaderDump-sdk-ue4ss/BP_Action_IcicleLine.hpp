#ifndef UE4SS_SDK_BP_Action_IcicleLine_HPP
#define UE4SS_SDK_BP_Action_IcicleLine_HPP

class UBP_Action_IcicleLine_C : public UBP_ActionGeneralAttackFarBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x02E8 (size: 0x8)
    float SpawnDistance;                                                              // 0x02F0 (size: 0x4)
    TArray<double> SpawnAngles;                                                       // 0x02F8 (size: 0x10)
    double AngleMultiplier;                                                           // 0x0308 (size: 0x8)

    void PlayProcessAnimation();
    void PlayReadyAnimation();
    void ExecuteUbergraph_BP_Action_IcicleLine(int32 EntryPoint);
}; // Size: 0x310

#endif
