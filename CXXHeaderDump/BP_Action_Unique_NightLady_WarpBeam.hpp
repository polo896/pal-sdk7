#ifndef UE4SS_SDK_BP_Action_Unique_NightLady_WarpBeam_HPP
#define UE4SS_SDK_BP_Action_Unique_NightLady_WarpBeam_HPP

class UBP_Action_Unique_NightLady_WarpBeam_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    FTimerHandle WarpTimer;                                                           // 0x02A0 (size: 0x8)
    float WarpDestinationDistance;                                                    // 0x02A8 (size: 0x4)
    FTimerHandle BeamTimer;                                                           // 0x02B0 (size: 0x8)
    float WarpDestinationDistance_NoneChara;                                          // 0x02B8 (size: 0x4)
    float BeamDuration;                                                               // 0x02BC (size: 0x4)
    TArray<FReserveMontage> Montage List;                                             // 0x02C0 (size: 0x10)
    bool BeamActing;                                                                  // 0x02D0 (size: 0x1)
    TArray<class ABP_SkillEffect_Unique_WarpBeam_Beam_C*> Beams;                      // 0x02D8 (size: 0x10)
    double CurrentBeamTime;                                                           // 0x02E8 (size: 0x8)
    double HommingStrength;                                                           // 0x02F0 (size: 0x8)
    bool StartHomming;                                                                // 0x02F8 (size: 0x1)
    bool MaintainHorizontal;                                                          // 0x02F9 (size: 0x1)
    double HalfWarpDegree;                                                            // 0x0300 (size: 0x8)
    class UCurveFloat* AngleCurve;                                                    // 0x0308 (size: 0x8)
    EVisibilityBasedAnimTickOption OriginalTickOption;                                // 0x0310 (size: 0x1)
    int32 MaxWarpCheck;                                                               // 0x0314 (size: 0x4)
    class ABP_SkillEffect_Unique_WarpBeam_Wave_C* CurrentWaveEffect;                  // 0x0318 (size: 0x8)
    float OriginalGravity;                                                            // 0x0320 (size: 0x4)
    bool Ignore Floor;                                                                // 0x0324 (size: 0x1)

    void AjustCharacterRotation(double DeltaTime);
    void Adjustbeam(double DeltaTime);
    void CreateBeam();
    void OnNotifyEnd_FEB6788843F94F59D0CCD4B662C87AF4(FName NotifyName);
    void OnNotifyBegin_FEB6788843F94F59D0CCD4B662C87AF4(FName NotifyName);
    void OnInterrupted_FEB6788843F94F59D0CCD4B662C87AF4(FName NotifyName);
    void OnBlendOut_FEB6788843F94F59D0CCD4B662C87AF4(FName NotifyName);
    void OnCompleted_FEB6788843F94F59D0CCD4B662C87AF4(FName NotifyName);
    void OnBeginAction();
    void OnMontageEnded(class UAnimMontage* Montage, bool bInterrupted);
    void Warp();
    void OnEndAction();
    void PrepareBeam();
    void EndBeam();
    void TickAction(float DeltaTime);
    void ExecuteUbergraph_BP_Action_Unique_NightLady_WarpBeam(int32 EntryPoint);
}; // Size: 0x325

#endif
