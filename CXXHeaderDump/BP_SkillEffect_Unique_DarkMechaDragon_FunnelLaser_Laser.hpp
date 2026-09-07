#ifndef UE4SS_SDK_BP_SkillEffect_Unique_DarkMechaDragon_FunnelLaser_Laser_HPP
#define UE4SS_SDK_BP_SkillEffect_Unique_DarkMechaDragon_FunnelLaser_Laser_HPP

class ABP_SkillEffect_Unique_DarkMechaDragon_FunnelLaser_Laser_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class USceneComponent* LaserRoot;                                                 // 0x0438 (size: 0x8)
    class UCapsuleComponent* Capsule;                                                 // 0x0440 (size: 0x8)
    class UNiagaraComponent* Niagara_Funnel;                                          // 0x0448 (size: 0x8)
    class USceneComponent* View;                                                      // 0x0450 (size: 0x8)
    double UntilFadeTime;                                                             // 0x0458 (size: 0x8)
    double DelayLaser;                                                                // 0x0460 (size: 0x8)
    double InterpSpeed;                                                               // 0x0468 (size: 0x8)
    class UCurveVector* CurveVector;                                                  // 0x0470 (size: 0x8)
    bool EnableYHoming;                                                               // 0x0478 (size: 0x1)
    FVector2D HomingLocationYRange;                                                   // 0x0480 (size: 0x10)
    bool IsSpawnedLaser;                                                              // 0x0490 (size: 0x1)
    double CurveVectorTimer;                                                          // 0x0498 (size: 0x8)
    class UNiagaraComponent* Niagara_Laser;                                           // 0x04A0 (size: 0x8)
    double ScaleCache;                                                                // 0x04A8 (size: 0x8)

    void GetTargetLocation_Override(FVector& Location);
    void ReceiveBeginPlay();
    void OnLifeTime();
    void FadeOutEffect(double DeltaSecond);
    void SpawnLaser();
    void ReceiveTick(float DeltaSeconds);
    void SetScale(double Scale);
    void ExecuteUbergraph_BP_SkillEffect_Unique_DarkMechaDragon_FunnelLaser_Laser(int32 EntryPoint);
}; // Size: 0x4B0

#endif
