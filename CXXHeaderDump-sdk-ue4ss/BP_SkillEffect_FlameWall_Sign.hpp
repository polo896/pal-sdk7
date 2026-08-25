#ifndef UE4SS_SDK_BP_SkillEffect_FlameWall_Sign_HPP
#define UE4SS_SDK_BP_SkillEffect_FlameWall_Sign_HPP

class ABP_SkillEffect_FlameWall_Sign_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UNiagaraComponent* OmenEffect;                                              // 0x0438 (size: 0x8)
    double SpawnWallTime;                                                             // 0x0440 (size: 0x8)
    double SpawnEmberTime;                                                            // 0x0448 (size: 0x8)

    void ReceiveBeginPlay();
    void OnSetPredictLocation(FVector Location);
    void SpawnWall();
    void SpawnEmber();
    void BndEvt__BP_SkillEffect_FlameWall_Sign_OmenEffect_K2Node_ComponentBoundEvent_0_OnNiagaraSystemFinished__DelegateSignature(class UNiagaraComponent* PSystem);
    void ExecuteUbergraph_BP_SkillEffect_FlameWall_Sign(int32 EntryPoint);
}; // Size: 0x450

#endif
