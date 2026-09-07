#ifndef UE4SS_SDK_BP_UniqueSkillEffect_ClownRabbit_TrickShow_Fake_HPP
#define UE4SS_SDK_BP_UniqueSkillEffect_ClownRabbit_TrickShow_Fake_HPP

class ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Fake_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UPalFacialComponent* PalFacial;                                             // 0x0438 (size: 0x8)
    class UPalSkeletalMeshComponent* PalSkeletalMesh;                                 // 0x0440 (size: 0x8)
    class AActor* Target Character;                                                   // 0x0448 (size: 0x8)
    class UNiagaraSystem* Warp Effect;                                                // 0x0450 (size: 0x8)
    bool FadeIn;                                                                      // 0x0458 (size: 0x1)
    float Opacity Intensity;                                                          // 0x045C (size: 0x4)

    void ReceiveBeginPlay();
    void ReceiveTick(float DeltaSeconds);
    void SetTargetAndAnim(class USkinnedMeshComponent* NewLeaderBoneComponent, class AActor* TargetCharacter);
    void SetFade();
    void FadeOutEffect(double DeltaSecond);
    void ActFakeAttack();
    void ExecuteUbergraph_BP_UniqueSkillEffect_ClownRabbit_TrickShow_Fake(int32 EntryPoint);
}; // Size: 0x460

#endif
