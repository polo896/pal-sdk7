#ifndef UE4SS_SDK_BP_SkillEffect_FireSeed_HPP
#define UE4SS_SDK_BP_SkillEffect_FireSeed_HPP

class ABP_SkillEffect_FireSeed_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class USphereComponent* DamageCollision;                                          // 0x0438 (size: 0x8)
    class UNiagaraComponent* NS_FireSeed;                                             // 0x0440 (size: 0x8)
    class USphereComponent* DisableHomingTrigger;                                     // 0x0448 (size: 0x8)
    class USphereComponent* ExplosionTrigger;                                         // 0x0450 (size: 0x8)
    class USphereComponent* SpawnPos;                                                 // 0x0458 (size: 0x8)
    class UStaticMeshComponent* rotater;                                              // 0x0460 (size: 0x8)
    class UProjectileMovementComponent* ProjectileMovement;                           // 0x0468 (size: 0x8)
    double ExplosionTime;                                                             // 0x0470 (size: 0x8)
    int32 Explosion_volume;                                                           // 0x0478 (size: 0x4)
    double Explosion_extent;                                                          // 0x0480 (size: 0x8)
    double Explosion Rot Y;                                                           // 0x0488 (size: 0x8)
    FRandomStream Random Stream;                                                      // 0x0490 (size: 0x8)
    bool Explosioned;                                                                 // 0x0498 (size: 0x1)
    double DistanceRequiredForExplosion;                                              // 0x04A0 (size: 0x8)
    float MaxEffectDuration;                                                          // 0x04A8 (size: 0x4)
    float ChildFireMinScale;                                                          // 0x04AC (size: 0x4)
    float ChildFireMaxScale;                                                          // 0x04B0 (size: 0x4)
    float ExplosionEffectDelay;                                                       // 0x04B4 (size: 0x4)

    void Get Predicted Target(class AActor*& PredictedTarget);
    void ReceiveHit(class UPrimitiveComponent* MyComp, class AActor* Other, class UPrimitiveComponent* OtherComp, bool bSelfMoved, FVector HitLocation, FVector HitNormal, FVector NormalImpulse, const FHitResult& Hit);
    void Explosion();
    void ReceiveBeginPlay();
    void BndEvt__BP_SkillEffect_FireSeed_ExplosionTrigger_K2Node_ComponentBoundEvent_0_ComponentBeginOverlapSignature__DelegateSignature(class UPrimitiveComponent* OverlappedComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult);
    void BndEvt__BP_SkillEffect_FireSeed_DisableHomingTrigger_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(class UPrimitiveComponent* OverlappedComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult);
    void FadeOutEffect(double DeltaSecond);
    void OnHitGround();
    void BndEvt__BP_SkillEffect_FireSeed_MovementSphereRoot_K2Node_ComponentBoundEvent_2_ComponentHitSignature__DelegateSignature(class UPrimitiveComponent* HitComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
    void ExecuteUbergraph_BP_SkillEffect_FireSeed(int32 EntryPoint);
}; // Size: 0x4B8

#endif
