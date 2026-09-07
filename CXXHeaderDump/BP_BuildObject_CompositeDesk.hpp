#ifndef UE4SS_SDK_BP_BuildObject_CompositeDesk_HPP
#define UE4SS_SDK_BP_BuildObject_CompositeDesk_HPP

class ABP_BuildObject_CompositeDesk_C : public APalBuildObject
{
    class UPalMapObjectItemConverterSoundComponent* PalMapObjectItemConverterSound;   // 0x0770 (size: 0x8)
    class UBP_WorkVisualFX_C* BP_WorkVisualFX;                                        // 0x0778 (size: 0x8)
    class UStaticMeshComponent* StaticMesh;                                           // 0x0780 (size: 0x8)
    class UPalWorkFacingComponent* WorkFacing;                                        // 0x0788 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x0790 (size: 0x8)
    class UPalMapObjectItemConverterParameterComponent* ItemConverterParameter;       // 0x0798 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x07A0 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x07A8 (size: 0x8)
    class USceneComponent* Root;                                                      // 0x07B0 (size: 0x8)

}; // Size: 0x7B8

#endif
