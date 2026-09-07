#ifndef UE4SS_SDK_BP_Action_Unique_IceHorse_IceBladeAttack_New_HPP
#define UE4SS_SDK_BP_Action_Unique_IceHorse_IceBladeAttack_New_HPP

class UBP_Action_Unique_IceHorse_IceBladeAttack_New_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    class UPalSkillModule_HorseTackle* TackleModule;                                  // 0x02A0 (size: 0x8)
    class ABP_SkillEffectBase_C* SkillEffect_Loop;                                    // 0x02A8 (size: 0x8)
    FTimerHandle EffectEndTimerHandle;                                                // 0x02B0 (size: 0x8)
    TArray<FName> SocketOffsetMap;                                                    // 0x02B8 (size: 0x10)

    void SearchEnemyCharacter(class AActor*& OutActor);
    void ActSpecialAttack();
    void OnBeginAction();
    void TickAction(float DeltaTime);
    void OnCompletedEndMontage();
    void OnEndAction();
    void OnEndAttack();
    void OnEndSkillEffect();
    void OnSpawnedLoopEffect(class APalSkillEffectBase* LoopEffect);
    void OnMontageNotify(class UAnimMontage* Montage, FName NotifyName);
    void ExecuteUbergraph_BP_Action_Unique_IceHorse_IceBladeAttack_New(int32 EntryPoint);
}; // Size: 0x2C8

#endif
