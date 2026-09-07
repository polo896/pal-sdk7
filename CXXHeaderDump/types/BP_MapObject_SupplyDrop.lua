---@meta

---@class ABP_MapObject_SupplyDrop_C : APalMapObject
---@field UberGraphFrame FPointerToUberGraphFrame
---@field StaticMesh7 UStaticMeshComponent
---@field StaticMesh8 UStaticMeshComponent
---@field NS_MapObject_DroppedCharacter UNiagaraComponent
---@field PalMapObjectItemChestParameter UPalMapObjectItemChestParameterComponent
---@field CheckOverlapCollision UBoxComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field Mesh UStaticMeshComponent
---@field Root USceneComponent
local ABP_MapObject_SupplyDrop_C = {}

---@param ConcreteModel UPalMapObjectConcreteModelBase
function ABP_MapObject_SupplyDrop_C:SetActiveFXInLocal(ConcreteModel) end
---@param ConcreteModel UPalMapObjectConcreteModelBase
function ABP_MapObject_SupplyDrop_C:BP_OnSetConcreteModel(ConcreteModel) end
---@param EntryPoint int32
function ABP_MapObject_SupplyDrop_C:ExecuteUbergraph_BP_MapObject_SupplyDrop(EntryPoint) end


