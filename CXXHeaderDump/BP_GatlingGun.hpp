#ifndef UE4SS_SDK_BP_GatlingGun_HPP
#define UE4SS_SDK_BP_GatlingGun_HPP

class ABP_GatlingGun_C : public ABP_AssaultRifleBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x06C8 (size: 0x8)
    class USkeletalMeshComponent* SkeletalMesh;                                       // 0x06D0 (size: 0x8)

    void BP_GatlingGun_AutoGenFunc(bool IsPlaying);
    void Is UseEjectionPort(bool& isUse);
    void GetAmmoClass(TSubclassOf<class AActor>& AmmoClass);
    void GeyEjectionPortTransform(FTransform& Transform);
    void PlayReloadAnimation();
    void StopFireLoopSound();
    void PlayFireLoopSound();
    void GetTargetPosition(FVector& targetPosition);
    bool IsUseLeftHandAttach();
    FTransform GetLeftHandTransform();
    float GetDefaultBlurAngle();
    void GetMuzzleEffect(class UNiagaraSystem*& NewParam);
    void GetShootInterval(double& Time);
    void GetMuzzleRotator(FRotator& Rotator);
    void GetMuzzleLocation(FVector& MuzzleLocation);
    void OnReleaseTrigger(bool bCanShootOnRelease);
    void OnPullTrigger();
    void ReceiveEndPlay(TEnumAsByte<EEndPlayReason::Type> EndPlayReason);
    void ExecuteUbergraph_BP_GatlingGun(int32 EntryPoint);
}; // Size: 0x6D8

#endif
