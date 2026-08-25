#ifndef UE4SS_SDK_BP_SkillEffect_IcicleLine_Line_HPP
#define UE4SS_SDK_BP_SkillEffect_IcicleLine_Line_HPP

class ABP_SkillEffect_IcicleLine_Line_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UArrowComponent* Arrow;                                                     // 0x0438 (size: 0x8)
    double MoveSpeed;                                                                 // 0x0440 (size: 0x8)
    int32 MaxSpike;                                                                   // 0x0448 (size: 0x4)
    int32 SpikeCount;                                                                 // 0x044C (size: 0x4)
    FTimerHandle SpikeTimer;                                                          // 0x0450 (size: 0x8)
    float SpikeInterval;                                                              // 0x0458 (size: 0x4)

    void ReceiveBeginPlay();
    void ReceiveTick(float DeltaSeconds);
    void CreateSpike();
    void ExecuteUbergraph_BP_SkillEffect_IcicleLine_Line(int32 EntryPoint);
}; // Size: 0x45C

#endif
