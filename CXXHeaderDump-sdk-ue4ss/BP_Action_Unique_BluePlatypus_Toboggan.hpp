#ifndef UE4SS_SDK_BP_Action_Unique_BluePlatypus_Toboggan_HPP
#define UE4SS_SDK_BP_Action_Unique_BluePlatypus_Toboggan_HPP

class UBP_Action_Unique_BluePlatypus_Toboggan_C : public UBP_ActionUniqueAttackBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0298 (size: 0x8)
    bool IsAbort;                                                                     // 0x02A0 (size: 0x1)
    bool IsMoving;                                                                    // 0x02A1 (size: 0x1)
    double ElapsedTime;                                                               // 0x02A8 (size: 0x8)
    double MovingLimitTime;                                                           // 0x02B0 (size: 0x8)
    class APalAIController* AIController;                                             // 0x02B8 (size: 0x8)
    class UPalSkeletalMeshComponent* SkeletalMesh;                                    // 0x02C0 (size: 0x8)
    class UPalStaticCharacterParameterComponent* StaticParameter;                     // 0x02C8 (size: 0x8)
    class UPalCharacterMovementComponent* Movement;                                   // 0x02D0 (size: 0x8)
    FName flagName_0;                                                                 // 0x02D8 (size: 0x8)
    float MaxSpeedMultiply;                                                           // 0x02E0 (size: 0x4)
    class UPalAnimNotifyParameterComponent* AnimNotify;                               // 0x02E8 (size: 0x8)
    float YawMultiply;                                                                // 0x02F0 (size: 0x4)
    class ABP_SkillEffectBase_C* SkillEffect;                                         // 0x02F8 (size: 0x8)
    bool IsCoolDown;                                                                  // 0x0300 (size: 0x1)
    bool IsNearTarget;                                                                // 0x0301 (size: 0x1)
    double CoolDownTime;                                                              // 0x0308 (size: 0x8)
    double StartRotationTime;                                                         // 0x0310 (size: 0x8)
    double MovingRotationTime;                                                        // 0x0318 (size: 0x8)
    double NearDistance;                                                              // 0x0320 (size: 0x8)
    double SkillEffectEndTime;                                                        // 0x0328 (size: 0x8)

    void SetMovementDisable(bool isDisable);
    void EndSkillEffect();
    void CreateSkillEffect();
    void StartCoolDown();
    void SetActorRotationByLerp(FVector PrevDirection, FVector targetDirection, double Rate);
    void SetActorLocation(double DeltaTime, double MoveSpeed, FVector Direction);
    void SetActiveAI(bool IsActive);
    void Finish();
    void HitProc(class AActor* HitActor);
    void Cooldown(double DeltaTime);
    void MoveToTarget(class AActor* Target, double DeltaTime);
    void Turn to Target(double DeltaTime);
    void Update(double DeltaTime);
    void StartSliding();
    void SetupAction();
    void OnNotifyEnd_D0B9C3F54B2F81251B4977B51A209E29(FName NotifyName);
    void OnNotifyBegin_D0B9C3F54B2F81251B4977B51A209E29(FName NotifyName);
    void OnInterrupted_D0B9C3F54B2F81251B4977B51A209E29(FName NotifyName);
    void OnBlendOut_D0B9C3F54B2F81251B4977B51A209E29(FName NotifyName);
    void OnCompleted_D0B9C3F54B2F81251B4977B51A209E29(FName NotifyName);
    void OnNotifyEnd_27660E4840A46F251D46CE833F021C6A(FName NotifyName);
    void OnNotifyBegin_27660E4840A46F251D46CE833F021C6A(FName NotifyName);
    void OnInterrupted_27660E4840A46F251D46CE833F021C6A(FName NotifyName);
    void OnBlendOut_27660E4840A46F251D46CE833F021C6A(FName NotifyName);
    void OnCompleted_27660E4840A46F251D46CE833F021C6A(FName NotifyName);
    void OnBeginAction();
    void OnEndAction();
    void TickAction(float DeltaTime);
    void BindHitEvent();
    void UnbindHitEvent();
    void OnHit(class UPrimitiveComponent* MyHitComponent, class AActor* OtherHitActor, class UPrimitiveComponent* OtherHitComponent, const TArray<int32>& FoliageIndex, FVector HitLocation, int32 HitCount);
    void ExecuteUbergraph_BP_Action_Unique_BluePlatypus_Toboggan(int32 EntryPoint);
}; // Size: 0x330

#endif
