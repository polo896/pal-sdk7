#ifndef UE4SS_SDK_BP_BuildObject_DismantlingConveyor_HPP
#define UE4SS_SDK_BP_BuildObject_DismantlingConveyor_HPP

class ABP_BuildObject_DismantlingConveyor_C : public APalBuildObjectConvertCharacterToItem
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0790 (size: 0x8)
    class UWidgetComponent* ItemOutputWidget;                                         // 0x0798 (size: 0x8)
    class UBP_BuildObjectSimulateArrowComponent_C* BP_BuildObjectSimulateArrowComponent; // 0x07A0 (size: 0x8)
    class UPalWorkEffectSoundComponent* PalWorkEffectSound;                           // 0x07A8 (size: 0x8)
    class UStaticMeshComponent* StaticMesh4;                                          // 0x07B0 (size: 0x8)
    class USplineComponent* ConveyorSpline;                                           // 0x07B8 (size: 0x8)
    class UArrowComponent* DropItemLocation;                                          // 0x07C0 (size: 0x8)
    class UStaticMeshComponent* StaticMesh3;                                          // 0x07C8 (size: 0x8)
    class UStaticMeshComponent* StaticMesh2;                                          // 0x07D0 (size: 0x8)
    class UStaticMeshComponent* StaticMesh1;                                          // 0x07D8 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x07E0 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x07E8 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x07F0 (size: 0x8)
    class USceneComponent* Root;                                                      // 0x07F8 (size: 0x8)
    TMap<class FGuid, class UPalCharacterVisualSkeletalMeshComponent*> VisualSkeletalMeshMap; // 0x0800 (size: 0x50)
    class UMaterialInstanceDynamic* ConveyerDynamicMaterialInstance;                  // 0x0850 (size: 0x8)
    EPalGeneralMontageType CharacterMontageType;                                      // 0x0858 (size: 0x1)

    void SetVisibleItemOutputWidget(bool bVisible);
    void UpdateConveyerVisual();
    void UpdateVisualByTick(float DeltaSeconds);
    void UpdateCurrentVisualProcessForItem(FPalBuildObjectConvertCharacterToItemVisualProcessInfo& VisualProcessInfo, class UPalCharacterVisualSkeletalMeshComponent* VisualSkeletalMesh, double DeltaTime);
    void UpdateCurrentVisualProcess(double DeltaTime);
    void Add New Visual Skeletal Mesh if Not Exists(const FPalBuildObjectConvertCharacterToItemVisualProcessInfo& VisualProcessInfo, TArray<class UPalCharacterVisualSkeletalMeshComponent*>& SheduledRemovePool);
    class UPalCharacterVisualSkeletalMeshComponent* GetOrCreateNewVisual(TArray<class UPalCharacterVisualSkeletalMeshComponent*>& SheduledRemovePool);
    TArray<FGuid> GetInstanceIdsNotExistsVisualProcess();
    void IsExistsVisualProcess(FGuid InstanceId, bool& Return Value);
    void BP_UpdateConvertProcessVisual();
    void ReceiveTick(float DeltaSeconds);
    void ReceiveBeginPlay();
    void OnStartSimulation();
    void ExecuteUbergraph_BP_BuildObject_DismantlingConveyor(int32 EntryPoint);
}; // Size: 0x859

#endif
