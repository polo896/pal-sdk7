#ifndef UE4SS_SDK_BP_SkillEffect_Commet_Ring_HPP
#define UE4SS_SDK_BP_SkillEffect_Commet_Ring_HPP

class ABP_SkillEffect_Commet_Ring_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UBoxComponent* Box;                                                         // 0x0438 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0440 (size: 0x8)
    double Duration;                                                                  // 0x0448 (size: 0x8)
    TArray<class AActor*> HitActors;                                                  // 0x0450 (size: 0x10)
    double RingThickness;                                                             // 0x0460 (size: 0x8)
    double ExpandSpeed;                                                               // 0x0468 (size: 0x8)
    double CurrentExpansion;                                                          // 0x0470 (size: 0x8)
    float MaxHitHeight;                                                               // 0x0478 (size: 0x4)
    double HeightBelow;                                                               // 0x0480 (size: 0x8)
    TMap<class AActor*, class UPrimitiveComponent*> CurrentHitableActorMap;           // 0x0488 (size: 0x50)

    void UserConstructionScript();
    void ReceiveBeginPlay();
    void ReceiveTick(float DeltaSeconds);
    void StartFadeRing();
    void BndEvt__BP_SkillEffect_Unique_NightmareFlame_Ring_Box_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(class UPrimitiveComponent* OverlappedComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult);
    void ExecuteUbergraph_BP_SkillEffect_Commet_Ring(int32 EntryPoint);
}; // Size: 0x4D8

#endif
