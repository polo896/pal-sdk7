---@meta

---@class ABP_LazyDragon_C : ABP_MonsterBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field PalSpeedCollision UPalSpeedCollisionComponent
---@field PalBodyPartsCapsule2 UPalBodyPartsCapsuleComponent
---@field PalBodyPartsCapsule1 UPalBodyPartsCapsuleComponent
---@field PalRideMarker UPalRideMarkerComponent
---@field PalBodyPartsCapsule UPalBodyPartsCapsuleComponent
---@field PalShooter UPalShooterComponent
local ABP_LazyDragon_C = {}

function ABP_LazyDragon_C:ReceiveBeginPlay() end
---@param IsAim boolean
---@param IsShoot boolean
function ABP_LazyDragon_C:BndEvt__BP_LazyDragon_PalShooter_K2Node_ComponentBoundEvent_0_ChangeStateDelegate__DelegateSignature(IsAim, IsShoot) end
---@param EntryPoint int32
function ABP_LazyDragon_C:ExecuteUbergraph_BP_LazyDragon(EntryPoint) end


