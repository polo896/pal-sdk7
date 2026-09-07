#ifndef UE4SS_SDK_BP_SkillEffect_WindCutterShot_HPP
#define UE4SS_SDK_BP_SkillEffect_WindCutterShot_HPP

class ABP_SkillEffect_WindCutterShot_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UNiagaraComponent* NS_WindCutterShoot;                                      // 0x0438 (size: 0x8)
    double ShootIntervalTime;                                                         // 0x0440 (size: 0x8)
    FTimerHandle TimeHandle;                                                          // 0x0448 (size: 0x8)
    TSubclassOf<class AActor> BulletClass;                                            // 0x0450 (size: 0x8)
    FBP_SkillEffect_WindCutterShot_COnSpawnBulletDelegate OnSpawnBulletDelegate;      // 0x0458 (size: 0x10)
    void OnSpawnBulletDelegate(class AActor* Bullet);

    void SetTargetLocation(FVector TargetLocation);
    void ReceiveBeginPlay();
    void Shoot();
    void ReceiveEndPlay(TEnumAsByte<EEndPlayReason::Type> EndPlayReason);
    void ExecuteUbergraph_BP_SkillEffect_WindCutterShot(int32 EntryPoint);
    void OnSpawnBulletDelegate__DelegateSignature(class AActor* Bullet);
}; // Size: 0x468

#endif
