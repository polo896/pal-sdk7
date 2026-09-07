---@meta

---@class ABP_BuildObject_MultiElectricHatchingPalEgg_C : APalBuildObject
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_BuildObjectSimulateArrowComponent UBP_BuildObjectSimulateArrowComponent_C
---@field NS_HatchingEggFinishGlow2 UNiagaraComponent
---@field NS_HatchingEggFinishGlow1 UNiagaraComponent
---@field NS_HatchingEggFinishGlow UNiagaraComponent
---@field PalEggChildActor UChildActorComponent
---@field PalEggChildActor1 UChildActorComponent
---@field PalEggChildActor2 UChildActorComponent
---@field SM_EggHatchingMachineFuture UStaticMeshComponent
---@field PalMapObjectHatchingEggParameter UPalMapObjectHatchingEggParameterComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field BuildWorkableBounds UBoxComponent
---@field CheckOverlapCollision UBoxComponent
---@field Root USceneComponent
---@field HatchingEggModel UPalMapObjectMultiHatchingEggModel
---@field PalGetEffect UNiagaraComponent
---@field PalGetEffectOffset FVector
---@field PalEggActors TArray<UChildActorComponent>
---@field EggActorClassMap TMap<TSoftClassPtr<AActor>, TSubclassOf<AActor>>
---@field PalEggActorMap TMap<UChildActorComponent, TSoftClassPtr<AActor>>
---@field EggActorClasses TArray<TSubclassOf<AActor>>
---@field EggHatchedStates TArray<boolean>
local ABP_BuildObject_MultiElectricHatchingPalEgg_C = {}

function ABP_BuildObject_MultiElectricHatchingPalEgg_C:OnRep_EggHatchedStates() end
function ABP_BuildObject_MultiElectricHatchingPalEgg_C:OnRep_EggActorClasses() end
---@param HatchedStates TArray<boolean>
function ABP_BuildObject_MultiElectricHatchingPalEgg_C:SetupHatchedEffects(HatchedStates) end
function ABP_BuildObject_MultiElectricHatchingPalEgg_C:ResetPalEggActorMap() end
function ABP_BuildObject_MultiElectricHatchingPalEgg_C:SetupPalEggModel() end
ABP_BuildObject_MultiElectricHatchingPalEgg_C['On Update Pal Eggs'] = function(self, ) end
function ABP_BuildObject_MultiElectricHatchingPalEgg_C:ResetHatchingSpeed() end
function ABP_BuildObject_MultiElectricHatchingPalEgg_C:UpdateHatchingSpeed() end
function ABP_BuildObject_MultiElectricHatchingPalEgg_C:SpawnGetPalEffect() end
---@param Model UPalMapObjectHatchingEggModelBase
ABP_BuildObject_MultiElectricHatchingPalEgg_C['On Hatched Character'] = function(self, Model) end
---@param ConcreteModel UPalMapObjectConcreteModelBase
function ABP_BuildObject_MultiElectricHatchingPalEgg_C:OnSetConcreteModelAvailableInternal(ConcreteModel) end
---@param Loaded UClass
function ABP_BuildObject_MultiElectricHatchingPalEgg_C:OnLoaded_C0CD216245E1EDD5CA66A3920A68AD5B(Loaded) end
function ABP_BuildObject_MultiElectricHatchingPalEgg_C:OnAvailable_BlueprintImpl() end
function ABP_BuildObject_MultiElectricHatchingPalEgg_C:LoadEggMeshModel() end
---@param Model UPalMapObjectConcreteModelBase
function ABP_BuildObject_MultiElectricHatchingPalEgg_C:OnSetConcreteModelAvailable(Model) end
---@param Workable boolean
function ABP_BuildObject_MultiElectricHatchingPalEgg_C:OnUpdateWorkable(Workable) end
---@param EntryPoint int32
function ABP_BuildObject_MultiElectricHatchingPalEgg_C:ExecuteUbergraph_BP_BuildObject_MultiElectricHatchingPalEgg(EntryPoint) end


