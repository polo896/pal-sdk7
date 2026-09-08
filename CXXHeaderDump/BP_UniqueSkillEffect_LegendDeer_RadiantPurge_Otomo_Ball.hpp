#ifndef UE4SS_SDK_BP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Ball_HPP
#define UE4SS_SDK_BP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Ball_HPP

class ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Ball_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0438 (size: 0x8)
    double DownSpeed;                                                                 // 0x0440 (size: 0x8)
    bool Casting;                                                                     // 0x0448 (size: 0x1)
    FVector Target Location;                                                          // 0x0450 (size: 0x18)
    double CastTime;                                                                  // 0x0468 (size: 0x8)
    double CurrentTime;                                                               // 0x0470 (size: 0x8)
    double CurrentYaw;                                                                // 0x0478 (size: 0x8)
    double LengthX;                                                                   // 0x0480 (size: 0x8)
    double LengthZ;                                                                   // 0x0488 (size: 0x8)
    class UCurveVector* Curve_RandomBall;                                             // 0x0490 (size: 0x8)
    double YawSpeed;                                                                  // 0x0498 (size: 0x8)
    bool Reverse;                                                                     // 0x04A0 (size: 0x1)
    FTimerHandle CameraShakeTimer;                                                    // 0x04A8 (size: 0x8)

    void ReceiveBeginPlay();
    void ReceiveTick(float DeltaSeconds);
    void SetParam(FVector TargetLocation );
    void ActCast();
    void FadeOutEffect(double DeltaSecond);
    void ChangeYaw();
    void CameraShake();
    void ReceiveEndPlay(TEnumAsByte<EEndPlayReason::Type> EndPlayReason);
    void ExecuteUbergraph_BP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Ball(int32 EntryPoint);
}; // Size: 0x4B0

#endif
