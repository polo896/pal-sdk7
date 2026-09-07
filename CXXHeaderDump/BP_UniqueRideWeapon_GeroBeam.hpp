#ifndef UE4SS_SDK_BP_UniqueRideWeapon_GeroBeam_HPP
#define UE4SS_SDK_BP_UniqueRideWeapon_GeroBeam_HPP

class ABP_UniqueRideWeapon_GeroBeam_C : public APalUniqueRideWeaponBase
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x06B8 (size: 0x8)
    class UStaticMeshComponent* SM_PrismTower_AT;                                     // 0x06C0 (size: 0x8)
    class UStaticMeshComponent* SM_PrismTower_B;                                      // 0x06C8 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x06D0 (size: 0x8)
    bool IsShootingProgress;                                                          // 0x06D8 (size: 0x1)
    double ConstBeamMaxRange;                                                         // 0x06E0 (size: 0x8)
    double BeamLength;                                                                // 0x06E8 (size: 0x8)
    class UPalHitFilter* HitFilter;                                                   // 0x06F0 (size: 0x8)
    class ABP_GeroBeamAttackCollision_C* AttackCollisionActor;                        // 0x06F8 (size: 0x8)
    bool IsBeamEmitting;                                                              // 0x0700 (size: 0x1)
    TEnumAsByte<EDrawDebugTrace::Type> Debug;                                         // 0x0701 (size: 0x1)
    class UNiagaraSystem* Niagara_Charge;                                             // 0x0708 (size: 0x8)
    class UNiagaraSystem* Niagara_DamageHit;                                          // 0x0710 (size: 0x8)
    class UNiagaraSystem* Niagara_GroundHit;                                          // 0x0718 (size: 0x8)
    FVector BeamDirection;                                                            // 0x0720 (size: 0x18)
    double ConstBeamTime;                                                             // 0x0738 (size: 0x8)
    class UNiagaraComponent* NS_Component_GroundHit;                                  // 0x0740 (size: 0x8)
    TMap<class AActor*, class UNiagaraComponent*> HitActorMap;                        // 0x0748 (size: 0x50)

    void OnEndHit(class UPrimitiveComponent* MyHitComponent, class AActor* OtherHitActor, class UPrimitiveComponent* OtherHitComponent);
    void DeleteAllEffect();
    void OnHit_Damage(class UPrimitiveComponent* MyHitComponent, class AActor* OtherHitActor, class UPrimitiveComponent* OtherHitComponent, const TArray<int32>& FoliageIndex, FVector HitLocation, int32 HitCount);
    void CharacterHitEffectPos(class AActor* TargetActor, FVector& EffectPos);
    void ShootingExit();
    void ShootingEnter();
    FRotator GetMuzzleRotation();
    FVector GetMuzzleLocation();
    void BeamControl();
    void ReceiveTick(float DeltaSeconds);
    void OnPullTrigger();
    void ReceiveBeginPlay();
    void Hit(class UPrimitiveComponent* MyHitComponent, class AActor* OtherHitActor, class UPrimitiveComponent* OtherHitComponent, const TArray<int32>& FoliageIndex, FVector HitLocation, int32 HitCount);
    void ReceiveEndPlay(TEnumAsByte<EEndPlayReason::Type> EndPlayReason);
    void OnCancellShooting();
    void ExecuteUbergraph_BP_UniqueRideWeapon_GeroBeam(int32 EntryPoint);
}; // Size: 0x798

#endif
