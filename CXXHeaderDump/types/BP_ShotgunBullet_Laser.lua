---@meta

---@class ABP_ShotgunBullet_Laser_C : ABP_ShotgunBullet_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Laser UNiagaraComponent
local ABP_ShotgunBullet_Laser_C = {}

function ABP_ShotgunBullet_Laser_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function ABP_ShotgunBullet_Laser_C:ReceiveTick(DeltaSeconds) end
---@param EntryPoint int32
function ABP_ShotgunBullet_Laser_C:ExecuteUbergraph_BP_ShotgunBullet_Laser(EntryPoint) end


