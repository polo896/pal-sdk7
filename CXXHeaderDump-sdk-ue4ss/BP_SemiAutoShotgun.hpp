#ifndef UE4SS_SDK_BP_SemiAutoShotgun_HPP
#define UE4SS_SDK_BP_SemiAutoShotgun_HPP

class ABP_SemiAutoShotgun_C : public ABP_PumpActionShotgun_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x06E8 (size: 0x8)
    class UStaticMeshComponent* Ammo2;                                                // 0x06F0 (size: 0x8)
    class UStaticMeshComponent* Ammo1;                                                // 0x06F8 (size: 0x8)

    void OnReloadStart(float InReloadSpeedPlayRate);
    void OnRestartReload();
    void ExecuteUbergraph_BP_SemiAutoShotgun(int32 EntryPoint);
}; // Size: 0x700

#endif
