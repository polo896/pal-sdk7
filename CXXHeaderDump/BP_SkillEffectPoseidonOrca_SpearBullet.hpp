#ifndef UE4SS_SDK_BP_SkillEffectPoseidonOrca_SpearBullet_HPP
#define UE4SS_SDK_BP_SkillEffectPoseidonOrca_SpearBullet_HPP

class ABP_SkillEffectPoseidonOrca_SpearBullet_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class USkeletalMeshComponent* SkeletalMesh;                                       // 0x0438 (size: 0x8)
    class UNiagaraComponent* TrailEffect;                                             // 0x0440 (size: 0x8)
    class UNiagaraComponent* ImpactEffect;                                            // 0x0448 (size: 0x8)
    class UNiagaraComponent* MainEffect;                                              // 0x0450 (size: 0x8)
    class USphereComponent* Sphere;                                                   // 0x0458 (size: 0x8)
    class USphereComponent* ImpactCollison;                                           // 0x0460 (size: 0x8)
    class UProjectileMovementComponent* ProjectileMovement;                           // 0x0468 (size: 0x8)
    double ReadyTime;                                                                 // 0x0470 (size: 0x8)
    class AActor* TargetActor;                                                        // 0x0478 (size: 0x8)
    double AutoDestroyTime;                                                           // 0x0480 (size: 0x8)

    void SetEnableCollision(bool Enable);
    void ReceiveBeginPlay();
    void OnHitDelegate(class UPrimitiveComponent* MyHitComponent, class AActor* OtherHitActor, class UPrimitiveComponent* OtherHitComponent, const TArray<int32>& FoliageIndex, FVector HitLocation, int32 HitCount);
    void BndEvt__BP_SkillEffectDragonMeteorBullet_ImpactCollison_K2Node_ComponentBoundEvent_0_ComponentBeginOverlapSignature__DelegateSignature(class UPrimitiveComponent* OverlappedComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult);
    void BndEvt__BP_SkillEffectDragonMeteorBullet_MovementSphereRoot_K2Node_ComponentBoundEvent_1_ComponentHitSignature__DelegateSignature(class UPrimitiveComponent* HitComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
    void FadeOutEffect(double DeltaSecond);
    void OnShootBullet();
    void OnAutoDestroy();
    void BndEvt__BP_SkillEffect_BubbleShot_Bullet_AttackFilter_K2Node_ComponentBoundEvent_1_OnAttackDelegate__DelegateSignature(class AActor* Defencer, FPalDamageInfo DamageInfo, int32 HitCount, class UPrimitiveComponent* AttackerComponent);
    void OnHitGround();
    void ExecuteUbergraph_BP_SkillEffectPoseidonOrca_SpearBullet(int32 EntryPoint);
}; // Size: 0x488

#endif
