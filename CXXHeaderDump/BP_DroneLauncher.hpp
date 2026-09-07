#ifndef UE4SS_SDK_BP_DroneLauncher_HPP
#define UE4SS_SDK_BP_DroneLauncher_HPP

class ABP_DroneLauncher_C : public ABP_YakushimaBlade003_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x06C8 (size: 0x8)
    class UBP_DroneLauncher_DroneStaticMesh_C* Drone8;                                // 0x06D0 (size: 0x8)
    class UBP_DroneLauncher_DroneStaticMesh_C* Drone7;                                // 0x06D8 (size: 0x8)
    class UBP_DroneLauncher_DroneStaticMesh_C* Drone6;                                // 0x06E0 (size: 0x8)
    class UBP_DroneLauncher_DroneStaticMesh_C* Drone5;                                // 0x06E8 (size: 0x8)
    class UBP_DroneLauncher_DroneStaticMesh_C* Drone4;                                // 0x06F0 (size: 0x8)
    class UBP_DroneLauncher_DroneStaticMesh_C* Drone2;                                // 0x06F8 (size: 0x8)
    class UBP_DroneLauncher_DroneStaticMesh_C* Drone3;                                // 0x0700 (size: 0x8)
    class UBP_DroneLauncher_DroneStaticMesh_C* Drone1;                                // 0x0708 (size: 0x8)
    class UBP_DroneLauncher_DroneStaticMesh_C* Drone0;                                // 0x0710 (size: 0x8)

    void PlayShootAnim();
    void UpdateDroneVisiblity(bool Instant);
    FTransform GetBladeSpawnTransform();
    void OnPullTrigger();
    void OnDestroyBlade(class AActor* DestroyedActor);
    void OnAttachWeapon(class AActor* attachActor);
    void OnStartAim();
    void SpawnBlade(bool bForce);
    void ExecuteUbergraph_BP_DroneLauncher(int32 EntryPoint);
}; // Size: 0x718

#endif
