#ifndef UE4SS_SDK_BP_BuildObject_Torch_Base_HPP
#define UE4SS_SDK_BP_BuildObject_Torch_Base_HPP

class ABP_BuildObject_Torch_Base_C : public APalBuildObject
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0770 (size: 0x8)
    class UPalMapObjectTorchParameterComponent* TorchParameter;                       // 0x0778 (size: 0x8)
    class USceneComponent* DefaultSceneRoot;                                          // 0x0780 (size: 0x8)

    void OnReadySwitchModule(class UPalMapObjectConcreteModelBase* Model, class UPalMapObjectConcreteModelModuleBase* Module);
    void OnUpdateTorchStateInternal(class UPalMapObjectSwitchModule* SwitchModule);
    void SetActiveLight(bool bActive);
    void BP_OnSetConcreteModel(class UPalMapObjectConcreteModelBase* ConcreteModel);
    void ReceiveBeginPlay();
    void ExecuteUbergraph_BP_BuildObject_Torch_Base(int32 EntryPoint);
}; // Size: 0x788

#endif
