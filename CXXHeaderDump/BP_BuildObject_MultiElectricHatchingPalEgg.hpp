#ifndef UE4SS_SDK_BP_BuildObject_MultiElectricHatchingPalEgg_HPP
#define UE4SS_SDK_BP_BuildObject_MultiElectricHatchingPalEgg_HPP

class ABP_BuildObject_MultiElectricHatchingPalEgg_C : public APalBuildObject
{
    FPointerToUberGraphFrame UberGraphFrame;                                          // 0x0770 (size: 0x8)
    class UBP_BuildObjectSimulateArrowComponent_C* BP_BuildObjectSimulateArrowComponent; // 0x0778 (size: 0x8)
    class UNiagaraComponent* NS_HatchingEggFinishGlow2;                               // 0x0780 (size: 0x8)
    class UNiagaraComponent* NS_HatchingEggFinishGlow1;                               // 0x0788 (size: 0x8)
    class UNiagaraComponent* NS_HatchingEggFinishGlow;                                // 0x0790 (size: 0x8)
    class UChildActorComponent* PalEggChildActor;                                     // 0x0798 (size: 0x8)
    class UChildActorComponent* PalEggChildActor1;                                    // 0x07A0 (size: 0x8)
    class UChildActorComponent* PalEggChildActor2;                                    // 0x07A8 (size: 0x8)
    class UStaticMeshComponent* SM_EggHatchingMachineFuture;                          // 0x07B0 (size: 0x8)
    class UPalMapObjectHatchingEggParameterComponent* PalMapObjectHatchingEggParameter; // 0x07B8 (size: 0x8)
    class UBP_InteractableBox_C* BP_InteractableBox;                                  // 0x07C0 (size: 0x8)
    class UBoxComponent* BuildWorkableBounds;                                         // 0x07C8 (size: 0x8)
    class UBoxComponent* CheckOverlapCollision;                                       // 0x07D0 (size: 0x8)
    class USceneComponent* Root;                                                      // 0x07D8 (size: 0x8)
    class UPalMapObjectMultiHatchingEggModel* HatchingEggModel;                       // 0x07E0 (size: 0x8)
    class UNiagaraComponent* PalGetEffect;                                            // 0x07E8 (size: 0x8)
    FVector PalGetEffectOffset;                                                       // 0x07F0 (size: 0x18)
    TArray<class UChildActorComponent*> PalEggActors;                                 // 0x0808 (size: 0x10)
    TMap<class TSoftClassPtr<AActor>, class TSubclassOf<AActor>> EggActorClassMap;    // 0x0818 (size: 0x50)
    TMap<class UChildActorComponent*, class TSoftClassPtr<AActor>> PalEggActorMap;    // 0x0868 (size: 0x50)
    TArray<class TSubclassOf<AActor>> EggActorClasses;                                // 0x08B8 (size: 0x10)
    TArray<bool> EggHatchedStates;                                                    // 0x08C8 (size: 0x10)

    void OnRep_EggHatchedStates();
    void OnRep_EggActorClasses();
    void SetupHatchedEffects(TArray<bool>& HatchedStates);
    void ResetPalEggActorMap();
    void SetupPalEggModel();
    void On Update Pal Eggs();
    void ResetHatchingSpeed();
    void UpdateHatchingSpeed();
    void SpawnGetPalEffect();
    void On Hatched Character(class UPalMapObjectHatchingEggModelBase* Model);
    void OnSetConcreteModelAvailableInternal(class UPalMapObjectConcreteModelBase* ConcreteModel);
    void OnLoaded_C0CD216245E1EDD5CA66A3920A68AD5B(UClass* Loaded);
    void OnAvailable_BlueprintImpl();
    void LoadEggMeshModel();
    void OnSetConcreteModelAvailable(class UPalMapObjectConcreteModelBase* Model);
    void OnUpdateWorkable(bool Workable);
    void ExecuteUbergraph_BP_BuildObject_MultiElectricHatchingPalEgg(int32 EntryPoint);
}; // Size: 0x8D8

#endif
