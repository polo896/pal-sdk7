#ifndef UE4SS_SDK_BP_BuildObject_FishingPond01_HPP
#define UE4SS_SDK_BP_BuildObject_FishingPond01_HPP

class ABP_BuildObject_FishingPond01_C : public APalBuildObjectFishPond
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0780 (size: 0x8)
    class UStaticMeshComponent* SM_FishingPond_Rodpillow;                             // 0x0788 (size: 0x8)
    class USkeletalMeshComponent* SK_FishingFloat;                                    // 0x0790 (size: 0x8)
    class USkeletalMeshComponent* SkeletalMesh;                                       // 0x0798 (size: 0x8)
    class UCableComponent* Cable;                                                     // 0x07A0 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox_Chest;                            // 0x07A8 (size: 0x8)
    class UPalWorkFacingComponent* WorkFacing;                                        // 0x07B0 (size: 0x8)
    class UPalMapObjectFishPondParameterComponent* FishPondParameter;                 // 0x07B8 (size: 0x8)
    class UStaticMeshComponent* SM_FishinPond;                                        // 0x07C0 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x07C8 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x07D0 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x07D8 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x07E0 (size: 0x8)

    void ReceiveTick(float DeltaSeconds);
    void ReceiveBeginPlay();
    void ExecuteUbergraph_BP_BuildObject_FishingPond01(int32 EntryPoint);
}; // Size: 0x7E8

#endif
