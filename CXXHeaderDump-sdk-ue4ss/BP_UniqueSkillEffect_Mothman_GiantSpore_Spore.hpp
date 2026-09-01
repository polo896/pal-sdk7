#ifndef UE4SS_SDK_BP_UniqueSkillEffect_Mothman_GiantSpore_Spore_HPP
#define UE4SS_SDK_BP_UniqueSkillEffect_Mothman_GiantSpore_Spore_HPP

class ABP_UniqueSkillEffect_Mothman_GiantSpore_Spore_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UPalProjectileMovementComponent* PalProjectileMovement;                     // 0x0438 (size: 0x8)
    class USphereComponent* Sphere;                                                   // 0x0440 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0448 (size: 0x8)
    float MaxLife;                                                                    // 0x0450 (size: 0x4)

    void ReceiveBeginPlay();
    void BndEvt__BP_UniqueSkillEffect_Mothman_GiantSpore_Spore_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(class UPrimitiveComponent* HitComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
    void BndEvt__BP_UniqueSkillEffect_Mothman_GiantSpore_Spore_Sphere_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(class UPrimitiveComponent* OverlappedComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult);
    void Shoot();
    void EndLife();
    void FadeOutEffect(double DeltaSecond);
    void SetCancel();
    void ExecuteUbergraph_BP_UniqueSkillEffect_Mothman_GiantSpore_Spore(int32 EntryPoint);
}; // Size: 0x454

#endif
