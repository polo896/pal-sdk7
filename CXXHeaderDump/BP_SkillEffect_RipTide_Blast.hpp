#ifndef UE4SS_SDK_BP_SkillEffect_RipTide_Blast_HPP
#define UE4SS_SDK_BP_SkillEffect_RipTide_Blast_HPP

class ABP_SkillEffect_RipTide_Blast_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UCapsuleComponent* Capsule;                                                 // 0x0438 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0440 (size: 0x8)

    void ReceiveBeginPlay();
    void ExecuteUbergraph_BP_SkillEffect_RipTide_Blast(int32 EntryPoint);
}; // Size: 0x448

#endif
