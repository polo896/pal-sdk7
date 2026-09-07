#ifndef UE4SS_SDK_BP_ElecPanda_Gym_HPP
#define UE4SS_SDK_BP_ElecPanda_Gym_HPP

class ABP_ElecPanda_Gym_C : public ABP_ElecPanda_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0D68 (size: 0x8)
    class UPalRideMarkerComponent* PalRideMarker_0;                                   // 0x0D70 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule3;                        // 0x0D78 (size: 0x8)
    class UBP_PalBossNPCMarker_C* BP_PalBossNPCMarker;                                // 0x0D80 (size: 0x8)

    class USkeletalMeshComponent* GetRideNPCMesh();
    void ReceiveBeginPlay();
    void ExecuteUbergraph_BP_ElecPanda_Gym(int32 EntryPoint);
}; // Size: 0xD88

#endif
