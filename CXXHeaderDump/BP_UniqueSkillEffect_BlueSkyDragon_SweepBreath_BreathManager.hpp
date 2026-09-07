#ifndef UE4SS_SDK_BP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathManager_HPP
#define UE4SS_SDK_BP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathManager_HPP

class ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathManager_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    FTimerHandle BreathTimer;                                                         // 0x0438 (size: 0x8)
    float AttackInterval;                                                             // 0x0440 (size: 0x4)
    double BulletLife;                                                                // 0x0448 (size: 0x8)
    float ScatterDegree;                                                              // 0x0450 (size: 0x4)

    void SpawnBullet();
    void ReceiveBeginPlay();
    void ReceiveTick(float DeltaSeconds);
    void SetFade();
    void FadeOutEffect(double DeltaSecond);
    void ExecuteUbergraph_BP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathManager(int32 EntryPoint);
}; // Size: 0x454

#endif
