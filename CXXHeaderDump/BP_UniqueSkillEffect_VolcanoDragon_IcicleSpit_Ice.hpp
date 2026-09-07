#ifndef UE4SS_SDK_BP_UniqueSkillEffect_VolcanoDragon_IcicleSpit_Ice_HPP
#define UE4SS_SDK_BP_UniqueSkillEffect_VolcanoDragon_IcicleSpit_Ice_HPP

class ABP_UniqueSkillEffect_VolcanoDragon_IcicleSpit_Ice_C : public ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Magma_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0450 (size: 0x8)

    void DoFadeEffect();
    void ExecuteUbergraph_BP_UniqueSkillEffect_VolcanoDragon_IcicleSpit_Ice(int32 EntryPoint);
}; // Size: 0x458

#endif
