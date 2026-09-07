#ifndef UE4SS_SDK_BP_SkillEffect_Unique_MoonQueen_MoonBlade_HPP
#define UE4SS_SDK_BP_SkillEffect_Unique_MoonQueen_MoonBlade_HPP

class ABP_SkillEffect_Unique_MoonQueen_MoonBlade_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UCapsuleComponent* CapsuleCollision;                                        // 0x0438 (size: 0x8)
    class UNiagaraComponent* NS_CommonSkill_IceBlade;                                 // 0x0440 (size: 0x8)
    class USceneComponent* MoonBladeView;                                             // 0x0448 (size: 0x8)
    class USceneComponent* MoonBlade;                                                 // 0x0450 (size: 0x8)
    class UProjectileMovementComponent* ProjectileMovement;                           // 0x0458 (size: 0x8)
    double Speed;                                                                     // 0x0460 (size: 0x8)
    double TimeUntilFade;                                                             // 0x0468 (size: 0x8)
    double HomingZIgnoreDistance;                                                     // 0x0470 (size: 0x8)
    class AActor* TargetActor;                                                        // 0x0478 (size: 0x8)
    double EnableZDirectionThresholdUpper;                                            // 0x0480 (size: 0x8)
    double EnableZDirectionThresholdLower;                                            // 0x0488 (size: 0x8)

    void ReceiveBeginPlay();
    void OnLifeTime();
    void FadeOutEffect(double DeltaSecond);
    void Init();
    void ExecuteUbergraph_BP_SkillEffect_Unique_MoonQueen_MoonBlade(int32 EntryPoint);
}; // Size: 0x490

#endif
