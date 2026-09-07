---@meta

---@class ABP_DroneLauncher_C : ABP_YakushimaBlade003_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Drone8 UBP_DroneLauncher_DroneStaticMesh_C
---@field Drone7 UBP_DroneLauncher_DroneStaticMesh_C
---@field Drone6 UBP_DroneLauncher_DroneStaticMesh_C
---@field Drone5 UBP_DroneLauncher_DroneStaticMesh_C
---@field Drone4 UBP_DroneLauncher_DroneStaticMesh_C
---@field Drone2 UBP_DroneLauncher_DroneStaticMesh_C
---@field Drone3 UBP_DroneLauncher_DroneStaticMesh_C
---@field Drone1 UBP_DroneLauncher_DroneStaticMesh_C
---@field Drone0 UBP_DroneLauncher_DroneStaticMesh_C
local ABP_DroneLauncher_C = {}

function ABP_DroneLauncher_C:PlayShootAnim() end
---@param Instant boolean
function ABP_DroneLauncher_C:UpdateDroneVisiblity(Instant) end
---@return FTransform
function ABP_DroneLauncher_C:GetBladeSpawnTransform() end
function ABP_DroneLauncher_C:OnPullTrigger() end
---@param DestroyedActor AActor
function ABP_DroneLauncher_C:OnDestroyBlade(DestroyedActor) end
---@param attachActor AActor
function ABP_DroneLauncher_C:OnAttachWeapon(attachActor) end
function ABP_DroneLauncher_C:OnStartAim() end
---@param bForce boolean
function ABP_DroneLauncher_C:SpawnBlade(bForce) end
---@param EntryPoint int32
function ABP_DroneLauncher_C:ExecuteUbergraph_BP_DroneLauncher(EntryPoint) end


