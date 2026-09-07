#ifndef UE4SS_SDK_BP_WidePenetrateShotgun_HPP
#define UE4SS_SDK_BP_WidePenetrateShotgun_HPP

class ABP_WidePenetrateShotgun_C : public ABP_ShotgunBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x06C8 (size: 0x8)
    FTimerHandle ShootingHandle;                                                      // 0x06D0 (size: 0x8)

    void PlayShootAnim();
    void OnShot();
    void OnPullTrigger();
    void OnReleaseTrigger(bool bCanShootOnRelease);
    void OnReloadStart(float InReloadSpeedPlayRate);
    void OnDetachWeapon(class AActor* detachActor);
    void ReceiveEndPlay(TEnumAsByte<EEndPlayReason::Type> EndPlayReason);
    void ExecuteUbergraph_BP_WidePenetrateShotgun(int32 EntryPoint);
}; // Size: 0x6D8

#endif
