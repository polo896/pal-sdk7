#ifndef UE4SS_SDK_BP_EnemyCampObject_SF_DoorWall_02_HPP
#define UE4SS_SDK_BP_EnemyCampObject_SF_DoorWall_02_HPP

class ABP_EnemyCampObject_SF_DoorWall_02_C : public APalBuildObjectBasicBase
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x07A0 (size: 0x8)
    class UPalEnemyCampObjectSpawnMapObjectComponent* EnemyCampObjectSpawnMapObject;  // 0x07A8 (size: 0x8)
    class UPalMapObjectDoorParameterComponent* DoorParameter;                         // 0x07B0 (size: 0x8)
    class UStaticMeshComponent* Architecture_SF_DoorB_L;                              // 0x07B8 (size: 0x8)
    class UStaticMeshComponent* Architecture_SF_DoorB_R;                              // 0x07C0 (size: 0x8)
    class UBoxComponent* AffectNavigationBox;                                         // 0x07C8 (size: 0x8)
    class UBoxComponent* FrameCollision_02;                                           // 0x07D0 (size: 0x8)
    class UBoxComponent* FrameCollision_01;                                           // 0x07D8 (size: 0x8)
    class USceneComponent* FrameCollision;                                            // 0x07E0 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x07E8 (size: 0x8)
    class UBoxComponent* DoorCollision;                                               // 0x07F0 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x07F8 (size: 0x8)
    class UStaticMeshComponent* Architecture_SF_DoorB;                                // 0x0800 (size: 0x8)
    class USceneComponent* Root;                                                      // 0x0808 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x0810 (size: 0x8)
    float _______MoveDoor_64FF73CA42DD03462E10CCAF4B4A6022;                           // 0x0818 (size: 0x4)
    TEnumAsByte<ETimelineDirection::Type> ________Direction_64FF73CA42DD03462E10CCAF4B4A6022; // 0x081C (size: 0x1)
    class UTimelineComponent* タイムライン;                                                 // 0x0820 (size: 0x8)
    double MoveDoorDistance;                                                          // 0x0828 (size: 0x8)

    void SetMoveDoor(class UStaticMeshComponent* Mesh, double MoveDirection, double MoveDistanceNormal);
    void OnUpdateSwitchState(class UPalMapObjectSwitchModule* Module);
    void OnReadySwitchModule(class UPalMapObjectConcreteModelBase* Model, class UPalMapObjectConcreteModelModuleBase* Module);
    void タイムライン__FinishedFunc();
    void タイムライン__UpdateFunc();
    void BP_OnSetConcreteModel(class UPalMapObjectConcreteModelBase* ConcreteModel);
    void OpenDoorAnimation();
    void CloseDoorAnimation();
    void ExecuteUbergraph_BP_EnemyCampObject_SF_DoorWall_02(int32 EntryPoint);
}; // Size: 0x830

#endif
