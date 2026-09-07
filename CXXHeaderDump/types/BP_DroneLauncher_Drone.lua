---@meta

---@class ABP_DroneLauncher_Drone_C : ABP_YakushimaBlade003_Blade_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_DroneLauncher_DroneStaticMesh UBP_DroneLauncher_DroneStaticMesh_C
local ABP_DroneLauncher_Drone_C = {}

---@param Location FVector
---@param Rotator FRotator
function ABP_DroneLauncher_Drone_C:GetDefaultPosition(Location, Rotator) end
function ABP_DroneLauncher_Drone_C:ReceiveBeginPlay() end
function ABP_DroneLauncher_Drone_C:FadeOutEffect() end
---@param DeltaSeconds float
function ABP_DroneLauncher_Drone_C:ReceiveTick(DeltaSeconds) end
---@param EntryPoint int32
function ABP_DroneLauncher_Drone_C:ExecuteUbergraph_BP_DroneLauncher_Drone(EntryPoint) end


