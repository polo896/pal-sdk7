#ifndef UE4SS_SDK_BP_BuildObject_Spa_4_HPP
#define UE4SS_SDK_BP_BuildObject_Spa_4_HPP

class ABP_BuildObject_Spa_4_C : public APalBuildObject
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0770 (size: 0x8)
    class UBoxComponent* BackgroundCheckOverlapCollision;                             // 0x0778 (size: 0x8)
    class UBP_BuildObjectSimulateArrowComponent_C* BP_BuildObjectSimulateArrowComponent; // 0x0780 (size: 0x8)
    class UPalMapObjectAmusementCharacterLocationComponent* AmusementCharacterLocation; // 0x0788 (size: 0x8)
    class UNiagaraComponent* NS_PalSpaSteam;                                          // 0x0790 (size: 0x8)
    class UPalMapObjectAmusementParameterComponent* AmusementParameter;               // 0x0798 (size: 0x8)
    class UStaticMeshComponent* StaticMesh;                                           // 0x07A0 (size: 0x8)
    class UBP_InteractableCapsule_C* BP_InteractableCapsule;                          // 0x07A8 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x07B0 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x07B8 (size: 0x8)
    class USceneComponent* Root;                                                      // 0x07C0 (size: 0x8)

    void SetActive_Internal(bool bOn);
    void ReceiveBeginPlay();
    void OnAvailable_BlueprintImpl();
    void ExecuteUbergraph_BP_BuildObject_Spa_4(int32 EntryPoint);
}; // Size: 0x7C8

#endif
