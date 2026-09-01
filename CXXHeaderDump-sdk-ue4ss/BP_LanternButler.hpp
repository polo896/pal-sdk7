#ifndef UE4SS_SDK_BP_LanternButler_HPP
#define UE4SS_SDK_BP_LanternButler_HPP

class ABP_LanternButler_C : public ABP_MonsterBase_C
{
    class UBP_PalTimerPointLightComponent_C* BP_PalTimerPointLightComponent;          // 0x0D30 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule7;                        // 0x0D38 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule6;                        // 0x0D40 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule5;                        // 0x0D48 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule4;                        // 0x0D50 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule3;                        // 0x0D58 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule2;                        // 0x0D60 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule1;                        // 0x0D68 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule;                         // 0x0D70 (size: 0x8)

    void GetVisual_ExceptMainMesh_SyncAnyway(TArray<USceneComponent*>& OutComponent);
}; // Size: 0xD78

#endif
