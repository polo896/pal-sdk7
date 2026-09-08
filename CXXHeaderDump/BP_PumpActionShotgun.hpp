#ifndef UE4SS_SDK_BP_PumpActionShotgun_HPP
#define UE4SS_SDK_BP_PumpActionShotgun_HPP

class ABP_PumpActionShotgun_C : public ABP_ShotgunBase_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x06C8 (size: 0x8)
    class UAnimMontage* Montage to Play;                                              // 0x06D0 (size: 0x8)
    class UAnimSequence* FireAnim;                                                    // 0x06D8 (size: 0x8)
    double ReloadSpeedPlayRate;                                                       // 0x06E0 (size: 0x8)

    void EjectARound();
    bool IsUseLeftHandAttach();
    void OnshotInternal(bool& IsShoted);
    void PlayReloadAnimation();
    void OnNotifyEnd_FCB44FF643DA97B49C538D845683A965(FName NotifyName);
    void OnNotifyBegin_FCB44FF643DA97B49C538D845683A965(FName NotifyName);
    void OnInterrupted_FCB44FF643DA97B49C538D845683A965(FName NotifyName);
    void OnBlendOut_FCB44FF643DA97B49C538D845683A965(FName NotifyName);
    void OnCompleted_FCB44FF643DA97B49C538D845683A965(FName NotifyName);
    void OnNotifyEnd_022E6E364FB50AA73CEBFDBEFEDC6736(FName NotifyName);
    void OnNotifyBegin_022E6E364FB50AA73CEBFDBEFEDC6736(FName NotifyName);
    void OnInterrupted_022E6E364FB50AA73CEBFDBEFEDC6736(FName NotifyName);
    void OnBlendOut_022E6E364FB50AA73CEBFDBEFEDC6736(FName NotifyName);
    void OnCompleted_022E6E364FB50AA73CEBFDBEFEDC6736(FName NotifyName);
    void OnReloadStart(float InReloadSpeedPlayRate);
    void OnReleaseTrigger(bool bCanShootOnRelease);
    void ReceiveBeginPlay();
    void OnWeaponNotify(EWeaponNotifyType Type);
    void OnShot();
    void OnRestartReload();
    void ExecuteUbergraph_BP_PumpActionShotgun(int32 EntryPoint);
}; // Size: 0x6E8

#endif
