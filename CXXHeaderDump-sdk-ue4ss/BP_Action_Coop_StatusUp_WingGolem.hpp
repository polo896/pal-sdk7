#ifndef UE4SS_SDK_BP_Action_Coop_StatusUp_WingGolem_HPP
#define UE4SS_SDK_BP_Action_Coop_StatusUp_WingGolem_HPP

class UBP_Action_Coop_StatusUp_WingGolem_C : public UPalActionBase
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0160 (size: 0x8)

    void OnNotifyEnd_8ADC6761450164B9114AB8B7179E804C(FName NotifyName);
    void OnNotifyBegin_8ADC6761450164B9114AB8B7179E804C(FName NotifyName);
    void OnInterrupted_8ADC6761450164B9114AB8B7179E804C(FName NotifyName);
    void OnBlendOut_8ADC6761450164B9114AB8B7179E804C(FName NotifyName);
    void OnCompleted_8ADC6761450164B9114AB8B7179E804C(FName NotifyName);
    void OnBeginAction();
    void OnEndAction();
    void ExecuteUbergraph_BP_Action_Coop_StatusUp_WingGolem(int32 EntryPoint);
}; // Size: 0x168

#endif
