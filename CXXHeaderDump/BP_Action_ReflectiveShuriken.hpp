#ifndef UE4SS_SDK_BP_Action_ReflectiveShuriken_HPP
#define UE4SS_SDK_BP_Action_ReflectiveShuriken_HPP

class UBP_Action_ReflectiveShuriken_C : public UBP_ActionGeneralAttackFarBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x02E8 (size: 0x8)

    void OnSpawnEffect(class APalSkillEffectBase* Effect);
    void OnBeginAction();
    void ExecuteUbergraph_BP_Action_ReflectiveShuriken(int32 EntryPoint);
}; // Size: 0x2F0

#endif
