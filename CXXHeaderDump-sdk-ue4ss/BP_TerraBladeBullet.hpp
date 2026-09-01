#ifndef UE4SS_SDK_BP_TerraBladeBullet_HPP
#define UE4SS_SDK_BP_TerraBladeBullet_HPP

class ABP_TerraBladeBullet_C : public ABP_AttackBulletBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0420 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0428 (size: 0x8)
    class UBoxComponent* Box;                                                         // 0x0430 (size: 0x8)
    TArray<AActor*> HittedActors;                                                     // 0x0438 (size: 0x10)
    bool IsFading;                                                                    // 0x0448 (size: 0x1)
    float Life;                                                                       // 0x044C (size: 0x4)
    float destroyTime;                                                                // 0x0450 (size: 0x4)

    bool IsDestroy(class UPrimitiveComponent* HitComp, class AActor* OtherCharacter, class UPrimitiveComponent* OtherComp, const FHitResult& Hit);
    void ReceiveBeginPlay();
    void SetLRRot(bool RotRight);
    void BndEvt__BP_TerraBladeBullet_Box_K2Node_ComponentBoundEvent_0_ComponentBeginOverlapSignature__DelegateSignature(class UPrimitiveComponent* OverlappedComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult);
    void BeginFade();
    void ExecuteUbergraph_BP_TerraBladeBullet(int32 EntryPoint);
}; // Size: 0x454

#endif
