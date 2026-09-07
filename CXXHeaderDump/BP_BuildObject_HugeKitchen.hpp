#ifndef UE4SS_SDK_BP_BuildObject_HugeKitchen_HPP
#define UE4SS_SDK_BP_BuildObject_HugeKitchen_HPP

class ABP_BuildObject_HugeKitchen_C : public APalBuildObject
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0770 (size: 0x8)
    class UPalMapObjectItemConverterSoundComponent* PalMapObjectItemConverterSound;   // 0x0778 (size: 0x8)
    class UPalWorkFacingComponent* PalWorkFacing4;                                    // 0x0780 (size: 0x8)
    class UPalWorkFacingComponent* PalWorkFacing3;                                    // 0x0788 (size: 0x8)
    class UPalWorkFacingComponent* PalWorkFacing2;                                    // 0x0790 (size: 0x8)
    class UNiagaraComponent* NS_CookingSmoke;                                         // 0x0798 (size: 0x8)
    class UPalWorkFacingComponent* PalWorkFacing1;                                    // 0x07A0 (size: 0x8)
    class UStaticMeshComponent* StaticMesh;                                           // 0x07A8 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x07B0 (size: 0x8)
    class UPalMapObjectItemConverterParameterComponent* ItemConverterParameter;       // 0x07B8 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x07C0 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x07C8 (size: 0x8)
    class USceneComponent* Root;                                                      // 0x07D0 (size: 0x8)

    void SetActive_Internal(bool bOn);
    void BP_OnSetConcreteModel(class UPalMapObjectConcreteModelBase* ConcreteModel);
    void ReceiveBeginPlay();
    void CustomEvent(class UPalMapObjectConcreteModelBase* Model);
    void ExecuteUbergraph_BP_BuildObject_HugeKitchen(int32 EntryPoint);
}; // Size: 0x7D8

#endif
