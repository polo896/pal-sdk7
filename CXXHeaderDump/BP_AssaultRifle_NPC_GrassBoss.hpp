#ifndef UE4SS_SDK_BP_AssaultRifle_NPC_GrassBoss_HPP
#define UE4SS_SDK_BP_AssaultRifle_NPC_GrassBoss_HPP

class ABP_AssaultRifle_NPC_GrassBoss_C : public ABP_AssaultRifleBase_C
{
    class USkeletalMeshComponent* SkeletalMesh;                                       // 0x06C8 (size: 0x8)
    FBP_AssaultRifle_NPC_GrassBoss_COnShootDelegate OnShootDelegate;                  // 0x06D0 (size: 0x10)
    void OnShootDelegate();

    float GetDefaultBlurAngle();
    int32 GetNPCWeaponDamage();
    void GetMuzzleEffect(class UNiagaraSystem*& NewParam);
    FTransform GetLeftHandTransform();
    bool IsUseLeftHandAttach();
    void OnShoot(class APalBullet* BulletActor);
    void GetBulletClass(TSubclassOf<class APalBullet>& NewParam);
    void GetShootInterval(double& Time);
    void GetMuzzleRotator(FRotator& Rotator);
    void GetMuzzleLocation(FVector& MuzzleLocation);
    int32 GetWeaponDamage();
    void OnShootDelegate__DelegateSignature();
}; // Size: 0x6E0

#endif
