#ifndef UE4SS_SDK_BP_BeamLauncher_HPP
#define UE4SS_SDK_BP_BeamLauncher_HPP

class ABP_BeamLauncher_C : public ABP_OverheatRifle_C
{

    void StopFireSound();
    void PlayFireSound();
    void PlayEndFireSound();
    void OnShoot(class APalBullet* BulletActor);
    void GetShootInterval(double& Time);
}; // Size: 0x758

#endif
