#ifndef UE4SS_SDK_BP_Bowgun_NPC_HPP
#define UE4SS_SDK_BP_Bowgun_NPC_HPP

class ABP_Bowgun_NPC_C : public ABP_Bowgun_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x06F0 (size: 0x8)

    void GetBulletClass(TSubclassOf<class APalBullet>& NewParam);
    int32 GetNPCWeaponDamage();
    int32 GetWeaponDamage();
    void BPI_OnReload();
    void ExecuteUbergraph_BP_Bowgun_NPC(int32 EntryPoint);
}; // Size: 0x6F8

#endif
