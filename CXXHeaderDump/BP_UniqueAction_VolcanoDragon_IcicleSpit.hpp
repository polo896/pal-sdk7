#ifndef UE4SS_SDK_BP_UniqueAction_VolcanoDragon_IcicleSpit_HPP
#define UE4SS_SDK_BP_UniqueAction_VolcanoDragon_IcicleSpit_HPP

class UBP_UniqueAction_VolcanoDragon_IcicleSpit_C : public UBP_UniqueAction_VolcanoDragon_MagmaSpit_C
{

    void GetMuzzleEffect(class UNiagaraSystem*& Niagara);
    void GetManagerClass(TSubclassOf<class ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_MagmaManager_C>& ManagerClass);
    void GetBulletClass(TSubclassOf<class ABP_UniqueSkillEffect_VolcanoDragon_MagmaSpit_Bullet_C>& BulletClass);
}; // Size: 0x2E0

#endif
