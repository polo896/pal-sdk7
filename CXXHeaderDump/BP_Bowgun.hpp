#ifndef UE4SS_SDK_BP_Bowgun_HPP
#define UE4SS_SDK_BP_Bowgun_HPP

class ABP_Bowgun_C : public ABP_AssaultRifleBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x06C8 (size: 0x8)
    class UChildActorComponent* BP_RightHandChildArrow;                               // 0x06D0 (size: 0x8)
    class USkeletalMeshComponent* Weapon;                                             // 0x06D8 (size: 0x8)
    class UNiagaraSystem* MuzzleEffect;                                               // 0x06E0 (size: 0x8)
    bool TestPull;                                                                    // 0x06E8 (size: 0x1)

    void PlayReloadSound();
    void PlayFireSound();
    float GetDefaultBlurAngle();
    void ShootArrowInternal(bool& IsShoted);
    void ShootArrow();
    void ShootBullet();
    FTransform GetLeftHandTransform();
    void Is UseEjectionPort(bool& isUse);
    void GeyEjectionPortTransform(FTransform& Transform);
    void GetShotAnimation();
    bool IsUseLeftHandAttach();
    void OnShoot(class APalBullet* BulletActor);
    void GetMuzzleRotator(FRotator& Rotator);
    void GetShootInterval(double& Time);
    void GetMuzzleLocation(FVector& MuzzleLocation);
    FName GetEquipSocketName();
    void HiddenWeaponSubPart(bool isHidden);
    void ReceiveBeginPlay();
    void OnPullTrigger();
    void OnReloadStart(float InReloadSpeedPlayRate);
    void OnAttachWeapon(class AActor* attachActor);
    void OnDetachWeapon(class AActor* detachActor);
    void OnWeaponNotify(EWeaponNotifyType Type);
    void StopReloadWhenRoll(const class UPalActionBase* action);
    void OnNotify(TEnumAsByte<E_PalWeaponAnimationNotify::Type> Notify);
    void ExecuteUbergraph_BP_Bowgun(int32 EntryPoint);
}; // Size: 0x6E9

#endif
