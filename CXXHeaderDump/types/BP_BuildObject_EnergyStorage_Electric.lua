---@meta

---@class ABP_BuildObject_EnergyStorage_Electric_C : APalBuildObject
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_BuildObjectSimulateArrowComponent UBP_BuildObjectSimulateArrowComponent_C
---@field EnergyStorageParameter UPalMapObjectEnergyStorageParameterComponent
---@field StaticMesh UStaticMeshComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field BuildWorkableBounds UBoxComponent
---@field CheckOverlapCollision UBoxComponent
---@field Root USceneComponent
---@field PlayingFX UNiagaraComponent
---@field DynamicMaterialInstance UMaterialInstanceDynamic
local ABP_BuildObject_EnergyStorage_Electric_C = {}

---@param Model UPalMapObjectEnergyStorageModel
function ABP_BuildObject_EnergyStorage_Electric_C:OnUpdateStoredEnergyAmount(Model) end
function ABP_BuildObject_EnergyStorage_Electric_C:OnAvailable_BlueprintImpl() end
---@param Model UPalMapObjectConcreteModelBase
function ABP_BuildObject_EnergyStorage_Electric_C:OnSetConcreteModel(Model) end
function ABP_BuildObject_EnergyStorage_Electric_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_BuildObject_EnergyStorage_Electric_C:ExecuteUbergraph_BP_BuildObject_EnergyStorage_Electric(EntryPoint) end


