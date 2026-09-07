#ifndef UE4SS_SDK_BP_DroneLauncher_DroneStaticMesh_HPP
#define UE4SS_SDK_BP_DroneLauncher_DroneStaticMesh_HPP

class UBP_DroneLauncher_DroneStaticMesh_C : public UStaticMeshComponent
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x05F0 (size: 0x8)
    bool Hidden;                                                                      // 0x05F8 (size: 0x1)
    float Delta Seconds;                                                              // 0x05FC (size: 0x4)
    double Temp;                                                                      // 0x0600 (size: 0x8)

    void ReceiveTick(float DeltaSeconds);
    void Hide();
    void Show();
    void ExecuteUbergraph_BP_DroneLauncher_DroneStaticMesh(int32 EntryPoint);
}; // Size: 0x608

#endif
