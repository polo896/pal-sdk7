#ifndef UE4SS_SDK_BP_Action_PartnerSkill_Ronin_Iai_HPP
#define UE4SS_SDK_BP_Action_PartnerSkill_Ronin_Iai_HPP

class UBP_Action_PartnerSkill_Ronin_Iai_C : public UBP_ActionUniqueAttackBase_C
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
    void OnNotifyEnd_59DBB1C944EF70209D3291880D983E91(FName NotifyName);
    void OnNotifyBegin_59DBB1C944EF70209D3291880D983E91(FName NotifyName);
    void OnInterrupted_59DBB1C944EF70209D3291880D983E91(FName NotifyName);
    void OnBlendOut_59DBB1C944EF70209D3291880D983E91(FName NotifyName);
    void OnCompleted_59DBB1C944EF70209D3291880D983E91(FName NotifyName);
    void OnNotifyEnd_6EEB38E144708BDB705A6C865FC0A8E0(FName NotifyName);
    void OnNotifyBegin_6EEB38E144708BDB705A6C865FC0A8E0(FName NotifyName);
    void OnInterrupted_6EEB38E144708BDB705A6C865FC0A8E0(FName NotifyName);
    void OnBlendOut_6EEB38E144708BDB705A6C865FC0A8E0(FName NotifyName);
    void OnCompleted_6EEB38E144708BDB705A6C865FC0A8E0(FName NotifyName);
    void Attack();
    void OnBeginAction();
    void OnEndAction();
    void TickAction(float DeltaTime);
    void ExecuteUbergraph_BP_Action_PartnerSkill_Ronin_Iai(int32 EntryPoint);
}; // Size: 0x2E0

#endif
