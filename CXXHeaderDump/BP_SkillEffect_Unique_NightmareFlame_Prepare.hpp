#ifndef UE4SS_SDK_BP_SkillEffect_Unique_NightmareFlame_Prepare_HPP
#define UE4SS_SDK_BP_SkillEffect_Unique_NightmareFlame_Prepare_HPP

class ABP_SkillEffect_Unique_NightmareFlame_Prepare_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0438 (size: 0x8)

    void SetParam(double Life, double Size, double Vortex);
    void StartFade();
    void ExecuteUbergraph_BP_SkillEffect_Unique_NightmareFlame_Prepare(int32 EntryPoint);
}; // Size: 0x440

#endif
