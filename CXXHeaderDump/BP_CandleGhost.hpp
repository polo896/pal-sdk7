#ifndef UE4SS_SDK_BP_CandleGhost_HPP
#define UE4SS_SDK_BP_CandleGhost_HPP

class ABP_CandleGhost_C : public ABP_MonsterBase_C
{
    class UBP_PalTimerPointLightComponent_C* BP_PalTimerPointLightComponent;          // 0x0D30 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule2;                        // 0x0D38 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule1;                        // 0x0D40 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule;                         // 0x0D48 (size: 0x8)
    class UPalBodyPartsSphereComponent* PalBodyPartsSphere;                           // 0x0D50 (size: 0x8)

    void GetVisual_ExceptMainMesh_SyncAnyway(TArray<class USceneComponent*>& OutComponent);
}; // Size: 0xD58

#endif
