#ifndef UE4SS_SDK_BP_DarkMechaDragon_RAID_HPP
#define UE4SS_SDK_BP_DarkMechaDragon_RAID_HPP

class ABP_DarkMechaDragon_RAID_C : public ABP_DarkMechaDragon_C
{
    class UBP_PalTimerPointLightComponent_C* BP_PalTimerPointLightComponent;          // 0x0D90 (size: 0x8)
    class UBP_PalRideMarkerBiggerHorse_C* BP_PalRideMarkerBiggerHorse1;               // 0x0D98 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule8_0;                      // 0x0DA0 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule7_0;                      // 0x0DA8 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule6_0;                      // 0x0DB0 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule5_0;                      // 0x0DB8 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule4_0;                      // 0x0DC0 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule3_0;                      // 0x0DC8 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule2_0;                      // 0x0DD0 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule1_0;                      // 0x0DD8 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule_0;                       // 0x0DE0 (size: 0x8)

    void GetVisual_ExceptMainMesh_SyncAnyway(TArray<class USceneComponent*>& OutComponent);
}; // Size: 0xDE8

#endif
