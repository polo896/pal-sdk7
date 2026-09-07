#ifndef UE4SS_SDK_BP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Mark_HPP
#define UE4SS_SDK_BP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Mark_HPP

class ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Mark_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UCapsuleComponent* Capsule;                                                 // 0x0438 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0440 (size: 0x8)
    bool Is Water;                                                                    // 0x0448 (size: 0x1)

    void ReceiveBeginPlay();
    void Burst();
    void FadeOutEffect(double DeltaSecond);
    void SetWaterEffect(bool IsWater);
    void ExecuteUbergraph_BP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Mark(int32 EntryPoint);
}; // Size: 0x449

#endif
