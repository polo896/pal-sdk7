#ifndef UE4SS_SDK_BP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_HPP
#define UE4SS_SDK_BP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_HPP

class ABP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UBoxComponent* Box;                                                         // 0x0438 (size: 0x8)
    class UCapsuleComponent* Capsule;                                                 // 0x0440 (size: 0x8)
    class UNiagaraComponent* Niagara;                                                 // 0x0448 (size: 0x8)
    float ChargeTime;                                                                 // 0x0450 (size: 0x4)
    bool EnablePull;                                                                  // 0x0454 (size: 0x1)
    TArray<class APalCharacter*> OverlappedActors;                                    // 0x0458 (size: 0x10)
    double PullRadius;                                                                // 0x0468 (size: 0x8)
    double PullVelocity;                                                              // 0x0470 (size: 0x8)
    double AttractAlpha;                                                              // 0x0478 (size: 0x8)

    void CalcZInRange(class APalCharacter* Character, bool& InRange);
    void ReceiveTick(float DeltaSeconds);
    void UserConstructionScript();
    void ReceiveBeginPlay();
    void Activate();
    void FadeOutEffect(double DeltaSecond);
    void SetFade();
    void BndEvt__BP_SkillEffect_ThunderStorm_Storm_Niagara_K2Node_ComponentBoundEvent_0_OnNiagaraSystemFinished__DelegateSignature(class UNiagaraComponent* PSystem);
    void BndEvt__BP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm_Box_K2Node_ComponentBoundEvent_1_ComponentBeginOverlapSignature__DelegateSignature(class UPrimitiveComponent* OverlappedComponent, class AActor* OtherActor, class UPrimitiveComponent* OtherComp, int32 OtherBodyIndex, bool bFromSweep, const FHitResult& SweepResult);
    void SetLife(double Life);
    void ExecuteUbergraph_BP_UniqueSkillEffect_BlueSkyDragon_DrainStorm_Storm(int32 EntryPoint);
}; // Size: 0x480

#endif
