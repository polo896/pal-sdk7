#ifndef UE4SS_SDK_BP_Handgun_NPC_HPP
#define UE4SS_SDK_BP_Handgun_NPC_HPP

class ABP_Handgun_NPC_C : public ABP_HandGun_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x06E8 (size: 0x8)

    float GetDefaultBlurAngle();
    int32 GetNPCWeaponDamage();
    void GetBulletClass_0(TSubclassOf<class APalBullet>& NewParam);
    int32 GetWeaponDamage();
    void OnPullTrigger();
    void BPI_OnReload();
    void ExecuteUbergraph_BP_Handgun_NPC(int32 EntryPoint);
}; // Size: 0x6F0

#endif
