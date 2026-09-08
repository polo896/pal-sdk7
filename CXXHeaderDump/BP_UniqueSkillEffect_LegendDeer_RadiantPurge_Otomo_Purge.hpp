#ifndef UE4SS_SDK_BP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Purge_HPP
#define UE4SS_SDK_BP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Purge_HPP

class ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Purge_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class USphereComponent* Sphere;                                                   // 0x0438 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0440 (size: 0x8)
    FTimerHandle ExtraTimer;                                                          // 0x0448 (size: 0x8)

    void CrateFlash();
    void ReceiveBeginPlay();
    void EndPurge();
    void CrateExtraEffect();
    void ExecuteUbergraph_BP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Purge(int32 EntryPoint);
}; // Size: 0x450

#endif
