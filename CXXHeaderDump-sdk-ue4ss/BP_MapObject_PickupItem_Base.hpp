#ifndef UE4SS_SDK_BP_MapObject_PickupItem_Base_HPP
#define UE4SS_SDK_BP_MapObject_PickupItem_Base_HPP

class ABP_MapObject_PickupItem_Base_C : public APalMapLevelObject
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0430 (size: 0x8)
    class UPalInteractableSphereComponentNative* BP_InteractableSphere;               // 0x0438 (size: 0x8)
    class USphereComponent* Sphere;                                                   // 0x0440 (size: 0x8)

    void ReceiveBeginPlay();
    void ExecuteUbergraph_BP_MapObject_PickupItem_Base(int32 EntryPoint);
}; // Size: 0x448

#endif
