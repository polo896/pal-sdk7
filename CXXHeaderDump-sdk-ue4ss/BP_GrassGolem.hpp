#ifndef UE4SS_SDK_BP_GrassGolem_HPP
#define UE4SS_SDK_BP_GrassGolem_HPP

class ABP_GrassGolem_C : public ABP_MonsterBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0D30 (size: 0x8)
    class UPalSpeedCollisionComponent* PalSpeedCollision;                             // 0x0D38 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule9;                        // 0x0D40 (size: 0x8)
    class UBP_PalTimerPointLightComponent_C* BP_PalTimerPointLightComponent;          // 0x0D48 (size: 0x8)
    class UPalShooterComponent* PalShooter;                                           // 0x0D50 (size: 0x8)
    class UBP_PalRideMarkerSit_C* BP_PalRideMarkerSit;                                // 0x0D58 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule8;                        // 0x0D60 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule7;                        // 0x0D68 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule6;                        // 0x0D70 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule5;                        // 0x0D78 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule4;                        // 0x0D80 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule3;                        // 0x0D88 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule2;                        // 0x0D90 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule1;                        // 0x0D98 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule;                         // 0x0DA0 (size: 0x8)

    void GetVisual_ExceptMainMesh_SyncAnyway(TArray<class USceneComponent*>& OutComponent);
    void ReceiveBeginPlay();
    void OnStartRagdollDelegate_イベント();
    void OnEndRagdollDelegate_イベント();
    void ExecuteUbergraph_BP_GrassGolem(int32 EntryPoint);
}; // Size: 0xDA8

#endif
