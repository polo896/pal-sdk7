#ifndef UE4SS_SDK_BP_MapObject_DroppedCharacter_HPP
#define UE4SS_SDK_BP_MapObject_DroppedCharacter_HPP

class ABP_MapObject_DroppedCharacter_C : public APalMapObject
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0400 (size: 0x8)
    class UBP_InteractableCapsule_C* BP_InteractableCapsule;                          // 0x0408 (size: 0x8)
    class USkeletalMeshComponent* SkeletalMesh;                                       // 0x0410 (size: 0x8)
    class UNiagaraComponent* NS_MapObject_DroppedCharacter;                           // 0x0418 (size: 0x8)
    class USphereComponent* Sphere;                                                   // 0x0420 (size: 0x8)
    double ReleasePower;                                                              // 0x0428 (size: 0x8)
    class AActor* InteractOther;                                                      // 0x0430 (size: 0x8)
    bool Auto Picked Up;                                                              // 0x0438 (size: 0x1)
    bool bEnableInteract;                                                             // 0x0439 (size: 0x1)

    void GetInteractWidget(class UPalUserWidget*& createdWidget);
    void SetActiveFXInLocal(class UPalMapObjectConcreteModelBase* ConcreteModel);
    void BP_OnSetConcreteModel(class UPalMapObjectConcreteModelBase* ConcreteModel);
    void OnNotifiedGuildUpdateInClient(class UPalMapObjectDeathDroppedCharacterModel* Model);
    void ExecuteUbergraph_BP_MapObject_DroppedCharacter(int32 EntryPoint);
}; // Size: 0x43A

#endif
