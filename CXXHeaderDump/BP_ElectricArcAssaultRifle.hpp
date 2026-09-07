#ifndef UE4SS_SDK_BP_ElectricArcAssaultRifle_HPP
#define UE4SS_SDK_BP_ElectricArcAssaultRifle_HPP

class ABP_ElectricArcAssaultRifle_C : public ABP_NormalRifle_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0710 (size: 0x8)

    void GetAmmoClass(TSubclassOf<class AActor>& AmmoClass);
    void GetMuzzleEffectAttached(class UNiagaraSystem*& Effect);
    void GetMuzzleEffectParticle(class UParticleSystem*& Particle System);
    void GetMuzzleEffect(class UNiagaraSystem*& NewParam);
    void StopWeaponAnim();
    void OnNotifyEnd_31BE164E46A644E12F45EA90D6A6FA2D(FName NotifyName);
    void OnNotifyBegin_31BE164E46A644E12F45EA90D6A6FA2D(FName NotifyName);
    void OnInterrupted_31BE164E46A644E12F45EA90D6A6FA2D(FName NotifyName);
    void OnBlendOut_31BE164E46A644E12F45EA90D6A6FA2D(FName NotifyName);
    void OnCompleted_31BE164E46A644E12F45EA90D6A6FA2D(FName NotifyName);
    void OnReleaseTrigger(bool bCanShootOnRelease);
    void OnShoot(class APalBullet* BulletActor);
    void OnReloadStart(float InReloadSpeedPlayRate);
    void ExecuteUbergraph_BP_ElectricArcAssaultRifle(int32 EntryPoint);
}; // Size: 0x718

#endif
