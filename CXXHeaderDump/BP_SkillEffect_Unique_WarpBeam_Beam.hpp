#ifndef UE4SS_SDK_BP_SkillEffect_Unique_WarpBeam_Beam_HPP
#define UE4SS_SDK_BP_SkillEffect_Unique_WarpBeam_Beam_HPP

class ABP_SkillEffect_Unique_WarpBeam_Beam_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UCapsuleComponent* Capsule;                                                 // 0x0438 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0440 (size: 0x8)

    void ReceiveBeginPlay();
    void EndCollision();
    void SetBeamDurationAndSize(double Duration, double Size);
    void FadeOutEffect(double DeltaSecond);
    void ExecuteUbergraph_BP_SkillEffect_Unique_WarpBeam_Beam(int32 EntryPoint);
}; // Size: 0x448

#endif
