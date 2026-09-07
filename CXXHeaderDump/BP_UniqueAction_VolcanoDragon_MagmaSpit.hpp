#ifndef UE4SS_SDK_BP_UniqueAction_VolcanoDragon_MagmaSpit_HPP
#define UE4SS_SDK_BP_UniqueAction_VolcanoDragon_MagmaSpit_HPP

class UBP_UniqueAction_VolcanoDragon_MagmaSpit_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    bool NowAdjusting;                                                                // 0x02A0 (size: 0x1)
    bool ActDirect;                                                                   // 0x02A1 (size: 0x1)
    float SpitInterval;                                                               // 0x02A4 (size: 0x4)
    FTimerHandle SpitTimer;                                                           // 0x02A8 (size: 0x8)
    double RandomBulletRange;                                                         // 0x02B0 (size: 0x8)
    float DirectAdjustAlpha;                                                          // 0x02B8 (size: 0x4)
    TArray<FVector2D> ScaterOffset;                                                   // 0x02C0 (size: 0x10)
    int32 SpitCount;                                                                  // 0x02D0 (size: 0x4)
    bool EnableRotate;                                                                // 0x02D4 (size: 0x1)
    class ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_MagmaManager_C* MagmaManager; // 0x02D8 (size: 0x8)

    void GetMuzzleEffect(class UNiagaraSystem*& Niagara);
    void GetManagerClass(TSubclassOf<class ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_MagmaManager_C>& ManagerClass);
    void GetBulletClass(TSubclassOf<class ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_C>& BulletClass);
    void OnMagmaSpawned(class ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Magma_C* MagmaActor);
    void SpitMagma();
    void OnNotifyEnd_B9F2F461484E222101E73E8D8B6B42B6(FName NotifyName);
    void OnNotifyBegin_B9F2F461484E222101E73E8D8B6B42B6(FName NotifyName);
    void OnInterrupted_B9F2F461484E222101E73E8D8B6B42B6(FName NotifyName);
    void OnBlendOut_B9F2F461484E222101E73E8D8B6B42B6(FName NotifyName);
    void OnCompleted_B9F2F461484E222101E73E8D8B6B42B6(FName NotifyName);
    void OnBeginAction();
    void OnEndAction();
    void TickAction(float DeltaTime);
    void ExecuteUbergraph_BP_UniqueAction_VolcanoDragon_MagmaSpit(int32 EntryPoint);
}; // Size: 0x2E0

#endif
