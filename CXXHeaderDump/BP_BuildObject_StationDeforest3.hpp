#ifndef UE4SS_SDK_BP_BuildObject_StationDeforest3_HPP
#define UE4SS_SDK_BP_BuildObject_StationDeforest3_HPP

class ABP_BuildObject_StationDeforest3_C : public APalBuildObject
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0770 (size: 0x8)
    class UBoxComponent* Box;                                                         // 0x0778 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x0780 (size: 0x8)
    class UPalWorkFacingComponent* PalWorkFacing ;                                    // 0x0788 (size: 0x8)
    class UPalWorkFacingComponent* PalWorkFacing 1;                                   // 0x0790 (size: 0x8)
    class UPalWorkFacingComponent* PalWorkFacing 2;                                   // 0x0798 (size: 0x8)
    class UStaticMeshComponent* SM_Loggingcamp_Tree;                                  // 0x07A0 (size: 0x8)
    class UStaticMeshComponent* SM_Loggingcamp_Fence;                                 // 0x07A8 (size: 0x8)
    class UStaticMeshComponent* StaticMesh;                                           // 0x07B0 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x07B8 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x07C0 (size: 0x8)
    class USceneComponent* Scene;                                                     // 0x07C8 (size: 0x8)
    class UPalMapObjectItemSimpleProductParameterComponent* ItemSimpleProductParameter; // 0x07D0 (size: 0x8)
    class USceneComponent* Root;                                                      // 0x07D8 (size: 0x8)

    void SetActive_Internal(bool On);
    void ReceiveBeginPlay();
    void OnAvailable_BlueprintImpl();
    void ExecuteUbergraph_BP_BuildObject_StationDeforest3(int32 EntryPoint);
}; // Size: 0x7E0

#endif
