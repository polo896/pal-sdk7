#ifndef UE4SS_SDK_BP_BuildObject_CookingStove_HPP
#define UE4SS_SDK_BP_BuildObject_CookingStove_HPP

class ABP_BuildObject_CookingStove_C : public APalBuildObject
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0750 (size: 0x8)
    class UNiagaraComponent* NS_CookingSmoke;                                         // 0x0758 (size: 0x8)
    class UPalWorkFacingComponent* PalWorkFacing1;                                    // 0x0760 (size: 0x8)
    class UStaticMeshComponent* StaticMesh;                                           // 0x0768 (size: 0x8)
    class UParticleSystemComponent* ParticleSystem;                                   // 0x0770 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x0778 (size: 0x8)
    class UPalMapObjectItemConverterParameterComponent* ItemConverterParameter;       // 0x0780 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x0788 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x0790 (size: 0x8)
    class USceneComponent* Root;                                                      // 0x0798 (size: 0x8)

    void SetActive_Internal(bool bOn);
    void ReceiveBeginPlay();
    void OnAvailable_BlueprintImpl();
    void ExecuteUbergraph_BP_BuildObject_CookingStove(int32 EntryPoint);
}; // Size: 0x7A0

#endif
