---@meta

---@class UBP_BuildObjectFactoryConveyorComponent_C : UPalItemFlowSplineComponent
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ConveyorSpeed double
---@field ScrollMaterialParametername FName
---@field ['Target Mesh Component'] UMeshComponent
---@field ['Target Material Index'] int32
local UBP_BuildObjectFactoryConveyorComponent_C = {}

---@return UMaterialInstanceDynamic
function UBP_BuildObjectFactoryConveyorComponent_C:GetMaterialInstance() end
---@param bOn boolean
function UBP_BuildObjectFactoryConveyorComponent_C:SetRunningConveyor(bOn) end
---@param Model UPalMapObjectConvertItemModel
function UBP_BuildObjectFactoryConveyorComponent_C:OnUpdateRecipe(Model) end
---@param Module UPalMapObjectEnergyModule
function UBP_BuildObjectFactoryConveyorComponent_C:OnUpdateCurrentEnergyState(Module) end
---@param Model UPalMapObjectConcreteModelBase
---@param Module UPalMapObjectConcreteModelModuleBase
function UBP_BuildObjectFactoryConveyorComponent_C:OnReadyOwnerEnergyModule(Model, Module) end
---@param ConcreteModel UPalMapObjectConcreteModelBase
---@param TargetMeshComponent UMeshComponent
---@param TargetMaterialIndex int32
function UBP_BuildObjectFactoryConveyorComponent_C:SetupByOwner(ConcreteModel, TargetMeshComponent, TargetMaterialIndex) end
---@param MapObjectConcreteModel UPalMapObjectConcreteModelBase
function UBP_BuildObjectFactoryConveyorComponent_C:OnUpdateBuildObjectVisual(MapObjectConcreteModel) end
---@param EntryPoint int32
function UBP_BuildObjectFactoryConveyorComponent_C:ExecuteUbergraph_BP_BuildObjectFactoryConveyorComponent(EntryPoint) end


