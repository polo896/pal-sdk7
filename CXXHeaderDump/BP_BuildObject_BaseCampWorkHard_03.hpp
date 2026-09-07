#ifndef UE4SS_SDK_BP_BuildObject_BaseCampWorkHard_03_HPP
#define UE4SS_SDK_BP_BuildObject_BaseCampWorkHard_03_HPP

class ABP_BuildObject_BaseCampWorkHard_03_C : public APalBuildObject
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0770 (size: 0x8)
    class UPalMapObjectBaseCampPassiveEffectSanityWatchtowerParameterComponent* BaseCampPassiveEffectSanityWatchtowerParameter; // 0x0778 (size: 0x8)
    class UStaticMeshComponent* SM_SurveillanceTableAncient;                          // 0x0780 (size: 0x8)
    class UBP_BuildObjectSimulateArrowComponent_C* BP_BuildObjectSimulateArrowComponent; // 0x0788 (size: 0x8)
    class UPalMapObjectBaseCampPassiveEffectWorkHardParameterComponent* BaseCampPassiveEffectWorkHardParameter; // 0x0790 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x0798 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x07A0 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x07A8 (size: 0x8)
    class USceneComponent* Root;                                                      // 0x07B0 (size: 0x8)
    class UPalMapObjectBaseCampPassiveWorkHardModel* WorkHardModel;                   // 0x07B8 (size: 0x8)
    class UPalBaseCampPassiveEffect_WorkHard* PassiveEffectWorkHard;                  // 0x07C0 (size: 0x8)
    int32 WorkTypeMaterialIndexInfoDisplay;                                           // 0x07C8 (size: 0x4)
    class UMaterialInstanceDynamic* WorkTypeMaterialInstanceInfoDisplay;              // 0x07D0 (size: 0x8)
    int32 WorkTypeMaterialIndexIconDisplay;                                           // 0x07D8 (size: 0x4)
    class UMaterialInstanceDynamic* WorkTypeMaterialInstanceIconDisplay;              // 0x07E0 (size: 0x8)

    void UpdateWorkTypeMaterialInstanceIconDisplay(bool InIsValidWorkType, EPalBaseCampPassiveEffectWorkHardType InWorkType);
    void UpdateWorkTypeMaterialInstanceInfoDisplay(bool InIsValidWorkType, EPalBaseCampPassiveEffectWorkHardType InWorkType);
    void UpdateWorkTypeMaterialInstances(bool InIsValidWorkType, EPalBaseCampPassiveEffectWorkHardType InWorkType);
    void UpdateWorkTypeMaterials();
    void OnUpdateWorkHardType(class UPalBaseCampPassiveEffect_WorkHard* InPassiveEffectWorkHard);
    void SetupWorkTypeMaterials();
    void SetupWorkHardModel(class UPalMapObjectBaseCampPassiveWorkHardModel* InWorkHardModel);
    void OnAvailable_BlueprintImpl();
    void ReceiveBeginPlay();
    void ExecuteUbergraph_BP_BuildObject_BaseCampWorkHard_03(int32 EntryPoint);
}; // Size: 0x7E8

#endif
