#ifndef UE4SS_SDK_BP_ElectricArc_Spawner_HPP
#define UE4SS_SDK_BP_ElectricArc_Spawner_HPP

class ABP_ElectricArc_Spawner_C : public ABP_NormalBullet_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0438 (size: 0x8)
    FHitResult Hit;                                                                   // 0x0440 (size: 0xE8)
    int32 MaxArcHit;                                                                  // 0x0528 (size: 0x4)
    TArray<class AActor*> HitActor;                                                   // 0x0530 (size: 0x10)
    class AActor* TargetActor;                                                        // 0x0540 (size: 0x8)
    float ArcRadius;                                                                  // 0x0548 (size: 0x4)
    FTransform StartTransform;                                                        // 0x0550 (size: 0x60)
    class AActor* Hit Actor;                                                          // 0x05B0 (size: 0x8)
    TArray<class AActor*> TargetArray;                                                // 0x05B8 (size: 0x10)
    bool IsHit;                                                                       // 0x05C8 (size: 0x1)

    void GetHitEffect(class UNiagaraSystem*& NiagaraEffect);
    void ReceiveBeginPlay();
    void OnHit(class UPrimitiveComponent* HitComp, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, const FHitResult& Hit);
    void ArcLoopBreak();
    void ReceiveEndPlay(TEnumAsByte<EEndPlayReason::Type> EndPlayReason);
    void ExecuteUbergraph_BP_ElectricArc_Spawner(int32 EntryPoint);
}; // Size: 0x5C9

#endif
