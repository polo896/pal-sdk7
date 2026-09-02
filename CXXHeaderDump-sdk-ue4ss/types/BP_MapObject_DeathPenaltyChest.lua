---@meta

---@class ABP_MapObject_DeathPenaltyChest_C : APalMapObject
---@field UberGraphFrame FPointerToUberGraphFrame
---@field NS_MapObject_DroppedCharacter UNiagaraComponent
---@field PalMapObjectItemChestParameter UPalMapObjectItemChestParameterComponent
---@field CheckOverlapCollision UBoxComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field Mesh UStaticMeshComponent
---@field Root USceneComponent
local ABP_MapObject_DeathPenaltyChest_C = {}

---@param createdWidget UPalUserWidget
function ABP_MapObject_DeathPenaltyChest_C:GetInteractWidget(createdWidget) end
---@param ConcreteModel UPalMapObjectConcreteModelBase
function ABP_MapObject_DeathPenaltyChest_C:SetActiveFXInLocal(ConcreteModel) end
---@param ConcreteModel UPalMapObjectConcreteModelBase
function ABP_MapObject_DeathPenaltyChest_C:BP_OnSetConcreteModel(ConcreteModel) end
---@param Model UPalMapObjectDeathPenaltyStorageModel
function ABP_MapObject_DeathPenaltyChest_C:OnNotifiedGuildUpdateInClient(Model) end
---@param EntryPoint int32
function ABP_MapObject_DeathPenaltyChest_C:ExecuteUbergraph_BP_MapObject_DeathPenaltyChest(EntryPoint) end


