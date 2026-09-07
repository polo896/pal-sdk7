#ifndef UE4SS_SDK_BP_UniqueSkillEffect_DomeArmorDragon_ExplosiveMissile_Bullet_HPP
#define UE4SS_SDK_BP_UniqueSkillEffect_DomeArmorDragon_ExplosiveMissile_Bullet_HPP

class ABP_UniqueSkillEffect_DomeArmorDragon_ExplosiveMissile_Bullet_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UPalProjectileMovementComponent* PalProjectileMovement;                     // 0x0438 (size: 0x8)
    class UCapsuleComponent* Capsule;                                                 // 0x0440 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0448 (size: 0x8)
    float MaxLife;                                                                    // 0x0450 (size: 0x4)
    float HomingStrength;                                                             // 0x0454 (size: 0x4)
    double DetonateDistance;                                                          // 0x0458 (size: 0x8)

    void ReceiveBeginPlay();
    void ReceiveTick(float DeltaSeconds);
    void BndEvt__BP_UniqueSkillEffect_DomeArmorDragon_ExplosiveMissile_Bullet_MovementSphereRoot_K2Node_ComponentBoundEvent_0_ComponentHitSignature__DelegateSignature(class UPrimitiveComponent* HitComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, FVector NormalImpulse, const FHitResult& Hit);
    void BndEvt__BP_UniqueSkillEffect_DomeArmorDragon_ExplosiveMissile_Bullet_Capsule_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(class UPrimitiveComponent* OverlappedComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult);
    void Explode();
    void FadeOutEffect(double DeltaSecond);
    void ExecuteUbergraph_BP_UniqueSkillEffect_DomeArmorDragon_ExplosiveMissile_Bullet(int32 EntryPoint);
}; // Size: 0x460

#endif
