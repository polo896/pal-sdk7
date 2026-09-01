#ifndef UE4SS_SDK_BP_NaughtyCat_HPP
#define UE4SS_SDK_BP_NaughtyCat_HPP

class ABP_NaughtyCat_C : public ABP_MonsterBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0D30 (size: 0x8)
    class UPalSpeedCollisionComponent* PalSpeedCollision1;                            // 0x0D38 (size: 0x8)
    class UPalBodyPartsSphereComponent* PalBodyPartsSphere;                           // 0x0D40 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule;                         // 0x0D48 (size: 0x8)
    class UBP_PalRideMarkerSit_C* BP_PalRideMarkerSit;                                // 0x0D50 (size: 0x8)
    class UMaterialInstanceDynamic* EyeMaterial;                                      // 0x0D58 (size: 0x8)

    void ReceiveBeginPlay();
    void ChangeBattle(bool bIsBattleMode);
    void ExecuteUbergraph_BP_NaughtyCat(int32 EntryPoint);
}; // Size: 0xD60

#endif
