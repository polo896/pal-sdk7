---@meta

---@class ABP_BuildObject_Spa_4_C : APalBuildObject
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BackgroundCheckOverlapCollision UBoxComponent
---@field BP_BuildObjectSimulateArrowComponent UBP_BuildObjectSimulateArrowComponent_C
---@field AmusementCharacterLocation UPalMapObjectAmusementCharacterLocationComponent
---@field NS_PalSpaSteam UNiagaraComponent
---@field AmusementParameter UPalMapObjectAmusementParameterComponent
---@field StaticMesh UStaticMeshComponent
---@field BP_InteractableCapsule UBP_InteractableCapsule_C
---@field BuildWorkableBounds UBoxComponent
---@field CheckOverlapCollision UBoxComponent
---@field Root USceneComponent
local ABP_BuildObject_Spa_4_C = {}

---@param bOn boolean
function ABP_BuildObject_Spa_4_C:SetActive_Internal(bOn) end
function ABP_BuildObject_Spa_4_C:ReceiveBeginPlay() end
function ABP_BuildObject_Spa_4_C:OnAvailable_BlueprintImpl() end
---@param EntryPoint int32
function ABP_BuildObject_Spa_4_C:ExecuteUbergraph_BP_BuildObject_Spa_4(EntryPoint) end


