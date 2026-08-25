#ifndef UE4SS_SDK_BP_SkillEffect_GrassGolem_PartnerSkill_Laser_HPP
#define UE4SS_SDK_BP_SkillEffect_GrassGolem_PartnerSkill_Laser_HPP

class ABP_SkillEffect_GrassGolem_PartnerSkill_Laser_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UCapsuleComponent* Capsule;                                                 // 0x0438 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0440 (size: 0x8)

    void ReceiveBeginPlay();
    void FadeOutEffect(double DeltaSecond);
    void SetFade();
    void ExecuteUbergraph_BP_SkillEffect_GrassGolem_PartnerSkill_Laser(int32 EntryPoint);
}; // Size: 0x448

#endif
