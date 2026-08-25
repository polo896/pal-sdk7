#ifndef UE4SS_SDK_BP_SkillEffect_Tremor_Explode_HPP
#define UE4SS_SDK_BP_SkillEffect_Tremor_Explode_HPP

class ABP_SkillEffect_Tremor_Explode_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class USphereComponent* Sphere;                                                   // 0x0438 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0440 (size: 0x8)

    void OnBreakAction();
    void ReceiveBeginPlay();
    void SetScale(double NewScale);
    void ExecuteUbergraph_BP_SkillEffect_Tremor_Explode(int32 EntryPoint);
}; // Size: 0x448

#endif
