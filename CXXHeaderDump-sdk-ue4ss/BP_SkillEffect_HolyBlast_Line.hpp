#ifndef UE4SS_SDK_BP_SkillEffect_HolyBlast_Line_HPP
#define UE4SS_SDK_BP_SkillEffect_HolyBlast_Line_HPP

class ABP_SkillEffect_HolyBlast_Line_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UBoxComponent* Box;                                                         // 0x0438 (size: 0x8)
    class UNiagaraComponent* LineOmenEffect;                                          // 0x0440 (size: 0x8)
    double LineRange;                                                                 // 0x0448 (size: 0x8)
    int32 ExplodeCount;                                                               // 0x0450 (size: 0x4)

    void ReceiveBeginPlay();
    void ActExplode();
    void DeactivateCollision();
    void ExecuteUbergraph_BP_SkillEffect_HolyBlast_Line(int32 EntryPoint);
}; // Size: 0x454

#endif
