#ifndef UE4SS_SDK_BP_BuildObject_AncientEnergyGenerator_HPP
#define UE4SS_SDK_BP_BuildObject_AncientEnergyGenerator_HPP

class ABP_BuildObject_AncientEnergyGenerator_C : public APalBuildObjectGenerateEnergy
{
    class USceneComponent* EffectAttachment;                                          // 0x0780 (size: 0x8)
    class UPalMapObjectSkeletalMeshComponent* PalMapObjectSkeletalMesh;               // 0x0788 (size: 0x8)
    class UPalMapObjectOperationalLoadParameterComponent* OperationalLoadParameter;   // 0x0790 (size: 0x8)
    class UBP_BuildObjectSimulateArrowComponent_C* BP_BuildObjectSimulateArrowComponent; // 0x0798 (size: 0x8)
    class UPalMapObjectGenerateEnergyParameterComponent* GenerateEnergyParameter;     // 0x07A0 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x07A8 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x07B0 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x07B8 (size: 0x8)
    class USceneComponent* Root;                                                      // 0x07C0 (size: 0x8)
    class UNiagaraComponent* PlayingFX;                                               // 0x07C8 (size: 0x8)

    void OnEndOverHeatCoolingWork();
    void OnStartOverHeatCoolingWork();
    void OnEndGenerate();
    void OnStartGenerate();
}; // Size: 0x7D0

#endif
