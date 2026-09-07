#ifndef UE4SS_SDK_BP_BuildObject_Factory_Hard_4_HPP
#define UE4SS_SDK_BP_BuildObject_Factory_Hard_4_HPP

class ABP_BuildObject_Factory_Hard_4_C : public APalBuildObject
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0770 (size: 0x8)
    class UPalMapObjectItemConverterSoundComponent* PalMapObjectItemConverterSound;   // 0x0778 (size: 0x8)
    class UPalWorkEffectSoundComponent* WorkSound_Spark;                              // 0x0780 (size: 0x8)
    class UPalWorkEffectSoundComponent* WorkSound_Flowing;                            // 0x0788 (size: 0x8)
    class UPalWorkEffectSoundComponent* WorkSound_Manufacturing;                      // 0x0790 (size: 0x8)
    class UBoxComponent* Box5;                                                        // 0x0798 (size: 0x8)
    class UBoxComponent* Box4;                                                        // 0x07A0 (size: 0x8)
    class UBoxComponent* box3;                                                        // 0x07A8 (size: 0x8)
    class UBoxComponent* box2;                                                        // 0x07B0 (size: 0x8)
    class UBoxComponent* box1;                                                        // 0x07B8 (size: 0x8)
    class UBoxComponent* Box;                                                         // 0x07C0 (size: 0x8)
    class UPalMapObjectSkeletalMeshComponent* PalMapObjectSkeletalMesh;               // 0x07C8 (size: 0x8)
    class UPalWorkFacingComponent* WorkFacing3;                                       // 0x07D0 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x07D8 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x07E0 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x07E8 (size: 0x8)
    class UBP_BuildObjectFactoryConveyorComponent_C* FactoryConveyorComponent;        // 0x07F0 (size: 0x8)
    class UPalWorkFacingComponent* WorkFacing1;                                       // 0x07F8 (size: 0x8)
    class UPalWorkFacingComponent* WorkFacing2;                                       // 0x0800 (size: 0x8)
    class UPalWorkFacingComponent* WorkFacing;                                        // 0x0808 (size: 0x8)
    class UPalMapObjectItemConverterParameterComponent* ItemConverterParameter;       // 0x0810 (size: 0x8)
    class USceneComponent* Root;                                                      // 0x0818 (size: 0x8)

    void OnAvailable_BlueprintImpl();
    void OnSetConcreteModel(class UPalMapObjectConcreteModelBase* Model);
    void ReceiveBeginPlay();
    void ExecuteUbergraph_BP_BuildObject_Factory_Hard_4(int32 EntryPoint);
}; // Size: 0x820

#endif
