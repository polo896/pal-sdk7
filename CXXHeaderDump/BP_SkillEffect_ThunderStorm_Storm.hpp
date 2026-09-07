#ifndef UE4SS_SDK_BP_SkillEffect_ThunderStorm_Storm_HPP
#define UE4SS_SDK_BP_SkillEffect_ThunderStorm_Storm_HPP

class ABP_SkillEffect_ThunderStorm_Storm_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UCapsuleComponent* Capsule;                                                 // 0x0438 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0440 (size: 0x8)
    float StormDuration;                                                              // 0x0448 (size: 0x4)
    double HomingStrength;                                                            // 0x0450 (size: 0x8)

    void ReceiveBeginPlay();
    void FadeOutEffect(double DeltaSecond);
    void EndStorm();
    void ReceiveTick(float DeltaSeconds);
    void BndEvt__BP_SkillEffect_ThunderStorm_Storm_Niagara_K2Node_ComponentBoundEvent_0_OnNiagaraSystemFinished__DelegateSignature(class UNiagaraComponent* PSystem);
    void ExecuteUbergraph_BP_SkillEffect_ThunderStorm_Storm(int32 EntryPoint);
}; // Size: 0x458

#endif
