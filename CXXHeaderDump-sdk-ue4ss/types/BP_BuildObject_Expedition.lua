---@meta

---@class ABP_BuildObject_Expedition_C : APalBuildObjectCharacterTeamMission
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BlockNavmesh UBoxComponent
---@field PalLimitVolumeBox UPalLimitVolumeBoxComponent
---@field Box UBoxComponent
---@field IndicatorOrigin USceneComponent
---@field SM_PalExpeditionFacilities UStaticMeshComponent
---@field CharacterWalkSpline3 USplineComponent
---@field CharacterWalkSpline2 USplineComponent
---@field CharacterWalkSpline1 USplineComponent
---@field NS_Dungeon_Gate_In UNiagaraComponent
---@field BP_ChestInteract UBP_InteractableBox_C
---@field BP_InteractableBox UBP_InteractableBox_C
---@field BuildWorkableBounds UBoxComponent
---@field CheckOverlapCollision UBoxComponent
---@field Root USceneComponent
---@field CharacterVisual UBP_VisualSkeletalMeshComponent_C
local ABP_BuildObject_Expedition_C = {}

function ABP_BuildObject_Expedition_C:OnAvailable_BlueprintImpl() end
---@param NewVisualComponent UPalCharacterVisualSkeletalMeshComponent
function ABP_BuildObject_Expedition_C:OnCreateAndInitTransformNewVisualEvent(NewVisualComponent) end
---@param EntryPoint int32
function ABP_BuildObject_Expedition_C:ExecuteUbergraph_BP_BuildObject_Expedition(EntryPoint) end


