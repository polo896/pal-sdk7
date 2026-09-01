#ifndef UE4SS_SDK_BP_UniqueSkillEffect_Mothman_SporeScatter_Spore_HPP
#define UE4SS_SDK_BP_UniqueSkillEffect_Mothman_SporeScatter_Spore_HPP

class ABP_UniqueSkillEffect_Mothman_SporeScatter_Spore_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UMaterialBillboardComponent* MaterialBillboard;                             // 0x0438 (size: 0x8)
    class USphereComponent* Sphere;                                                   // 0x0440 (size: 0x8)
    class USphereComponent* Sphere_Explosion;                                         // 0x0448 (size: 0x8)
    FVector Target Location;                                                          // 0x0450 (size: 0x18)
    double WarningDistanceThreshold ;                                                 // 0x0468 (size: 0x8)
    float MaxLife;                                                                    // 0x0470 (size: 0x4)
    float Alpha;                                                                      // 0x0474 (size: 0x4)
    FTimerHandle DistanceCheckTimer;                                                  // 0x0478 (size: 0x8)

    void SetCancel();
    void FadeOutEffect(double DeltaSecond);
    void Explode();
    void BndEvt__BP_UniqueSkillEffect_Mothman_SporeScatter_Spore_Sphere_K2Node_ComponentBoundEvent_2_ComponentBeginOverlapSignature__DelegateSignature(class UPrimitiveComponent* OverlappedComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult);
    void BndEvt__BP_UniqueSkillEffect_Mothman_SporeScatter_Spore_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(class UPrimitiveComponent* HitComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
    void SetAsGimmick();
    void SetTargetLocation(const FVector TargetLocation);
    void ReceiveTick(float DeltaSeconds);
    void ReceiveBeginPlay();
    void DistanceCheck();
    void ExecuteUbergraph_BP_UniqueSkillEffect_Mothman_SporeScatter_Spore(int32 EntryPoint);
}; // Size: 0x480

#endif
