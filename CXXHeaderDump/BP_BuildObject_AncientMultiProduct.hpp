#ifndef UE4SS_SDK_BP_BuildObject_AncientMultiProduct_HPP
#define UE4SS_SDK_BP_BuildObject_AncientMultiProduct_HPP

class ABP_BuildObject_AncientMultiProduct_C : public APalBuildObjectMultiProduct
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0790 (size: 0x8)
    class UCapsuleComponent* VirtualMeshCollision;                                    // 0x0798 (size: 0x8)
    class UPalMapObjectSkeletalMeshComponent* PalMapObjectSkeletalMesh;               // 0x07A0 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x07A8 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x07B0 (size: 0x8)
    class UPalWorkFacingComponent* WorkFacing;                                        // 0x07B8 (size: 0x8)
    class UPalMapObjectMultiProductParameterComponent* MultiProductParameter;         // 0x07C0 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x07C8 (size: 0x8)

    void PlayAnimationProductModeChanged();
    void OnAvailable_BlueprintImpl();
    void ExecuteUbergraph_BP_BuildObject_AncientMultiProduct(int32 EntryPoint);
}; // Size: 0x7D0

#endif
