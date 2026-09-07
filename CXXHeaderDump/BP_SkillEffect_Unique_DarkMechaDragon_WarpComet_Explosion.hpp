#ifndef UE4SS_SDK_BP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Explosion_HPP
#define UE4SS_SDK_BP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Explosion_HPP

class ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Explosion_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UCapsuleComponent* Capsule;                                                 // 0x0438 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0440 (size: 0x8)
    double TimeUntilFade;                                                             // 0x0448 (size: 0x8)

    void SetScale(double Scale);
    void ReceiveBeginPlay();
    void OnLifeTime();
    void FadeOutEffect(double DeltaSecond);
    void ExecuteUbergraph_BP_SkillEffect_Unique_DarkMechaDragon_WarpComet_Explosion(int32 EntryPoint);
}; // Size: 0x450

#endif
