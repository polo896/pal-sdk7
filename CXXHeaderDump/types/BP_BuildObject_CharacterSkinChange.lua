---@meta

---@class ABP_BuildObject_CharacterSkinChange_C : APalBuildObject
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_BuildObjectSimulateArrowComponent UBP_BuildObjectSimulateArrowComponent_C
---@field BP_PalStaticMeshComponent_AutoRotation UBP_PalStaticMeshComponent_AutoRotation_C
---@field Glow UNiagaraComponent
---@field StaticMesh_Base UStaticMeshComponent
---@field RepairItemParameter UPalMapObjectRepairItemParameterComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field BuildWorkableBounds UBoxComponent
---@field CheckOverlapCollision UBoxComponent
---@field Root USceneComponent
local ABP_BuildObject_CharacterSkinChange_C = {}

---@param On boolean
function ABP_BuildObject_CharacterSkinChange_C:SetActiveInternal(On) end
function ABP_BuildObject_CharacterSkinChange_C:OnAvailable_BlueprintImpl() end
function ABP_BuildObject_CharacterSkinChange_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_BuildObject_CharacterSkinChange_C:ExecuteUbergraph_BP_BuildObject_CharacterSkinChange(EntryPoint) end


