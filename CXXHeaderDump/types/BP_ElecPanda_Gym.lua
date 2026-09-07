---@meta

---@class ABP_ElecPanda_Gym_C : ABP_ElecPanda_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field PalRideMarker_0 UPalRideMarkerComponent
---@field PalBodyPartsCapsule3 UPalBodyPartsCapsuleComponent
---@field BP_PalBossNPCMarker UBP_PalBossNPCMarker_C
local ABP_ElecPanda_Gym_C = {}

---@return USkeletalMeshComponent
function ABP_ElecPanda_Gym_C:GetRideNPCMesh() end
function ABP_ElecPanda_Gym_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_ElecPanda_Gym_C:ExecuteUbergraph_BP_ElecPanda_Gym(EntryPoint) end


