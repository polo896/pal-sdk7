#ifndef UE4SS_SDK_BP_BuildObject_AncientCookingStove_HPP
#define UE4SS_SDK_BP_BuildObject_AncientCookingStove_HPP

class ABP_BuildObject_AncientCookingStove_C : public APalBuildObject
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0770 (size: 0x8)
    class UPalMapObjectItemConverterSoundComponent* PalMapObjectItemConverterSound;   // 0x0778 (size: 0x8)
    class UBP_WorkVisualFX_C* BP_WorkVisualFX;                                        // 0x0780 (size: 0x8)
    class UPalBuildObjectHUDLocatorComponent* PalBuildObjectHUDLocator1;              // 0x0788 (size: 0x8)
    class UPalBuildObjectHUDLocatorComponent* PalBuildObjectHUDLocator;               // 0x0790 (size: 0x8)
    class UPalWorkFacingComponent* WorkFacing_Handcraft;                              // 0x0798 (size: 0x8)
    class UNiagaraComponent* NS_CookingSmoke;                                         // 0x07A0 (size: 0x8)
    class UPalWorkFacingComponent* PalWorkFacing_EmitFire;                            // 0x07A8 (size: 0x8)
    class UStaticMeshComponent* StaticMesh;                                           // 0x07B0 (size: 0x8)
    class UParticleSystemComponent* ParticleSystem;                                   // 0x07B8 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x07C0 (size: 0x8)
    class UPalMapObjectItemConverterParameterComponent* ItemConverterParameter;       // 0x07C8 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x07D0 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x07D8 (size: 0x8)
    class USceneComponent* Root;                                                      // 0x07E0 (size: 0x8)

    void SetActive_Internal(bool bOn);
    void ReceiveBeginPlay();
    void OnAvailable_BlueprintImpl();
    void ExecuteUbergraph_BP_BuildObject_AncientCookingStove(int32 EntryPoint);
}; // Size: 0x7E8

#endif
