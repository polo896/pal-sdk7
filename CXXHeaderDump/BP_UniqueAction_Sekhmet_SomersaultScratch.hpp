#ifndef UE4SS_SDK_BP_UniqueAction_Sekhmet_SomersaultScratch_HPP
#define UE4SS_SDK_BP_UniqueAction_Sekhmet_SomersaultScratch_HPP

class UBP_UniqueAction_Sekhmet_SomersaultScratch_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    bool EnableRotate;                                                                // 0x02A0 (size: 0x1)
    bool Moving;                                                                      // 0x02A1 (size: 0x1)
    double MoveTime;                                                                  // 0x02A8 (size: 0x8)
    class UCurveFloat* MoveCurve;                                                     // 0x02B0 (size: 0x8)
    float MoveSpeed;                                                                  // 0x02B8 (size: 0x4)

    void SwitchMoveState(bool EnableMove);
    void OnNotifyEnd_713F230C485A5E4BE0A049958D65196A(FName NotifyName);
    void OnNotifyBegin_713F230C485A5E4BE0A049958D65196A(FName NotifyName);
    void OnInterrupted_713F230C485A5E4BE0A049958D65196A(FName NotifyName);
    void OnBlendOut_713F230C485A5E4BE0A049958D65196A(FName NotifyName);
    void OnCompleted_713F230C485A5E4BE0A049958D65196A(FName NotifyName);
    void OnBeginAction();
    void OnEndAction();
    void TickAction(float DeltaTime);
    void ExecuteUbergraph_BP_UniqueAction_Sekhmet_SomersaultScratch(int32 EntryPoint);
}; // Size: 0x2BC

#endif
