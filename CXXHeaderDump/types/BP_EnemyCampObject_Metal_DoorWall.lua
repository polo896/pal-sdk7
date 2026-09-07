---@meta

---@class ABP_EnemyCampObject_Metal_DoorWall_C : APalBuildObjectBasicBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field DoorParameter UPalMapObjectDoorParameterComponent
---@field EnemyCampObjectSpawnMapObject UPalEnemyCampObjectSpawnMapObjectComponent
---@field AffectNavigationBox UBoxComponent
---@field FrameCollision_01 UBoxComponent
---@field FrameCollision_02 UBoxComponent
---@field FrameCollision USceneComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field DoorCollision UBoxComponent
---@field SM_Door_Iron UStaticMeshComponent
---@field BuildWorkableBounds UBoxComponent
---@field SM_Doorbase_Iron UStaticMeshComponent
---@field Root USceneComponent
---@field CheckOverlapCollision UBoxComponent
---@field _______RotateDoor_8642197E4D28B9D21EE6C5AEA229AA24 float
---@field ________Direction_8642197E4D28B9D21EE6C5AEA229AA24 ETimelineDirection::Type
---@field ['タイムライン'] UTimelineComponent
local ABP_EnemyCampObject_Metal_DoorWall_C = {}

---@param OutComponents TArray<UStaticMeshComponent>
function ABP_EnemyCampObject_Metal_DoorWall_C:GetStaticMeshComponents(OutComponents) end
---@param OutStaticMeshInfo TArray<FPalStaticMeshImposterStaticMeshInfo>
function ABP_EnemyCampObject_Metal_DoorWall_C:GetStaticMeshInfos(OutStaticMeshInfo) end
---@param Mesh UStaticMeshComponent
---@param RotateAngle double
function ABP_EnemyCampObject_Metal_DoorWall_C:SetRotateDoor(Mesh, RotateAngle) end
---@param Module UPalMapObjectSwitchModule
function ABP_EnemyCampObject_Metal_DoorWall_C:OnUpdateSwitchState(Module) end
---@param Model UPalMapObjectConcreteModelBase
---@param Module UPalMapObjectConcreteModelModuleBase
function ABP_EnemyCampObject_Metal_DoorWall_C:OnReadySwitchModule(Model, Module) end
ABP_EnemyCampObject_Metal_DoorWall_C['タイムライン__FinishedFunc'] = function(self, ) end
ABP_EnemyCampObject_Metal_DoorWall_C['タイムライン__UpdateFunc'] = function(self, ) end
---@param ConcreteModel UPalMapObjectConcreteModelBase
function ABP_EnemyCampObject_Metal_DoorWall_C:BP_OnSetConcreteModel(ConcreteModel) end
function ABP_EnemyCampObject_Metal_DoorWall_C:OpenDoorAnimation() end
function ABP_EnemyCampObject_Metal_DoorWall_C:CloseDoorAnimation() end
---@param EntryPoint int32
function ABP_EnemyCampObject_Metal_DoorWall_C:ExecuteUbergraph_BP_EnemyCampObject_Metal_DoorWall(EntryPoint) end


