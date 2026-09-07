#ifndef UE4SS_SDK_BP_UniqueAction_ClownRabbit_TrickShow_HPP
#define UE4SS_SDK_BP_UniqueAction_ClownRabbit_TrickShow_HPP

class UBP_UniqueAction_ClownRabbit_TrickShow_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    TArray<FReserveMontage> Montage List;                                             // 0x02A0 (size: 0x10)
    float WarpDelay;                                                                  // 0x02B0 (size: 0x4)
    FTimerHandle CurrentTimer;                                                        // 0x02B8 (size: 0x8)
    float AttackTime;                                                                 // 0x02C0 (size: 0x4)
    FVector OriginalLocation;                                                         // 0x02C8 (size: 0x18)
    double WarpTargetDistance;                                                        // 0x02E0 (size: 0x8)
    bool Returned;                                                                    // 0x02E8 (size: 0x1)
    class UNiagaraSystem* WarpEffect;                                                 // 0x02F0 (size: 0x8)
    TArray<FVector> SpawnLocations;                                                   // 0x02F8 (size: 0x10)
    FVector TrueIndex;                                                                // 0x0308 (size: 0x18)
    int32 Out Index;                                                                  // 0x0320 (size: 0x4)
    bool EnableRotate;                                                                // 0x0324 (size: 0x1)
    TArray<class ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Fake_C*> Fakes;          // 0x0328 (size: 0x10)
    float AttackInterval;                                                             // 0x0338 (size: 0x4)
    FTimerHandle AttackTimer;                                                         // 0x0340 (size: 0x8)
    EVisibilityBasedAnimTickOption OriginalTickOption;                                // 0x0348 (size: 0x1)

    void SpawnBullet();
    void ActAttack();
    void TickAction(float DeltaTime);
    void PatternCheck();
    void ActEndWarp();
    void SwitchHidden(bool Hide);
    void OnNotifyEnd_3D7B0BF047339992BC321DA822C7E04B(FName NotifyName);
    void OnNotifyBegin_3D7B0BF047339992BC321DA822C7E04B(FName NotifyName);
    void OnInterrupted_3D7B0BF047339992BC321DA822C7E04B(FName NotifyName);
    void OnBlendOut_3D7B0BF047339992BC321DA822C7E04B(FName NotifyName);
    void OnCompleted_3D7B0BF047339992BC321DA822C7E04B(FName NotifyName);
    void OnBeginAction();
    void OnEndAction();
    void OnNotifyBegin(class UAnimMontage* Montage, FName NotifyName);
    void OnMontageEnded(class UAnimMontage* Montage, bool bInterrupted);
    void WarpOut();
    void AttackEnd();
    void ExecuteUbergraph_BP_UniqueAction_ClownRabbit_TrickShow(int32 EntryPoint);
}; // Size: 0x349

#endif
