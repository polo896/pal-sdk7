---@meta

---@class UBP_DroneLauncher_DroneStaticMesh_C : UStaticMeshComponent
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Hidden boolean
---@field ['Delta Seconds'] float
---@field Temp double
local UBP_DroneLauncher_DroneStaticMesh_C = {}

---@param DeltaSeconds float
function UBP_DroneLauncher_DroneStaticMesh_C:ReceiveTick(DeltaSeconds) end
function UBP_DroneLauncher_DroneStaticMesh_C:Hide() end
function UBP_DroneLauncher_DroneStaticMesh_C:Show() end
---@param EntryPoint int32
function UBP_DroneLauncher_DroneStaticMesh_C:ExecuteUbergraph_BP_DroneLauncher_DroneStaticMesh(EntryPoint) end


