---@meta

---@class UBP_PalStaticMeshComponent_AutoRotation_C : UPalStaticMeshComponent
---@field UberGraphFrame FPointerToUberGraphFrame
---@field RotationPerSecond FRotator
local UBP_PalStaticMeshComponent_AutoRotation_C = {}

function UBP_PalStaticMeshComponent_AutoRotation_C:ReceiveBeginPlay() end
---@param DeltaTime float
function UBP_PalStaticMeshComponent_AutoRotation_C:BP_ClientTick(DeltaTime) end
---@param EntryPoint int32
function UBP_PalStaticMeshComponent_AutoRotation_C:ExecuteUbergraph_BP_PalStaticMeshComponent_AutoRotation(EntryPoint) end


