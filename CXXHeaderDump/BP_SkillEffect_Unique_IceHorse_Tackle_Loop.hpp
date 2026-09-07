#ifndef UE4SS_SDK_BP_SkillEffect_Unique_IceHorse_Tackle_Loop_HPP
#define UE4SS_SDK_BP_SkillEffect_Unique_IceHorse_Tackle_Loop_HPP

class ABP_SkillEffect_Unique_IceHorse_Tackle_Loop_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UNiagaraComponent* Niagara_WingL;                                           // 0x0438 (size: 0x8)
    class UNiagaraComponent* Niagara_WingR;                                           // 0x0440 (size: 0x8)
    class UNiagaraComponent* NiagaraEffect;                                           // 0x0448 (size: 0x8)

    void FadeOutEffect(double DeltaSecond);
    void OnEndAction();
    void AttachWing(class APalCharacter* OwnerCharacter);
    void ReceiveBeginPlay();
    void ExecuteUbergraph_BP_SkillEffect_Unique_IceHorse_Tackle_Loop(int32 EntryPoint);
}; // Size: 0x450

#endif
