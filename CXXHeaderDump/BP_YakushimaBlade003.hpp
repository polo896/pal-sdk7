#ifndef UE4SS_SDK_BP_YakushimaBlade003_HPP
#define UE4SS_SDK_BP_YakushimaBlade003_HPP

class ABP_YakushimaBlade003_C : public ABP_MeleeWeaponBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0698 (size: 0x8)
    int32 BladeMaxNum;                                                                // 0x06A0 (size: 0x4)
    TArray<class ABP_YakushimaBlade003_Blade_C*> SpawnedBlade;                        // 0x06A8 (size: 0x10)
    TSubclassOf<class APalBullet> BladeClass;                                         // 0x06B8 (size: 0x8)
    int32 SummonMax;                                                                  // 0x06C0 (size: 0x4)

    void PlayShootAnim();
    void CurrentBlades(int32& Array Index);
    FTransform GetBladeSpawnTransform();
    bool IsNeedCheckSummonWeapon();
    void OnAnimNotifyBegin(FName NotifyName);
    void SpawnBlade(bool bForce);
    void OnDestroyBlade(class AActor* DestroyedActor);
    void ReceiveDestroyed();
    void OnStartAim();
    void OnSummonWeapon(int32 SummonCount);
    void ReceiveBeginPlay();
    void ReceiveTick(float DeltaSeconds);
    void ReleaseWeapon();
    void ExecuteUbergraph_BP_YakushimaBlade003(int32 EntryPoint);
}; // Size: 0x6C4

#endif
