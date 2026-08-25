#ifndef UE4SS_SDK_BP_ActionUnique_GrassRabbitMan_GrassRoundKick_HPP
#define UE4SS_SDK_BP_ActionUnique_GrassRabbitMan_GrassRoundKick_HPP

class UBP_ActionUnique_GrassRabbitMan_GrassRoundKick_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    bool NowTackling;                                                                 // 0x02A0 (size: 0x1)
    double MinPreserveDistance;                                                       // 0x02A8 (size: 0x8)
    float HomingStrength;                                                             // 0x02B0 (size: 0x4)

    void TickAction(float DeltaTime);
    void OnNotifyEnd_EC4CD4594378DFB0ED19A690C3140A7D(FName NotifyName);
    void OnNotifyBegin_EC4CD4594378DFB0ED19A690C3140A7D(FName NotifyName);
    void OnInterrupted_EC4CD4594378DFB0ED19A690C3140A7D(FName NotifyName);
    void OnBlendOut_EC4CD4594378DFB0ED19A690C3140A7D(FName NotifyName);
    void OnCompleted_EC4CD4594378DFB0ED19A690C3140A7D(FName NotifyName);
    void OnBeginAction();
    void ExecuteUbergraph_BP_ActionUnique_GrassRabbitMan_GrassRoundKick(int32 EntryPoint);
}; // Size: 0x2B4

#endif
