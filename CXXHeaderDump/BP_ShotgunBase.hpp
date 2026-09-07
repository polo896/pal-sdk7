#ifndef UE4SS_SDK_BP_ShotgunBase_HPP
#define UE4SS_SDK_BP_ShotgunBase_HPP

class ABP_ShotgunBase_C : public APalWeaponBase
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0688 (size: 0x8)
    class USkeletalMeshComponent* Weapon;                                             // 0x0690 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x0698 (size: 0x8)
    double ShotInterval;                                                              // 0x06A0 (size: 0x8)
    double ScatteredAngle;                                                            // 0x06A8 (size: 0x8)
    bool CanShootFlag;                                                                // 0x06B0 (size: 0x1)
    bool DirectionForReticle;                                                         // 0x06B1 (size: 0x1)
    bool IsIntervalTimeEnded;                                                         // 0x06B2 (size: 0x1)
    class UNiagaraSystem* MuzzleEffect;                                               // 0x06B8 (size: 0x8)
    int32 Max Bullets;                                                                // 0x06C0 (size: 0x4)

    void PlayEquipAnim();
    void PlayShootAnim();
    float GetDefaultBlurAngle();
    void PlayFireSound();
    float CalcRange();
    float CalcAccuracy();
    float CalcDPS();
    void OnshotInternal(bool& IsShoted);
    void GetEjectionPort(FTransform& EjectionTransform);
    FTransform GetLeftHandTransform();
    void GetTargetPosition(FVector& TargetLocation);
    void GetShootTransformList(double BaseAngle, double BlurAngle, int32 MaxBullets, TArray<FTransform>& ShootTransformList);
    bool IsUseLeftHandAttach();
    FName GetEquipSocketName();
    void GetMuzzleTransform(FTransform& Transform);
    void OnShot();
    void CanShoot(bool& can);
    void OnPullTrigger();
    void OnReleaseTrigger(bool bCanShootOnRelease);
    void CountShotInterval();
    void ShootIntervalEvent();
    void OnAttachWeapon(class AActor* attachActor);
    void StopReloadWhenRoll(const class UPalActionBase* action);
    void OnDetachWeapon(class AActor* detachActor);
    void ExecuteUbergraph_BP_ShotgunBase(int32 EntryPoint);
}; // Size: 0x6C4

#endif
