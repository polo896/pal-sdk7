#ifndef UE4SS_SDK_BP_NPCWeaponGenerator_GrassBoss_HPP
#define UE4SS_SDK_BP_NPCWeaponGenerator_GrassBoss_HPP

class UBP_NPCWeaponGenerator_GrassBoss_C : public UPalNPCWeaponGenerator
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x00E8 (size: 0x8)

    void OnSpawnEvent(class APalWeaponBase* WeaponActor);
    void ExecuteUbergraph_BP_NPCWeaponGenerator_GrassBoss(int32 EntryPoint);
}; // Size: 0xF0

#endif
