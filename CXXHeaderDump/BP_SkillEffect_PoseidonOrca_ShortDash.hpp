#ifndef UE4SS_SDK_BP_SkillEffect_PoseidonOrca_ShortDash_HPP
#define UE4SS_SDK_BP_SkillEffect_PoseidonOrca_ShortDash_HPP

class ABP_SkillEffect_PoseidonOrca_ShortDash_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class USphereComponent* Sphere;                                                   // 0x0438 (size: 0x8)
    class UNiagaraComponent* NiagaraEffect;                                           // 0x0440 (size: 0x8)

    void FadeOutEffect(double DeltaSecond);
    void OnEndAction();
    void ReceiveBeginPlay();
    void BndEvt__BP_SkillEffectShadowBall_AttackFilter_K2Node_ComponentBoundEvent_1_OnAttackDelegate__DelegateSignature(class AActor* Defencer, FPalDamageInfo DamageInfo, int32 HitCount, class UPrimitiveComponent* AttackerComponent);
    void ExecuteUbergraph_BP_SkillEffect_PoseidonOrca_ShortDash(int32 EntryPoint);
}; // Size: 0x448

#endif
