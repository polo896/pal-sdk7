#ifndef UE4SS_SDK_BP_UniqueRideWeapon_MultiMissile_HPP
#define UE4SS_SDK_BP_UniqueRideWeapon_MultiMissile_HPP

class ABP_UniqueRideWeapon_MultiMissile_C : public ABP_UniqueRideWeapon_RapidBase_C
{
    class UStaticMeshComponent* SM_Missile7;                                          // 0x06D0 (size: 0x8)
    class UStaticMeshComponent* SM_Missile13;                                         // 0x06D8 (size: 0x8)
    class UStaticMeshComponent* SM_Missile12;                                         // 0x06E0 (size: 0x8)
    class UStaticMeshComponent* SM_Missile11;                                         // 0x06E8 (size: 0x8)
    class UStaticMeshComponent* SM_Missile10;                                         // 0x06F0 (size: 0x8)
    class UStaticMeshComponent* SM_Missile9;                                          // 0x06F8 (size: 0x8)
    class UStaticMeshComponent* SM_Missile8;                                          // 0x0700 (size: 0x8)
    class UStaticMeshComponent* SM_Missile6;                                          // 0x0708 (size: 0x8)
    class UStaticMeshComponent* SM_Missile5;                                          // 0x0710 (size: 0x8)
    class UStaticMeshComponent* SM_Missile4;                                          // 0x0718 (size: 0x8)
    class UStaticMeshComponent* SM_Missile3;                                          // 0x0720 (size: 0x8)
    class UStaticMeshComponent* SM_Missile2;                                          // 0x0728 (size: 0x8)
    class UStaticMeshComponent* SM_Missile1;                                          // 0x0730 (size: 0x8)
    class UStaticMeshComponent* SM_Missile;                                           // 0x0738 (size: 0x8)
    class UStaticMeshComponent* SM_MultiMissle_Launcher_R;                            // 0x0740 (size: 0x8)
    class UStaticMeshComponent* SM_MultiMissle_Launcher_L;                            // 0x0748 (size: 0x8)
    TArray<FFMissileMuzzleList> MuzzleList;                                           // 0x0750 (size: 0x10)
    int32 MuzzleIndex;                                                                // 0x0760 (size: 0x4)
    FTimerHandle ShotIntervalTimerHandle;                                             // 0x0768 (size: 0x8)
    double MissileBlur;                                                               // 0x0770 (size: 0x8)

    void GetAllMeshComponent(TArray<class UMeshComponent*>& OutMesh);
    void ShootBulletBP();
    void GetShootInterval(double& Time);
    void ShootMiso();
}; // Size: 0x778

#endif
