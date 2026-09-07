#ifndef UE4SS_SDK_BP_SkillEffect_RipTide_Swirl_HPP
#define UE4SS_SDK_BP_SkillEffect_RipTide_Swirl_HPP

class ABP_SkillEffect_RipTide_Swirl_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UBoxComponent* Box;                                                         // 0x0438 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0440 (size: 0x8)
    double WirlDuration;                                                              // 0x0448 (size: 0x8)
    TMap<class UPrimitiveComponent*, class AActor*> CurrentHitableActorMap;           // 0x0450 (size: 0x50)
    double InitialExpansion;                                                          // 0x04A0 (size: 0x8)
    TArray<class AActor*> HitActors;                                                  // 0x04A8 (size: 0x10)
    float MaxHitHeight;                                                               // 0x04B8 (size: 0x4)
    double HeightBelow;                                                               // 0x04C0 (size: 0x8)
    double CurrentExpansion;                                                          // 0x04C8 (size: 0x8)
    double RingThickness;                                                             // 0x04D0 (size: 0x8)
    double ShrinkSpeed;                                                               // 0x04D8 (size: 0x8)

    void UserConstructionScript();
    void ReceiveBeginPlay();
    void ReceiveTick(float DeltaSeconds);
    void StartFadeRing();
    void BndEvt__BP_SkillEffect_Unique_NightmareFlame_Ring_Box_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(class UPrimitiveComponent* OverlappedComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult);
    void BndEvt__BP_SkillEffect_RipTide_Swirl_Box_K2Node_ComponentBoundEvent_2_ComponentEndOverlapSignature__DelegateSignature(class UPrimitiveComponent* OverlappedComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex);
    void ExecuteUbergraph_BP_SkillEffect_RipTide_Swirl(int32 EntryPoint);
}; // Size: 0x4E0

#endif
