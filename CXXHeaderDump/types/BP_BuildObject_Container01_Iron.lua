---@meta

---@class ABP_BuildObject_Container01_Iron_C : APalBuildObject
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_BuildObjectSimulateArrowComponent UBP_BuildObjectSimulateArrowComponent_C
---@field Box UBoxComponent
---@field PalMapObjectItemChestParameter UPalMapObjectItemChestParameterComponent
---@field Decal3 UDecalComponent
---@field Decal2 UDecalComponent
---@field Billboard1 UBillboardComponent
---@field Arrow1 UArrowComponent
---@field Decal1 UDecalComponent
---@field Billboard UBillboardComponent
---@field Arrow UArrowComponent
---@field Decal UDecalComponent
---@field SM_ContainerDoorR UStaticMeshComponent
---@field SM_ContainerDoorL UStaticMeshComponent
---@field SM_Container UStaticMeshComponent
---@field Meshs USceneComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field BuildWorkableBounds UBoxComponent
---@field CheckOverlapCollision UBoxComponent
---@field DefaultSceneRoot USceneComponent
local ABP_BuildObject_Container01_Iron_C = {}

function ABP_BuildObject_Container01_Iron_C:ReceiveBeginPlay() end
function ABP_BuildObject_Container01_Iron_C:OnAvailable_BlueprintImpl() end
---@param EntryPoint int32
function ABP_BuildObject_Container01_Iron_C:ExecuteUbergraph_BP_BuildObject_Container01_Iron(EntryPoint) end


