#ifndef UE4SS_SDK_BP_BuildObject_FlourMill_HPP
#define UE4SS_SDK_BP_BuildObject_FlourMill_HPP

class ABP_BuildObject_FlourMill_C : public APalBuildObject
{
    class UPalMapObjectItemConverterSoundComponent* PalMapObjectItemConverterSound;   // 0x0770 (size: 0x8)
    class UPalWorkEffectSoundComponent* PalWorkEffectSound;                           // 0x0778 (size: 0x8)
    class UPalMapObjectSkeletalMeshComponent* PalMapObjectSkeletalMesh;               // 0x0780 (size: 0x8)
    class UBoxComponent* VirtualMeshCollision;                                        // 0x0788 (size: 0x8)
    class UBP_WorkVisualFX_C* BP_WorkVisualFX;                                        // 0x0790 (size: 0x8)
    class UPalWorkFacingComponent* WorkFacing;                                        // 0x0798 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x07A0 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x07A8 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x07B0 (size: 0x8)
    class UPalMapObjectItemConverterParameterComponent* ItemConverterParameter;       // 0x07B8 (size: 0x8)
    class USceneComponent* Root;                                                      // 0x07C0 (size: 0x8)

}; // Size: 0x7C8

#endif
