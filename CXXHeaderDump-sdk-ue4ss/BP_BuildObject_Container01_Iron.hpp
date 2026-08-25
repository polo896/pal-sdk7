#ifndef UE4SS_SDK_BP_BuildObject_Container01_Iron_HPP
#define UE4SS_SDK_BP_BuildObject_Container01_Iron_HPP

class ABP_BuildObject_Container01_Iron_C : public APalBuildObject
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0750 (size: 0x8)
    class UBP_BuildObjectSimulateArrowComponent_C* BP_BuildObjectSimulateArrowComponent; // 0x0758 (size: 0x8)
    class UBoxComponent* Box;                                                         // 0x0760 (size: 0x8)
    class UPalMapObjectItemChestParameterComponent* PalMapObjectItemChestParameter;   // 0x0768 (size: 0x8)
    class UDecalComponent* Decal3;                                                    // 0x0770 (size: 0x8)
    class UDecalComponent* Decal2;                                                    // 0x0778 (size: 0x8)
    class UBillboardComponent* Billboard1;                                            // 0x0780 (size: 0x8)
    class UArrowComponent* Arrow1;                                                    // 0x0788 (size: 0x8)
    class UDecalComponent* Decal1;                                                    // 0x0790 (size: 0x8)
    class UBillboardComponent* Billboard;                                             // 0x0798 (size: 0x8)
    class UArrowComponent* Arrow;                                                     // 0x07A0 (size: 0x8)
    class UDecalComponent* Decal;                                                     // 0x07A8 (size: 0x8)
    class UStaticMeshComponent* SM_ContainerDoorR;                                    // 0x07B0 (size: 0x8)
    class UStaticMeshComponent* SM_ContainerDoorL;                                    // 0x07B8 (size: 0x8)
    class UStaticMeshComponent* SM_Container;                                         // 0x07C0 (size: 0x8)
    class USceneComponent* Meshs;                                                     // 0x07C8 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x07D0 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x07D8 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x07E0 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x07E8 (size: 0x8)

    void ReceiveBeginPlay();
    void OnAvailable_BlueprintImpl();
    void ExecuteUbergraph_BP_BuildObject_Container01_Iron(int32 EntryPoint);
}; // Size: 0x7F0

#endif
