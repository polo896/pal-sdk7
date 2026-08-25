#ifndef UE4SS_SDK_BP_UniqueRideWeapon_ArmLaser_HPP
#define UE4SS_SDK_BP_UniqueRideWeapon_ArmLaser_HPP

class ABP_UniqueRideWeapon_ArmLaser_C : public APalUniqueRideWeaponBase
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x06B8 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x06C0 (size: 0x8)
    double ChargeTime;                                                                // 0x06C8 (size: 0x8)
    double BeamDuration;                                                              // 0x06D0 (size: 0x8)
    FTimerHandle ChargeTimer;                                                         // 0x06D8 (size: 0x8)
    class ABP_SkillEffect_GrassGolem_PartnerSkill_Charge_C* ChargeEffect;             // 0x06E0 (size: 0x8)
    class ABP_SkillEffect_GrassGolem_PartnerSkill_Laser_C* LaserEffect;               // 0x06E8 (size: 0x8)
    FTimerHandle LaserActTimer;                                                       // 0x06F0 (size: 0x8)
    bool LaserActed;                                                                  // 0x06F8 (size: 0x1)
    bool ChargeShake;                                                                 // 0x06F9 (size: 0x1)

    void ReceiveTick(float DeltaSeconds);
    void GetLaserEffect(TSubclassOf<class ABP_SkillEffect_GrassGolem_PartnerSkill_Laser_C>& LaserEffect);
    void GetChargeEffect(TSubclassOf<class ABP_SkillEffect_GrassGolem_PartnerSkill_Charge_C>& ChargeEffect);
    void ReceiveBeginPlay();
    void OnPullTrigger();
    void OnReleaseTrigger(bool bCanShootOnRelease);
    void ActLaser();
    void EndLaser();
    void EndCharge();
    void ExecuteUbergraph_BP_UniqueRideWeapon_ArmLaser(int32 EntryPoint);
}; // Size: 0x6FA

#endif
