#ifndef UE4SS_SDK_BP_BuildObject_CampFire_HPP
#define UE4SS_SDK_BP_BuildObject_CampFire_HPP

class ABP_BuildObject_CampFire_C : public APalBuildObject
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0750 (size: 0x8)
    class UBP_BuildObjectSimulateArrowComponent_C* BP_BuildObjectSimulateArrowComponent; // 0x0758 (size: 0x8)
    class UBP_PalFirePointLightComponent_C* BP_PalFirePointLight;                     // 0x0760 (size: 0x8)
    class UBP_HeatSourceSphereComponent_C* BP_HeatSourceComponent;                    // 0x0768 (size: 0x8)
    class UNiagaraComponent* Fire;                                                    // 0x0770 (size: 0x8)
    class UPalBurnBoxComponent* PalBurnBox;                                           // 0x0778 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x0780 (size: 0x8)
    class UStaticMeshComponent* StaticMesh;                                           // 0x0788 (size: 0x8)
    class UPalMapObjectItemConverterParameterComponent* ItemConverterParameter;       // 0x0790 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x0798 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x07A0 (size: 0x8)
    class USceneComponent* Root;                                                      // 0x07A8 (size: 0x8)

    void SetActive_Internal(bool bOn);
    void ReceiveBeginPlay();
    void OnAvailable_BlueprintImpl();
    void ExecuteUbergraph_BP_BuildObject_CampFire(int32 EntryPoint);
}; // Size: 0x7B0

#endif
