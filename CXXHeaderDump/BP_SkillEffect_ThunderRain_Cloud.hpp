#ifndef UE4SS_SDK_BP_SkillEffect_ThunderRain_Cloud_HPP
#define UE4SS_SDK_BP_SkillEffect_ThunderRain_Cloud_HPP

class ABP_SkillEffect_ThunderRain_Cloud_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    int32 ThunderCount;                                                               // 0x0438 (size: 0x4)
    float ThunderInterval;                                                            // 0x043C (size: 0x4)
    int32 MaxThunderCount;                                                            // 0x0440 (size: 0x4)
    double MaxThunderDistance;                                                        // 0x0448 (size: 0x8)
    FTimerHandle ThunderTimer;                                                        // 0x0450 (size: 0x8)
    TArray<FVector2D> Out Point Array;                                                // 0x0458 (size: 0x10)
    FVector Target Location;                                                          // 0x0468 (size: 0x18)

    void Vector2DByQuadrantSwitcher(FVector2D& Vector2D);
    void ReceiveBeginPlay();
    void CreateThunder();
    void SetThunderLocations(FVector TargetLocation);
    void ExecuteUbergraph_BP_SkillEffect_ThunderRain_Cloud(int32 EntryPoint);
}; // Size: 0x480

#endif
