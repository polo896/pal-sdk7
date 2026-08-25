#ifndef UE4SS_SDK_BP_Action_Unique_HerculesBeetle_BeetleTackle_HPP
#define UE4SS_SDK_BP_Action_Unique_HerculesBeetle_BeetleTackle_HPP

class UBP_Action_Unique_HerculesBeetle_BeetleTackle_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    double DisableMoveAfterTime;                                                      // 0x02A0 (size: 0x8)
    class UBP_UniqueSkillModule_Tackle_C* TackleModule;                               // 0x02A8 (size: 0x8)

    void OnCompletedEndMontage();
    void OnMontageNotify(class UAnimMontage* Montage, FName NotifyName);
    void OnBeginAction();
    void TickAction(float DeltaTime);
    void OnEndAction();
    void CallEndAttack();
    void OnHitDisableMovement(class AActor* HitActor);
    void OnSpawnedLoopEffect(class ABP_SkillEffectBase_C* LoopEffect);
    void ExecuteUbergraph_BP_Action_Unique_HerculesBeetle_BeetleTackle(int32 EntryPoint);
}; // Size: 0x2B0

#endif
