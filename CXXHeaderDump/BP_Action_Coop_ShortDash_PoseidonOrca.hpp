#ifndef UE4SS_SDK_BP_Action_Coop_ShortDash_PoseidonOrca_HPP
#define UE4SS_SDK_BP_Action_Coop_ShortDash_PoseidonOrca_HPP

class UBP_Action_Coop_ShortDash_PoseidonOrca_C : public UPalActionBase
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0160 (size: 0x8)
    double DashDistance;                                                              // 0x0168 (size: 0x8)
    double MaxSpeedMultiply;                                                          // 0x0170 (size: 0x8)
    FName flagName;                                                                   // 0x0178 (size: 0x8)
    double RunAnimSpeed;                                                              // 0x0180 (size: 0x8)
    FTimerHandle DashTimerHandle;                                                     // 0x0188 (size: 0x8)
    class ABP_SkillEffectBase_C* DashSkillEffect;                                     // 0x0190 (size: 0x8)
    TSubclassOf<class ABP_SkillEffectBase_C> DashSkillEffectClass;                    // 0x0198 (size: 0x8)
    bool IsEffectSpawnOnGround;                                                       // 0x01A0 (size: 0x1)
    bool IsInputMove;                                                                 // 0x01A1 (size: 0x1)
    class UPalCharacterMovementComponent* MoveComp;                                   // 0x01A8 (size: 0x8)
    class UPalPartnerSkillParameterComponent* PartnerComp;                            // 0x01B0 (size: 0x8)
    FShooterSpringCameraParameter CameraOffset;                                       // 0x01B8 (size: 0x28)
    double EffectOffset;                                                              // 0x01E0 (size: 0x8)
    float Jump Out Of Water Pitch;                                                    // 0x01E8 (size: 0x4)
    float Jumpable In Water Depth;                                                    // 0x01EC (size: 0x4)
    float Jump Z Velocity;                                                            // 0x01F0 (size: 0x4)
    double WhileJumpGravityTime;                                                      // 0x01F8 (size: 0x8)
    float WhileJumpGravityRate;                                                       // 0x0200 (size: 0x4)
    double DashTime;                                                                  // 0x0208 (size: 0x8)
    float Jump_Velocity;                                                              // 0x0210 (size: 0x4)
    float VelocityModify_All;                                                         // 0x0214 (size: 0x4)
    double VelocityModify_Z;                                                          // 0x0218 (size: 0x8)
    FTimerHandle IsExitWaterTimerHandle;                                              // 0x0220 (size: 0x8)
    double prevZ;                                                                     // 0x0228 (size: 0x8)
    FVector PrevLocation;                                                             // 0x0230 (size: 0x18)

    void Force_Jump();
    void SetJumpableDefaultValue();
    void EnableJumping();
    void GetJumpableDefaultValue();
    void SetEffectRotation();
    void GetInputVector(FVector& InputVector);
    void EndCamera();
    void StartCamera();
    void CreateSkillEffect();
    void EndDash();
    void StartDash();
    void OnLanded(class UPalCharacterMovementComponent* Component, const FHitResult& Hit);
    void OnWaterEnter();
    void NotExitWater();
    void TickAction(float DeltaTime);
    void OnEndAction();
    void OnBeginAction();
    void ExecuteUbergraph_BP_Action_Coop_ShortDash_PoseidonOrca(int32 EntryPoint);
}; // Size: 0x248

#endif
