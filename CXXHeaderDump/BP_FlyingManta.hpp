#ifndef UE4SS_SDK_BP_FlyingManta_HPP
#define UE4SS_SDK_BP_FlyingManta_HPP

class ABP_FlyingManta_C : public ABP_MonsterBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0D30 (size: 0x8)
    class UPalFlyMeshHeightCtrlComponent* PalFlyMeshHeightCtrl;                       // 0x0D38 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule2;                        // 0x0D40 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule1;                        // 0x0D48 (size: 0x8)
    class UPalBodyPartsSphereComponent* PalBodyPartsSphere1;                          // 0x0D50 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule;                         // 0x0D58 (size: 0x8)

    void ReceiveBeginPlay();
    void ExecuteUbergraph_BP_FlyingManta(int32 EntryPoint);
}; // Size: 0xD60

#endif
