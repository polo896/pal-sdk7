#ifndef UE4SS_SDK_BP_SkillEfffect_SandTwister_Tornado2_HPP
#define UE4SS_SDK_BP_SkillEfffect_SandTwister_Tornado2_HPP

class ABP_SkillEfffect_SandTwister_Tornado2_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UCapsuleComponent* Capsule;                                                 // 0x0438 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0440 (size: 0x8)
    double Life;                                                                      // 0x0448 (size: 0x8)

    void ReceiveBeginPlay();
    void FadeOutEffect(double DeltaSecond);
    void OnLifeEnd();
    void ExecuteUbergraph_BP_SkillEfffect_SandTwister_Tornado2(int32 EntryPoint);
}; // Size: 0x450

#endif
