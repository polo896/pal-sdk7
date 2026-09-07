#ifndef UE4SS_SDK_BP_ActionWindCutter_HPP
#define UE4SS_SDK_BP_ActionWindCutter_HPP

class UBP_ActionWindCutter_C : public UBP_ActionGeneralAttackFarBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x02E8 (size: 0x8)
    FSkillEffectSpawnParameter WhenRiddenGeneralParams;                               // 0x02F0 (size: 0x38)

    void TEST(class AActor* Bullet);
    void OnSpawnEffect(class APalSkillEffectBase* Effect);
    void OnSpawnBullet(class AActor* Bullet);
    void ExecuteUbergraph_BP_ActionWindCutter(int32 EntryPoint);
}; // Size: 0x328

#endif
