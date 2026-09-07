---@meta

---@class ABP_ShotgunAmmo_C : AActor
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Ammo UStaticMeshComponent
---@field Scene USceneComponent
local ABP_ShotgunAmmo_C = {}

function ABP_ShotgunAmmo_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_ShotgunAmmo_C:ExecuteUbergraph_BP_ShotgunAmmo(EntryPoint) end


