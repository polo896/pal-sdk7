---@meta

---@class ABP_BuildObject_HugeKitchen_C : APalBuildObject
---@field UberGraphFrame FPointerToUberGraphFrame
---@field PalMapObjectItemConverterSound UPalMapObjectItemConverterSoundComponent
---@field PalWorkFacing4 UPalWorkFacingComponent
---@field PalWorkFacing3 UPalWorkFacingComponent
---@field PalWorkFacing2 UPalWorkFacingComponent
---@field NS_CookingSmoke UNiagaraComponent
---@field PalWorkFacing1 UPalWorkFacingComponent
---@field StaticMesh UStaticMeshComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field ItemConverterParameter UPalMapObjectItemConverterParameterComponent
---@field BuildWorkableBounds UBoxComponent
---@field CheckOverlapCollision UBoxComponent
---@field Root USceneComponent
local ABP_BuildObject_HugeKitchen_C = {}

---@param bOn boolean
function ABP_BuildObject_HugeKitchen_C:SetActive_Internal(bOn) end
---@param ConcreteModel UPalMapObjectConcreteModelBase
function ABP_BuildObject_HugeKitchen_C:BP_OnSetConcreteModel(ConcreteModel) end
function ABP_BuildObject_HugeKitchen_C:ReceiveBeginPlay() end
---@param Model UPalMapObjectConcreteModelBase
function ABP_BuildObject_HugeKitchen_C:CustomEvent(Model) end
---@param EntryPoint int32
function ABP_BuildObject_HugeKitchen_C:ExecuteUbergraph_BP_BuildObject_HugeKitchen(EntryPoint) end


