#ifndef UE4SS_SDK_BP_SkillEffect_IceMissile_HPP
#define UE4SS_SDK_BP_SkillEffect_IceMissile_HPP

class ABP_SkillEffect_IceMissile_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    int32 ShootIceNum;                                                                // 0x0438 (size: 0x4)
    double ShootDegree;                                                               // 0x0440 (size: 0x8)
    double ShootInterval;                                                             // 0x0448 (size: 0x8)
    bool IsShootStarted;                                                              // 0x0450 (size: 0x1)
    double Timer;                                                                     // 0x0458 (size: 0x8)
    int32 Count;                                                                      // 0x0460 (size: 0x4)
    class AActor* Target;                                                             // 0x0468 (size: 0x8)
    double ShootSpeed;                                                                // 0x0470 (size: 0x8)
    TArray<class ABP_SkillEffect_IceMissile_Bullet_C*> SpawnedBullet;                 // 0x0478 (size: 0x10)
    FBP_SkillEffect_IceMissile_COnSpawnedChildEffect OnSpawnedChildEffect;            // 0x0488 (size: 0x10)
    void OnSpawnedChildEffect();

    void ShootProcess(double DeltaTime);
    void ReceiveTick(float DeltaSeconds);
    void OnInitialize();
    void ExecuteUbergraph_BP_SkillEffect_IceMissile(int32 EntryPoint);
    void OnSpawnedChildEffect__DelegateSignature();
}; // Size: 0x498

#endif
