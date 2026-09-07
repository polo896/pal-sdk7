#ifndef UE4SS_SDK_BP_DroneLauncher_Drone_HPP
#define UE4SS_SDK_BP_DroneLauncher_Drone_HPP

class ABP_DroneLauncher_Drone_C : public ABP_YakushimaBlade003_Blade_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x06A8 (size: 0x8)
    class UBP_DroneLauncher_DroneStaticMesh_C* BP_DroneLauncher_DroneStaticMesh;      // 0x06B0 (size: 0x8)

    void GetDefaultPosition(FVector& Location, FRotator& Rotator);
    void ReceiveBeginPlay();
    void FadeOutEffect();
    void ReceiveTick(float DeltaSeconds);
    void ExecuteUbergraph_BP_DroneLauncher_Drone(int32 EntryPoint);
}; // Size: 0x6B8

#endif
