#ifndef UE4SS_SDK_BP_SkillEffect_Unique_SheepBall_Roll_HPP
#define UE4SS_SDK_BP_SkillEffect_Unique_SheepBall_Roll_HPP

class ABP_SkillEffect_Unique_SheepBall_Roll_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class USphereComponent* SphereCollision;                                          // 0x0438 (size: 0x8)
    class UNiagaraComponent* DustEffect;                                              // 0x0440 (size: 0x8)
    class UNiagaraComponent* RollEffect;                                              // 0x0448 (size: 0x8)
    FBP_SkillEffect_Unique_SheepBall_Roll_COnHitAttack_Roll OnHitAttack_Roll;         // 0x0450 (size: 0x10)
    void OnHitAttack_Roll();
    TMap<class FName, class UNiagaraComponent*> SkillEffectMap;                       // 0x0460 (size: 0x50)
    double RollEffectOffsetYaw;                                                       // 0x04B0 (size: 0x8)
    double OwnerHeight;                                                               // 0x04B8 (size: 0x8)

    void SetOwnerCapsuleHeight(double Height);
    void GetRollEffectLocation(FVector& Location);
    void ActivateEffect(FName EffectName);
    void InitializeEffects();
    void ReceiveBeginPlay();
    void FadeOutEffect(double DeltaSecond);
    void ReceiveTick(float DeltaSeconds);
    void HitAttack(class AActor* Defencer, FPalDamageInfo DamageInfo, int32 HitCount, class UPrimitiveComponent* AttackerComponent);
    void ExecuteUbergraph_BP_SkillEffect_Unique_SheepBall_Roll(int32 EntryPoint);
    void OnHitAttack_Roll__DelegateSignature();
}; // Size: 0x4C0

#endif
