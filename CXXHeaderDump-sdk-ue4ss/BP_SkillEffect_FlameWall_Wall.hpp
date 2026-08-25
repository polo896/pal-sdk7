#ifndef UE4SS_SDK_BP_SkillEffect_FlameWall_Wall_HPP
#define UE4SS_SDK_BP_SkillEffect_FlameWall_Wall_HPP

class ABP_SkillEffect_FlameWall_Wall_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UBoxComponent* WallCollision;                                               // 0x0438 (size: 0x8)
    class UNiagaraComponent* WallEffect;                                              // 0x0440 (size: 0x8)
    float MaxEffectDuration;                                                          // 0x0448 (size: 0x4)
    double CollisionEnableDelayTime;                                                  // 0x0450 (size: 0x8)
    float CollisionEnableTime;                                                        // 0x0458 (size: 0x4)

    void ReceiveBeginPlay();
    void EndEffect();
    void FadeOutEffect(double DeltaSecond);
    void CollisionDisable();
    void ExecuteUbergraph_BP_SkillEffect_FlameWall_Wall(int32 EntryPoint);
}; // Size: 0x45C

#endif
