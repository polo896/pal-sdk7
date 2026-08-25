#ifndef UE4SS_SDK_BP_SkillEffect_Tremor_Blast_HPP
#define UE4SS_SDK_BP_SkillEffect_Tremor_Blast_HPP

class ABP_SkillEffect_Tremor_Blast_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0438 (size: 0x8)
    double EffectDuration;                                                            // 0x0440 (size: 0x8)
    int32 RockCount;                                                                  // 0x0448 (size: 0x4)

    void Explosion();
    void ReceiveBeginPlay();
    void EffectTimeout();
    void ExecuteUbergraph_BP_SkillEffect_Tremor_Blast(int32 EntryPoint);
}; // Size: 0x44C

#endif
