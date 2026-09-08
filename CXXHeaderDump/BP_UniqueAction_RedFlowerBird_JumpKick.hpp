#ifndef UE4SS_SDK_BP_UniqueAction_RedFlowerBird_JumpKick_HPP
#define UE4SS_SDK_BP_UniqueAction_RedFlowerBird_JumpKick_HPP

class UBP_UniqueAction_RedFlowerBird_JumpKick_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    bool EnableMove;                                                                  // 0x02A0 (size: 0x1)
    double MoveSpeed;                                                                 // 0x02A8 (size: 0x8)
    FVector CurrentDirect;                                                            // 0x02B0 (size: 0x18)

    void Switch Move State(bool EnableMove);
    void OnNotifyEnd_CBEDBCF5417DAF8DD25D2D8309D267DA(FName NotifyName);
    void OnNotifyBegin_CBEDBCF5417DAF8DD25D2D8309D267DA(FName NotifyName);
    void OnInterrupted_CBEDBCF5417DAF8DD25D2D8309D267DA(FName NotifyName);
    void OnBlendOut_CBEDBCF5417DAF8DD25D2D8309D267DA(FName NotifyName);
    void OnCompleted_CBEDBCF5417DAF8DD25D2D8309D267DA(FName NotifyName);
    void OnBeginAction();
    void OnEndAction();
    void TickAction(float DeltaTime);
    void ExecuteUbergraph_BP_UniqueAction_RedFlowerBird_JumpKick(int32 EntryPoint);
}; // Size: 0x2C8

#endif
