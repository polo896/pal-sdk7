#ifndef UE4SS_SDK_BP_SkillEffect_Commet_Rock_HPP
#define UE4SS_SDK_BP_SkillEffect_Commet_Rock_HPP

class ABP_SkillEffect_Commet_Rock_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UProjectileMovementComponent* ProjectileMovement;                           // 0x0438 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0440 (size: 0x8)
    class USphereComponent* Sphere;                                                   // 0x0448 (size: 0x8)
    float GravityScale;                                                               // 0x0450 (size: 0x4)
    double HoldTime;                                                                  // 0x0458 (size: 0x8)

    void GetGroundOrWaterPlaneTrace(const FVector Start, const FVector End, FVector& Location);
    void ReceiveBeginPlay();
    void BndEvt__BP_SkillEffect_SeedMine_Seed_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(class UPrimitiveComponent* HitComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
    void OnBreakAction();
    void StartFall();
    void FadeOutEffect(double DeltaSecond);
    void BndEvt__BP_SkillEffect_IcicleThrow_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentBeginOverlapSignature__DelegateSignature(class UPrimitiveComponent* OverlappedComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult);
    void ExecuteUbergraph_BP_SkillEffect_Commet_Rock(int32 EntryPoint);
}; // Size: 0x460

#endif
