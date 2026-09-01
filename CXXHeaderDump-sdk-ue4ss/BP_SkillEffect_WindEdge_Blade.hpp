#ifndef UE4SS_SDK_BP_SkillEffect_WindEdge_Blade_HPP
#define UE4SS_SDK_BP_SkillEffect_WindEdge_Blade_HPP

class ABP_SkillEffect_WindEdge_Blade_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UProjectileMovementComponent* ProjectileMovement;                           // 0x0438 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0440 (size: 0x8)
    class UBoxComponent* Box;                                                         // 0x0448 (size: 0x8)

    void ReceiveBeginPlay();
    void SetLifeAndVelocity(double Life, FVector NormalVelocity);
    void End();
    void FadeOutEffect(double DeltaSecond);
    void ExecuteUbergraph_BP_SkillEffect_WindEdge_Blade(int32 EntryPoint);
}; // Size: 0x450

#endif
