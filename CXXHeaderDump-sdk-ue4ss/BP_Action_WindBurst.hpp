#ifndef UE4SS_SDK_BP_Action_WindBurst_HPP
#define UE4SS_SDK_BP_Action_WindBurst_HPP

class UBP_Action_WindBurst_C : public UBP_ActionGeneralAttackFarBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x02E8 (size: 0x8)

    void OnSpawnEffect(class APalSkillEffectBase* Effect);
    void OnStartReadyAnimation();
    void ExecuteUbergraph_BP_Action_WindBurst(int32 EntryPoint);
}; // Size: 0x2F0

#endif
