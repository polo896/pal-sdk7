#ifndef UE4SS_SDK_BP_MinimapIconActor_HPP
#define UE4SS_SDK_BP_MinimapIconActor_HPP

class UBP_MinimapIconActor_C : public UActorComponent
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x00A0 (size: 0x8)
    float BaseScale;                                                                  // 0x00A8 (size: 0x4)
    float ZoomedScale;                                                                // 0x00AC (size: 0x4)
    float MinScale;                                                                   // 0x00B0 (size: 0x4)
    float MaxScale;                                                                   // 0x00B4 (size: 0x4)
    bool bIsInitialized;                                                              // 0x00B8 (size: 0x1)
    class UMaterialInterface* IconMaterial;                                           // 0x00C0 (size: 0x8)
    class UMaterialInstanceDynamic* DynMaterial;                                      // 0x00C8 (size: 0x8)
    float HeightOffset;                                                               // 0x00D0 (size: 0x4)
    float ScaleMultiplier;                                                            // 0x00D4 (size: 0x4)
    FString ScaleSettingKey;                                                          // 0x00D8 (size: 0x10)
    int32 SortPriority;                                                               // 0x00E8 (size: 0x4)
    float LivenessCheckTimer;                                                         // 0x00EC (size: 0x4)
    class APalCharacter* TrackedPal;                                                  // 0x00F0 (size: 0x8)
    bool bHasTrackedPal;                                                              // 0x00F8 (size: 0x1)
    class AActor* TrackedGenericActor;                                                // 0x0100 (size: 0x8)
    bool bHasTrackedGenericActor;                                                     // 0x0108 (size: 0x1)
    bool bCheckPickedInClient;                                                        // 0x0109 (size: 0x1)
    bool bLockRotationNorth;                                                          // 0x010A (size: 0x1)
    class UPaperSpriteComponent* RenderComponent;                                     // 0x0110 (size: 0x8)
    class USpringArmComponent* SpringArm;                                             // 0x0118 (size: 0x8)
    class AModActor_C* OwningModActor;                                                // 0x0120 (size: 0x8)

    void RemoveThisIcon();
    void SetIconColor(FLinearColor Color);
    void SetIconTexture(class UTexture2D* IconTexture);
    void EnsureInitialized();
    void OnLoaded_BDB42DA14F4F89E7FD75AD9B0A5B0267(class UObject* Loaded);
    void OnLoaded_FA82268E4271A45C59C9BB87D0E41FD0(class UObject* Loaded);
    void InitIconAsync(FSoftObjectPath IconPath);
    void ReceiveTick(float DeltaSeconds);
    void RetryLoadIcon(FSoftObjectPath IconPath, int32 RetriesRemaining);
    void ExecuteUbergraph_BP_MinimapIconActor(int32 EntryPoint);
}; // Size: 0x128

#endif
