---@meta

---@class ABP_Explosion_Barrel_C : ABP_ExplosionAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Explosive UNiagaraComponent
local ABP_Explosion_Barrel_C = {}

---@param IsFriendAttack boolean
ABP_Explosion_Barrel_C['Get Attackable Friend'] = function(self, IsFriendAttack) end
function ABP_Explosion_Barrel_C:ReceiveBeginPlay() end
---@param PSystem UNiagaraComponent
function ABP_Explosion_Barrel_C:BndEvt__BP_Explosion_PenguinLauncher_Explosive_K2Node_ComponentBoundEvent_0_OnNiagaraSystemFinished__DelegateSignature(PSystem) end
---@param EntryPoint int32
function ABP_Explosion_Barrel_C:ExecuteUbergraph_BP_Explosion_Barrel(EntryPoint) end


