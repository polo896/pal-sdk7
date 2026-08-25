#ifndef UE4SS_SDK_BP_SkillEffect_DarkArrowShoot_2_HPP
#define UE4SS_SDK_BP_SkillEffect_DarkArrowShoot_2_HPP

class ABP_SkillEffect_DarkArrowShoot_2_C : public ABP_SkillEffectBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UNiagaraComponent* NS_FireBlastMuzzle;                                      // 0x0438 (size: 0x8)

    void ReceiveBeginPlay();
    void ReceiveTick(float DeltaSeconds);
    void ExecuteUbergraph_BP_SkillEffect_DarkArrowShoot_2(int32 EntryPoint);
}; // Size: 0x440

#endif
