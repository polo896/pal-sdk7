#ifndef UE4SS_SDK_BP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathBullet_HPP
#define UE4SS_SDK_BP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathBullet_HPP

class ABP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathBullet_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class USphereComponent* Sphere;                                                   // 0x0438 (size: 0x8)
    class UPalProjectileMovementComponent* PalProjectileMovement;                     // 0x0440 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0448 (size: 0x8)
    double CurrentSize;                                                               // 0x0450 (size: 0x8)
    FVector AdjustNormal;                                                             // 0x0458 (size: 0x18)
    double CurrentSpeed;                                                              // 0x0470 (size: 0x8)
    double AdjustStrengthWeight;                                                      // 0x0478 (size: 0x8)
    bool Turn;                                                                        // 0x0480 (size: 0x1)
    double EnlargeSpeed;                                                              // 0x0488 (size: 0x8)
    float OriginalRadius;                                                             // 0x0490 (size: 0x4)
    float AdjustStrength;                                                             // 0x0494 (size: 0x4)
    double MinSpeed;                                                                  // 0x0498 (size: 0x8)

    void SetDirectAndLife(FVector Direct, double Life, FVector CenterDirect);
    void ReceiveTick(float DeltaSeconds);
    void EndLife();
    void FadeOutEffect(double DeltaSecond);
    void ExecuteUbergraph_BP_UniqueSkillEffect_BlueSkyDragon_SweepBreath_BreathBullet(int32 EntryPoint);
}; // Size: 0x4A0

#endif
