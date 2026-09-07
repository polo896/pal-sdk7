#ifndef UE4SS_SDK_BP_PalFishingComponent_HPP
#define UE4SS_SDK_BP_PalFishingComponent_HPP

class UBP_PalFishingComponent_C : public UPalFishingComponent
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x03B0 (size: 0x8)
    class APalCutsceneActor* CutsceneActor;                                           // 0x03B8 (size: 0x8)
    TSubclassOf<class APalCutsceneActor> TargetCutsceneActor;                         // 0x03C0 (size: 0x8)
    class UPalCutsceneComponent* CutsceneComponent;                                   // 0x03C8 (size: 0x8)
    FVector CutsceneOffsetLocation;                                                   // 0x03D0 (size: 0x18)
    FPalFishingCutsceneInfo FishingCutsceneInfo;                                      // 0x03E8 (size: 0xD8)
    bool IsHideWeapon;                                                                // 0x04C0 (size: 0x1)
    FName flagName;                                                                   // 0x04C4 (size: 0x8)
    class UPalShooterComponent* ShooterComponent;                                     // 0x04D0 (size: 0x8)
    bool IsStartCutscene;                                                             // 0x04D8 (size: 0x1)

    void GetPlayerFootLocation(FVector SocketLocation, FVector& FloorLocation);
    void SetDisableChangeWeapon(bool isDisable);
    void CreateBindParameter(FPalFishingCutsceneInfo CutsceneInfo, class UPalCutsceneFishingBindParameter*& BindParameter);
    void SetHidePlayerUI(bool IsHide);
    void GetFadeOutParameter(class UPalHUDDispatchParameter_FadeWidget*& FadeParameter);
    void OnLoaded_E5B50C2441AF4766FDFF3BB4606F8B1A(UClass* Loaded);
    void ReceiveBeginPlay();
    void OnStartCutscene(const FPalFishingCutsceneInfo& CutsceneInfo);
    void OnFinishedCutscene(bool bIsSkipped);
    void StartCutscene();
    void OnLoadedCutsceneInfo(const FPalFishingCutsceneInfo& CutsceneInfo);
    void OnEndAim();
    void OnAttachedFloorLargePal(FVector SocketLocation, FRotator SocketRotation);
    void OnStartAim(const TArray<FPalStaticItemIdAndNum>& BaitItemInfoList, int32 SelectedIndex);
    void ExecuteUbergraph_BP_PalFishingComponent(int32 EntryPoint);
}; // Size: 0x4D9

#endif
