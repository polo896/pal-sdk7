---@meta

---@class ABP_BeamRocketBullet_C : ABP_RocketBullet_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field NS_Yakushima_VortexBeater_Trail UNiagaraComponent
local ABP_BeamRocketBullet_C = {}

---@param ExplosionClass TSubclassOf<ABP_ExplosionAttackBase_C>
function ABP_BeamRocketBullet_C:GetExplosionClass(ExplosionClass) end
---@param EndPlayReason EEndPlayReason::Type
function ABP_BeamRocketBullet_C:ReceiveEndPlay(EndPlayReason) end
---@param EntryPoint int32
function ABP_BeamRocketBullet_C:ExecuteUbergraph_BP_BeamRocketBullet(EntryPoint) end


