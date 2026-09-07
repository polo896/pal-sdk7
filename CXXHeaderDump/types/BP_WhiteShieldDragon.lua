---@meta

---@class ABP_WhiteShieldDragon_C : ABP_MonsterBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field PalBodyParts_Shield UPalBodyPartsBoxComponent
---@field PalSpeedCollision UPalSpeedCollisionComponent
---@field PalBodyPartsCapsule4 UPalBodyPartsCapsuleComponent
---@field PalBodyPartsCapsule3 UPalBodyPartsCapsuleComponent
---@field PalBodyPartsCapsule2 UPalBodyPartsCapsuleComponent
---@field PalBodyPartsCapsule1 UPalBodyPartsCapsuleComponent
---@field PalBodyPartsCapsule UPalBodyPartsCapsuleComponent
---@field BP_PalRideMarkerBiggerHorse UBP_PalRideMarkerBiggerHorse_C
local ABP_WhiteShieldDragon_C = {}

function ABP_WhiteShieldDragon_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_WhiteShieldDragon_C:ExecuteUbergraph_BP_WhiteShieldDragon(EntryPoint) end


