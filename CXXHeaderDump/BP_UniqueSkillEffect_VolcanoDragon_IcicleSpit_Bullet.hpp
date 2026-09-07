#ifndef UE4SS_SDK_BP_UniqueSkillEffect_VolcanoDragon_IcicleSpit_Bullet_HPP
#define UE4SS_SDK_BP_UniqueSkillEffect_VolcanoDragon_IcicleSpit_Bullet_HPP

class ABP_UniqueSkillEffect_VolcanoDragon_IcicleSpit_Bullet_C : public ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0470 (size: 0x8)

    void GetSpitClass(TSubclassOf<class ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Magma_C>& SpitClass);
    void DoFadeEffect();
    void ExecuteUbergraph_BP_UniqueSkillEffect_VolcanoDragon_IcicleSpit_Bullet(int32 EntryPoint);
}; // Size: 0x478

#endif
