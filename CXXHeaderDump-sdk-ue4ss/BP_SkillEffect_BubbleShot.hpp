#ifndef UE4SS_SDK_BP_SkillEffect_BubbleShot_HPP
#define UE4SS_SDK_BP_SkillEffect_BubbleShot_HPP

class ABP_SkillEffect_BubbleShot_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class USphereComponent* Collision;                                                // 0x0438 (size: 0x8)
    class UNiagaraComponent* BubbleShot;                                              // 0x0440 (size: 0x8)
    class USphereComponent* SpawnPos;                                                 // 0x0448 (size: 0x8)
    class UProjectileMovementComponent* ProjectileMovement;                           // 0x0450 (size: 0x8)
    int32 Shot_volume;                                                                // 0x0458 (size: 0x4)
    double Shot_extent;                                                               // 0x0460 (size: 0x8)
    double ShotSpan;                                                                  // 0x0468 (size: 0x8)
    double Temp time;                                                                 // 0x0470 (size: 0x8)
    int32 Shot_Count;                                                                 // 0x0478 (size: 0x4)

    void ReceiveHit(class UPrimitiveComponent* MyComp, class AActor* Other, class UPrimitiveComponent* OtherComp, bool bSelfMoved, FVector HitLocation, FVector HitNormal, FVector NormalImpulse, const FHitResult& Hit);
    void Explosion();
    void ReceiveBeginPlay();
    void ReceiveTick(float DeltaSeconds);
    void ExecuteUbergraph_BP_SkillEffect_BubbleShot(int32 EntryPoint);
}; // Size: 0x47C

#endif
