#ifndef UE4SS_SDK_BP_Action_UniqueSkill_Ronin_Iai_HPP
#define UE4SS_SDK_BP_Action_UniqueSkill_Ronin_Iai_HPP

class UBP_Action_UniqueSkill_Ronin_Iai_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    FTimerHandle TimeHandle;                                                          // 0x02A0 (size: 0x8)
    bool HasStartedAttack;                                                            // 0x02A8 (size: 0x1)
    double AttackMoveRate;                                                            // 0x02B0 (size: 0x8)
    double DistanceFromTeleportEndToTarget;                                           // 0x02B8 (size: 0x8)
    float TeleportEndDegreeFromCameraView;                                            // 0x02C0 (size: 0x4)
    FVector PreTargetLocation;                                                        // 0x02C8 (size: 0x18)

    void GetUniqueActionTarget(class AActor*& TargetActor);
    void SetPalMoveState(bool isDisable);
    void OnNotifyEnd_DC63DA2F428FC4018668BB9B92E626E6(FName NotifyName);
    void OnNotifyBegin_DC63DA2F428FC4018668BB9B92E626E6(FName NotifyName);
    void OnInterrupted_DC63DA2F428FC4018668BB9B92E626E6(FName NotifyName);
    void OnBlendOut_DC63DA2F428FC4018668BB9B92E626E6(FName NotifyName);
    void OnCompleted_DC63DA2F428FC4018668BB9B92E626E6(FName NotifyName);
    void OnNotifyEnd_732CA01643E23EB854BEF392184417D7(FName NotifyName);
    void OnNotifyBegin_732CA01643E23EB854BEF392184417D7(FName NotifyName);
    void OnInterrupted_732CA01643E23EB854BEF392184417D7(FName NotifyName);
    void OnBlendOut_732CA01643E23EB854BEF392184417D7(FName NotifyName);
    void OnCompleted_732CA01643E23EB854BEF392184417D7(FName NotifyName);
    void Attack();
    void OnBeginAction();
    void OnEndAction();
    void TickAction(float DeltaTime);
    void ExecuteUbergraph_BP_Action_UniqueSkill_Ronin_Iai(int32 EntryPoint);
}; // Size: 0x2E0

#endif
