#ifndef UE4SS_SDK_BP_BuildObject_TorchStand_HPP
#define UE4SS_SDK_BP_BuildObject_TorchStand_HPP

class ABP_BuildObject_TorchStand_C : public ABP_BuildObject_Torch_Base_C
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0768 (size: 0x8)
    class UBP_BuildObjectSimulateArrowComponent_C* BP_BuildObjectSimulateArrowComponent; // 0x0770 (size: 0x8)
    class UNiagaraComponent* NS_TorchFire;                                            // 0x0778 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x0780 (size: 0x8)
    class UPointLightComponent* PointLight;                                           // 0x0788 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x0790 (size: 0x8)
    class UStaticMeshComponent* SM_TorchStand;                                        // 0x0798 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x07A0 (size: 0x8)

    void SetActiveLight(bool bActive);
    void ReceiveBeginPlay();
    void ExecuteUbergraph_BP_BuildObject_TorchStand(int32 EntryPoint);
}; // Size: 0x7A8

#endif
