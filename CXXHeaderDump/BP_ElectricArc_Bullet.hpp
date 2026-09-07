#ifndef UE4SS_SDK_BP_ElectricArc_Bullet_HPP
#define UE4SS_SDK_BP_ElectricArc_Bullet_HPP

class ABP_ElectricArc_Bullet_C : public ABP_NormalBullet_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0438 (size: 0x8)
    FTransform StartTransform;                                                        // 0x0440 (size: 0x60)

    void GetHitEffect(class UNiagaraSystem*& NiagaraEffect);
    void ReceiveBeginPlay();
    void OnHit(class UPrimitiveComponent* HitComp, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, const FHitResult& Hit);
    void ExecuteUbergraph_BP_ElectricArc_Bullet(int32 EntryPoint);
}; // Size: 0x4A0

#endif
