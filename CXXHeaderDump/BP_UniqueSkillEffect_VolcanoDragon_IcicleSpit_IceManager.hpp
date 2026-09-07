#ifndef UE4SS_SDK_BP_UniqueSkillEffect_VolcanoDragon_IcicleSpit_IceManager_HPP
#define UE4SS_SDK_BP_UniqueSkillEffect_VolcanoDragon_IcicleSpit_IceManager_HPP

class ABP_UniqueSkillEffect_VolcanoDragon_IcicleSpit_IceManager_C : public ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_MagmaManager_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)

    void BndEvt__BP_UniqueSkillEffect_VolcanoDragon_IceLaser_DamageManager_AttackFilter_K2Node_ComponentBoundEvent_0_OnAttackDelegate__DelegateSignature(class AActor* Defencer, FPalDamageInfo DamageInfo, int32 HitCount, class UPrimitiveComponent* AttackerComponent);
    void ExecuteUbergraph_BP_UniqueSkillEffect_VolcanoDragon_IcicleSpit_IceManager(int32 EntryPoint);
}; // Size: 0x438

#endif
