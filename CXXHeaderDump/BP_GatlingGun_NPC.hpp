#ifndef UE4SS_SDK_BP_GatlingGun_NPC_HPP
#define UE4SS_SDK_BP_GatlingGun_NPC_HPP

class ABP_GatlingGun_NPC_C : public ABP_GatlingGun_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x06D8 (size: 0x8)

    void PlayReloadAnimation();
    FTransform GetLeftHandTransform();
    int32 GetNPCWeaponDamage();
    int32 GetWeaponDamage();
    void BPI_OnReload();
    void ExecuteUbergraph_BP_GatlingGun_NPC(int32 EntryPoint);
}; // Size: 0x6E0

#endif
