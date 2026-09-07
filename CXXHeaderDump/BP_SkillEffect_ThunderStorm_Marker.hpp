#ifndef UE4SS_SDK_BP_SkillEffect_ThunderStorm_Marker_HPP
#define UE4SS_SDK_BP_SkillEffect_ThunderStorm_Marker_HPP

class ABP_SkillEffect_ThunderStorm_Marker_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0438 (size: 0x8)
    float StormDelay;                                                                 // 0x0440 (size: 0x4)

    void ReceiveBeginPlay();
    void CreateStorm();
    void FadeOutEffect(double DeltaSecond);
    void ExecuteUbergraph_BP_SkillEffect_ThunderStorm_Marker(int32 EntryPoint);
}; // Size: 0x444

#endif
