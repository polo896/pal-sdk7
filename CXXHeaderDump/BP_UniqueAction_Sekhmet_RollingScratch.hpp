#ifndef UE4SS_SDK_BP_UniqueAction_Sekhmet_RollingScratch_HPP
#define UE4SS_SDK_BP_UniqueAction_Sekhmet_RollingScratch_HPP

class UBP_UniqueAction_Sekhmet_RollingScratch_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    TArray<FReserveMontage> Montage List;                                             // 0x02A0 (size: 0x10)
    double MaxMoveTime;                                                               // 0x02B0 (size: 0x8)
    FTimerHandle MoveEndTimer;                                                        // 0x02B8 (size: 0x8)
    bool Moving;                                                                      // 0x02C0 (size: 0x1)
    bool EnableRotate;                                                                // 0x02C1 (size: 0x1)
    double MoveSpeed;                                                                 // 0x02C8 (size: 0x8)
    double MoveTime;                                                                  // 0x02D0 (size: 0x8)
    double CurrentMoveTime;                                                           // 0x02D8 (size: 0x8)
    FVector OriginalLocation;                                                         // 0x02E0 (size: 0x18)
    class UCurveFloat* CurveMoveYAxis;                                                // 0x02F8 (size: 0x8)
    FVector OriginalRelativeLocation;                                                 // 0x0300 (size: 0x18)
    bool AttackMove;                                                                  // 0x0318 (size: 0x1)

    void TickAction(float DeltaTime);
    void SwitchMoveState(bool EnableMove);
    void OnNotifyEnd_2C19DA884F70A8DC8007E59838536646(FName NotifyName);
    void OnNotifyBegin_2C19DA884F70A8DC8007E59838536646(FName NotifyName);
    void OnInterrupted_2C19DA884F70A8DC8007E59838536646(FName NotifyName);
    void OnBlendOut_2C19DA884F70A8DC8007E59838536646(FName NotifyName);
    void OnCompleted_2C19DA884F70A8DC8007E59838536646(FName NotifyName);
    void OnBeginAction();
    void OnEndAction();
    void ActEndAttack();
    void OnNotifyBegin(class UAnimMontage* Montage, FName NotifyName);
    void ExecuteUbergraph_BP_UniqueAction_Sekhmet_RollingScratch(int32 EntryPoint);
}; // Size: 0x319

#endif
