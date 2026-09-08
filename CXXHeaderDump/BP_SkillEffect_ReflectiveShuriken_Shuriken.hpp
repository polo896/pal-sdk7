#ifndef UE4SS_SDK_BP_SkillEffect_ReflectiveShuriken_Shuriken_HPP
#define UE4SS_SDK_BP_SkillEffect_ReflectiveShuriken_Shuriken_HPP

class ABP_SkillEffect_ReflectiveShuriken_Shuriken_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class USphereComponent* FoliageDetector;                                          // 0x0438 (size: 0x8)
    class UProjectileMovementComponent* ProjectileMovement;                           // 0x0440 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0448 (size: 0x8)
    class UBoxComponent* Box;                                                         // 0x0450 (size: 0x8)
    double Life;                                                                      // 0x0458 (size: 0x8)
    double Speed;                                                                     // 0x0460 (size: 0x8)
    double SearchDistance;                                                            // 0x0468 (size: 0x8)
    class AActor* LastTarget;                                                         // 0x0470 (size: 0x8)
    int32 MaxReflectCount;                                                            // 0x0478 (size: 0x4)
    int32 CurrentReflectCount;                                                        // 0x047C (size: 0x4)
    bool EnableTreeReflect;                                                           // 0x0480 (size: 0x1)
    TArray<int32> DetectedInstanceIDs;                                                // 0x0488 (size: 0x10)
    class UPalFoliageISMComponentBase* DetectedFoliageISMC;                           // 0x0498 (size: 0x8)
    int32 LastBodyIndex;                                                              // 0x04A0 (size: 0x4)
    double PowerDecrease;                                                             // 0x04A8 (size: 0x8)

    void Get Nearest Foliage Location(class UPalFoliageISMComponentBase* FoliageISM, FVector& Location, bool& Finded);
    void FindReflectTarget();
    void UserConstructionScript();
    void CancelShoot();
    void ReceiveBeginPlay();
    void StartFade();
    void OnAttack(class AActor* Defencer, FPalDamageInfo DamageInfo, int32 HitCount, class UPrimitiveComponent* AttackerComponent);
    void FadeOutEffect(double DeltaSecond);
    void ShootBullet(FVector TargetLocation);
    void BndEvt__BP_SkillEffect_ReflectiveShuriken_Shuriken_Box_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(class UPrimitiveComponent* OverlappedComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult);
    void DelayReflect(FVector TargetLocation);
    void BndEvt__BP_SkillEffect_ReflectiveShuriken_Shuriken_FoliageDetector_K2Node_ComponentBoundEvent_3_ComponentBeginOverlapSignature__DelegateSignature(class UPrimitiveComponent* OverlappedComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult);
    void BndEvt__BP_SkillEffect_ReflectiveShuriken_Shuriken_FoliageDetector_K2Node_ComponentBoundEvent_4_ComponentEndOverlapSignature__DelegateSignature(class UPrimitiveComponent* OverlappedComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex);
    void BndEvt__BP_SkillEffect_ReflectiveShuriken_Shuriken_MovementSphereRoot_K2Node_ComponentBoundEvent_8_ComponentHitSignature__DelegateSignature(class UPrimitiveComponent* HitComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
    void ExecuteUbergraph_BP_SkillEffect_ReflectiveShuriken_Shuriken(int32 EntryPoint);
}; // Size: 0x4B0

#endif
