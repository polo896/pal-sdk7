#ifndef UE4SS_SDK_BP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_HPP
#define UE4SS_SDK_BP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_HPP

class ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class USphereComponent* Sphere;                                                   // 0x0438 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0440 (size: 0x8)
    class UPalProjectileMovementComponent* PalProjectileMovement;                     // 0x0448 (size: 0x8)
    double LaunchAngle;                                                               // 0x0450 (size: 0x8)
    double MaxLife;                                                                   // 0x0458 (size: 0x8)
    FBP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_COnMagmaSpawned OnMagmaSpawned; // 0x0460 (size: 0x10)
    void OnMagmaSpawned(class ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Magma_C* MagmaActor);

    void GetSpitClass(TSubclassOf<class ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Magma_C>& SpitClass);
    void CalcInitialVelocity(FVector Direct, FVector& Velocity);
    void ReceiveBeginPlay();
    void BndEvt__BP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(class UPrimitiveComponent* HitComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
    void FadeOutEffect(double DeltaSecond);
    void SetTargetLocation(FVector Location);
    void LifeEnd();
    void DoFadeEffect();
    void ExecuteUbergraph_BP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet(int32 EntryPoint);
    void OnMagmaSpawned__DelegateSignature(class ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Magma_C* MagmaActor);
}; // Size: 0x470

#endif
