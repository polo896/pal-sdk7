#ifndef UE4SS_SDK_BP_MapObject_PickupItem_PalEgg_HPP
#define UE4SS_SDK_BP_MapObject_PickupItem_PalEgg_HPP

class ABP_MapObject_PickupItem_PalEgg_C : public ABP_MapObject_PickupItem_PalEgg_Base_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0470 (size: 0x8)

    FPalObjectPoolParameter GetObjectPoolParameter();
    void InitializeFromPool();
    void ReturnToPool();
    void ExecuteUbergraph_BP_MapObject_PickupItem_PalEgg(int32 EntryPoint);
}; // Size: 0x478

#endif
