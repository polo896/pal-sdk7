#ifndef UE4SS_SDK_BP_ShotgunBullet_Laser_HPP
#define UE4SS_SDK_BP_ShotgunBullet_Laser_HPP

class ABP_ShotgunBullet_Laser_C : public ABP_ShotgunBullet_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0440 (size: 0x8)
    class UNiagaraComponent* Laser;                                                   // 0x0448 (size: 0x8)

    void ReceiveBeginPlay();
    void ReceiveTick(float DeltaSeconds);
    void ExecuteUbergraph_BP_ShotgunBullet_Laser(int32 EntryPoint);
}; // Size: 0x450

#endif
