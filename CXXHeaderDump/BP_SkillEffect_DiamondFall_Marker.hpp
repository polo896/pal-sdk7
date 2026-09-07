#ifndef UE4SS_SDK_BP_SkillEffect_DiamondFall_Marker_HPP
#define UE4SS_SDK_BP_SkillEffect_DiamondFall_Marker_HPP

class ABP_SkillEffect_DiamondFall_Marker_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    double HalfMaxRange;                                                              // 0x0438 (size: 0x8)
    int32 AmbienceFallCount;                                                          // 0x0440 (size: 0x4)
    int32 PredictFallCount;                                                           // 0x0444 (size: 0x4)
    int32 DirectFallCount;                                                            // 0x0448 (size: 0x4)
    double FallInterval;                                                              // 0x0450 (size: 0x8)
    FTimerHandle FallTimer;                                                           // 0x0458 (size: 0x8)
    int32 CurrentCeiling;                                                             // 0x0460 (size: 0x4)
    int32 CeilingCount;                                                               // 0x0464 (size: 0x4)

    void GetRandomFallType(bool NoAmbience, int32& Type);
    void SpawnDiamond();
    void OnInitialize();
    void ExecuteUbergraph_BP_SkillEffect_DiamondFall_Marker(int32 EntryPoint);
}; // Size: 0x468

#endif
