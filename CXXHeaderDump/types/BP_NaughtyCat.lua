---@meta

---@class ABP_NaughtyCat_C : ABP_MonsterBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field PalSpeedCollision1 UPalSpeedCollisionComponent
---@field PalBodyPartsSphere UPalBodyPartsSphereComponent
---@field PalBodyPartsCapsule UPalBodyPartsCapsuleComponent
---@field BP_PalRideMarkerSit UBP_PalRideMarkerSit_C
---@field EyeMaterial UMaterialInstanceDynamic
local ABP_NaughtyCat_C = {}

function ABP_NaughtyCat_C:ReceiveBeginPlay() end
---@param bIsBattleMode boolean
function ABP_NaughtyCat_C:ChangeBattle(bIsBattleMode) end
---@param EntryPoint int32
function ABP_NaughtyCat_C:ExecuteUbergraph_BP_NaughtyCat(EntryPoint) end


