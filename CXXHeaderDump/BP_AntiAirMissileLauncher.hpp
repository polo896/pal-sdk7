#ifndef UE4SS_SDK_BP_AntiAirMissileLauncher_HPP
#define UE4SS_SDK_BP_AntiAirMissileLauncher_HPP

class ABP_AntiAirMissileLauncher_C : public APalAntiAirMissileLauncher
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0348 (size: 0x8)
    class UBP_CannonDamageReactionComponent_C* BP_CannonDamageReactionComponent;      // 0x0350 (size: 0x8)
    class UStaticMeshComponent* TowerMesh;                                            // 0x0358 (size: 0x8)
    class UPalInteractableSphereComponentNative* BP_InteractableSphere;               // 0x0360 (size: 0x8)
    class USphereComponent* Sphere;                                                   // 0x0368 (size: 0x8)
    class UStaticMeshComponent* PitchMesh;                                            // 0x0370 (size: 0x8)
    class UStaticMeshComponent* YawMesh;                                              // 0x0378 (size: 0x8)
    class UStaticMeshComponent* BaseMesh;                                             // 0x0380 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x0388 (size: 0x8)
    int32 WeaponDamage;                                                               // 0x0390 (size: 0x4)
    FTimerHandle TimerHandle;                                                         // 0x0398 (size: 0x8)
    float Const_OneBulletShootInterval;                                               // 0x03A0 (size: 0x4)
    bool IsRightMuzzle;                                                               // 0x03A4 (size: 0x1)
    int32 Const_OneCycleShootNum;                                                     // 0x03A8 (size: 0x4)
    int32 CurrentShootCount;                                                          // 0x03AC (size: 0x4)
    EPalActionType ActionType;                                                        // 0x03B0 (size: 0x1)
    FTimerHandle DebugTimerHandle;                                                    // 0x03B8 (size: 0x8)

    void SetActiveGunMesh(bool IsActive);
    void Stop Animation(class AActor* Other, EPalInteractiveObjectIndicatorType IndicatorType);
    void Start Animation(class AActor* Other, EPalInteractiveObjectIndicatorType IndicatorType);
    void Interact Completed(class AActor* Other, EPalInteractiveObjectIndicatorType IndicatorType);
    EPalInteractiveObjectIndicatorType GetIndicatorType();
    class USceneComponent* GetYawMesh();
    void GetMuzzleTransform(FTransform& MuzzleTF);
    void ShootBullet();
    class USceneComponent* GetPitchMesh();
    void PullTrigger_BP();
    void ReleaseTrigger_BP();
    void BndEvt__BP_AntiAirMissileLauncher_Sphere_K2Node_ComponentBoundEvent_0_ComponentBeginOverlapSignature__DelegateSignature(class UPrimitiveComponent* OverlappedComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult);
    void BndEvt__BP_AntiAirMissileLauncher_Sphere_K2Node_ComponentBoundEvent_1_ComponentEndOverlapSignature__DelegateSignature(class UPrimitiveComponent* OverlappedComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex);
    void ReceiveBeginPlay();
    void OnDestroyWeapon_BP();
    void ReceiveEndPlay(TEnumAsByte<EEndPlayReason::Type> EndPlayReason);
    void DebugPrint();
    void ExecuteUbergraph_BP_AntiAirMissileLauncher(int32 EntryPoint);
}; // Size: 0x3C0

#endif
