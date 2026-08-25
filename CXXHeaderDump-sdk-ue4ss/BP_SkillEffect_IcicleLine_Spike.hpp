#ifndef UE4SS_SDK_BP_SkillEffect_IcicleLine_Spike_HPP
#define UE4SS_SDK_BP_SkillEffect_IcicleLine_Spike_HPP

class ABP_SkillEffect_IcicleLine_Spike_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UCapsuleComponent* Capsule;                                                 // 0x0438 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0440 (size: 0x8)
    float SpikeLife;                                                                  // 0x0448 (size: 0x4)

    void ReceiveBeginPlay();
    void End();
    void FadeOutEffect(double DeltaSecond);
    void ExecuteUbergraph_BP_SkillEffect_IcicleLine_Spike(int32 EntryPoint);
}; // Size: 0x44C

#endif
