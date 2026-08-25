#ifndef UE4SS_SDK_BP_SkillEffect_IceBlade_HPP
#define UE4SS_SDK_BP_SkillEffect_IceBlade_HPP

class ABP_SkillEffect_IceBlade_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UPalProjectileMovementComponent* PalProjectileMovement;                     // 0x0438 (size: 0x8)
    class UNiagaraComponent* NS_CommonSkill_IceBlade;                                 // 0x0440 (size: 0x8)
    TArray<class USphereComponent*> Collisions;                                       // 0x0448 (size: 0x10)
    double AlignRadius;                                                               // 0x0458 (size: 0x8)
    int32 Width;                                                                      // 0x0460 (size: 0x4)
    double SphereSize;                                                                // 0x0468 (size: 0x8)
    double EffectDuration;                                                            // 0x0470 (size: 0x8)

    void UserConstructionScript();
    void ReceiveBeginPlay();
    void BndEvt__BP_SkillEffect_WindCutter_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(class UPrimitiveComponent* HitComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
    void OnHitGround();
    void EffectTimeout();
    void FadeOutEffect(double DeltaSecond);
    void ExecuteUbergraph_BP_SkillEffect_IceBlade(int32 EntryPoint);
}; // Size: 0x478

#endif
