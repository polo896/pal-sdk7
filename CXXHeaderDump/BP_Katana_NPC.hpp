#ifndef UE4SS_SDK_BP_Katana_NPC_HPP
#define UE4SS_SDK_BP_Katana_NPC_HPP

class ABP_Katana_NPC_C : public ABP_Bat_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0698 (size: 0x8)

    int32 GetNPCWeaponDamage();
    int32 GetWeaponDamage();
    void ReceiveBeginPlay();
    void ExecuteUbergraph_BP_Katana_NPC(int32 EntryPoint);
}; // Size: 0x6A0

#endif
