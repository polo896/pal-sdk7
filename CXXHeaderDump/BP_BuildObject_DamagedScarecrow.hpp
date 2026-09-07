#ifndef UE4SS_SDK_BP_BuildObject_DamagedScarecrow_HPP
#define UE4SS_SDK_BP_BuildObject_DamagedScarecrow_HPP

class ABP_BuildObject_DamagedScarecrow_C : public APalBuildObject
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0770 (size: 0x8)
    class UPalBodyPartsCapsuleComponent* PalBodyPartsCapsule;                         // 0x0778 (size: 0x8)
    class UPalBodyPartsSphereComponent* PalBodyPartsSphere;                           // 0x0780 (size: 0x8)
    class UStaticMeshComponent* SM_DamagedScarecrow;                                  // 0x0788 (size: 0x8)
    class UBoxComponent* NavmeshCollision;                                            // 0x0790 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x0798 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x07A0 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x07A8 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x07B0 (size: 0x8)

    void ReceiveBeginPlay();
    void OnAvailable_BlueprintImpl();
    void ExecuteUbergraph_BP_BuildObject_DamagedScarecrow(int32 EntryPoint);
}; // Size: 0x7B8

#endif
