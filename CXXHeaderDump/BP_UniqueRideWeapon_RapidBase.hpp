#ifndef UE4SS_SDK_BP_UniqueRideWeapon_RapidBase_HPP
#define UE4SS_SDK_BP_UniqueRideWeapon_RapidBase_HPP

class ABP_UniqueRideWeapon_RapidBase_C : public APalUniqueRideWeaponBase
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x06B8 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x06C0 (size: 0x8)
    FTimerHandle ShootHandle;                                                         // 0x06C8 (size: 0x8)

    void GetShootInterval(double& Time);
    void ShootBulletBP();
    void OnPullTrigger();
    void OnReleaseTrigger(bool bCanShootOnRelease);
    void ExecuteUbergraph_BP_UniqueRideWeapon_RapidBase(int32 EntryPoint);
}; // Size: 0x6D0

#endif
