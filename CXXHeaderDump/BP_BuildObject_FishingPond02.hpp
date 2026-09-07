#ifndef UE4SS_SDK_BP_BuildObject_FishingPond02_HPP
#define UE4SS_SDK_BP_BuildObject_FishingPond02_HPP

class ABP_BuildObject_FishingPond02_C : public APalBuildObjectFishPond
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x07A0 (size: 0x8)
    class UBoxComponent* ToClimbBox_2;                                                // 0x07A8 (size: 0x8)
    class UBoxComponent* ToClimbBox_1;                                                // 0x07B0 (size: 0x8)
    class UBoxComponent* WaterBoxBody3;                                               // 0x07B8 (size: 0x8)
    class UBoxComponent* WaterBoxBody2;                                               // 0x07C0 (size: 0x8)
    class UBoxComponent* WaterBoxBody4;                                               // 0x07C8 (size: 0x8)
    class UBoxComponent* WaterBoxBody;                                                // 0x07D0 (size: 0x8)
    class UBoxComponent* WaterBox4;                                                   // 0x07D8 (size: 0x8)
    class UBoxComponent* WaterBox3;                                                   // 0x07E0 (size: 0x8)
    class UBoxComponent* WaterBox2;                                                   // 0x07E8 (size: 0x8)
    class UBoxComponent* WaterBox;                                                    // 0x07F0 (size: 0x8)
    class UStaticMeshComponent* SM_FishingPond_Rodpillow;                             // 0x07F8 (size: 0x8)
    class USkeletalMeshComponent* SK_FishingFloat;                                    // 0x0800 (size: 0x8)
    class UCableComponent* Cable;                                                     // 0x0808 (size: 0x8)
    class USkeletalMeshComponent* SkeletalMesh;                                       // 0x0810 (size: 0x8)
    class UPalMapObjectFishPondParameterComponent* FishPondParameter;                 // 0x0818 (size: 0x8)
    class UPalWorkFacingComponent* WorkFacing;                                        // 0x0820 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox_Chest;                            // 0x0828 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x0830 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x0838 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x0840 (size: 0x8)
    class UStaticMeshComponent* SM_FishinPond;                                        // 0x0848 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x0850 (size: 0x8)

    void SetBoxCollision(bool IsVisible);
    void SetWaterCollision(bool IsVisible);
    void ResetVisiblity();
    void ReceiveTick(float DeltaSeconds);
    void ReceiveBeginPlay();
    void OnAvailable_BlueprintImpl();
    void ExecuteUbergraph_BP_BuildObject_FishingPond02(int32 EntryPoint);
}; // Size: 0x858

#endif
