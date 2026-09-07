#ifndef UE4SS_SDK_BP_SkillEffect_IceAge_Bullet_HPP
#define UE4SS_SDK_BP_SkillEffect_IceAge_Bullet_HPP

class ABP_SkillEffect_IceAge_Bullet_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UCapsuleComponent* BlockingCapsule;                                         // 0x0438 (size: 0x8)
    class UCapsuleComponent* CapsuleCollision;                                        // 0x0440 (size: 0x8)
    class UNiagaraComponent* ExplosionEffect;                                         // 0x0448 (size: 0x8)
    class UNiagaraComponent* OmenEffect;                                              // 0x0450 (size: 0x8)
    double CollisionTime;                                                             // 0x0458 (size: 0x8)
    FTimerHandle Timer;                                                               // 0x0460 (size: 0x8)

    void SetRandomValueIntoNiagaraVariable(class UNiagaraComponent* NiagaraComp);
    void Explosion();
    void InitializeEffect();
    void OnInitialize();
    void OnExplosion();
    void OnEndCollision();
    void FadeOutEffect(double DeltaSecond);
    void EndBlock();
    void ExecuteUbergraph_BP_SkillEffect_IceAge_Bullet(int32 EntryPoint);
}; // Size: 0x468

#endif
