#ifndef UE4SS_SDK_BP_Action_SandTwister_HPP
#define UE4SS_SDK_BP_Action_SandTwister_HPP

class UBP_Action_SandTwister_C : public UBP_ActionGeneralAttackFarBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x02E8 (size: 0x8)

    void OnBreakAction();
    void ExecuteUbergraph_BP_Action_SandTwister(int32 EntryPoint);
}; // Size: 0x2F0

#endif
