#ifndef UE4SS_SDK_BP_ActionTremor_HPP
#define UE4SS_SDK_BP_ActionTremor_HPP

class UBP_ActionTremor_C : public UBP_ActionGeneralAttackFarBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x02E8 (size: 0x8)

    void OnSpawnEffect(class APalSkillEffectBase* Effect);
    void OnStartReadyAnimation();
    void ExecuteUbergraph_BP_ActionTremor(int32 EntryPoint);
}; // Size: 0x2F0

#endif
