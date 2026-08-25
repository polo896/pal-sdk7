#ifndef UE4SS_SDK_BP_Action_AirBlade_HPP
#define UE4SS_SDK_BP_Action_AirBlade_HPP

class UBP_Action_AirBlade_C : public UBP_ActionGeneralAttackFarBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x02E8 (size: 0x8)
    double BladeLife;                                                                 // 0x02F0 (size: 0x8)
    double IntervalAngle;                                                             // 0x02F8 (size: 0x8)
    int32 BladeCount;                                                                 // 0x0300 (size: 0x4)

    void OnStartProcessAnimation();
    void ExecuteUbergraph_BP_Action_AirBlade(int32 EntryPoint);
}; // Size: 0x304

#endif
