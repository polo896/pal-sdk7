#ifndef UE4SS_SDK_BP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail_HPP
#define UE4SS_SDK_BP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail_HPP

class ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0438 (size: 0x8)
    class USceneComponent* Root;                                                      // 0x0440 (size: 0x8)
    double TimeUntilFade;                                                             // 0x0448 (size: 0x8)
    class UBP_Action_Unique_DarkMechaDragon_WarpComet_C* RootAction;                  // 0x0450 (size: 0x8)
    FRotator FixedRotation;                                                           // 0x0458 (size: 0x18)

    void SetScale(double Scale);
    void FadeOutEffect(double DeltaSecond);
    void SetLifeTimer(double Duration);
    void OnLifeTime();
    void ReceiveTick(float DeltaSeconds);
    void SetRootAction(class UBP_Action_Unique_DarkMechaDragon_WarpComet_C* action);
    void SetFixedRotation();
    void SetRotation(FRotator NewRotation);
    void ExecuteUbergraph_BP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail(int32 EntryPoint);
}; // Size: 0x470

#endif
