---@meta

---@class ABP_BeamSword_C : ABP_MeleeWeaponBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field ['Bullet Class'] TSubclassOf<APalBullet>
local ABP_BeamSword_C = {}

---@return boolean
function ABP_BeamSword_C:IsUseLeftHandAttach() end
---@param Location FVector
function ABP_BeamSword_C:GetTarget(Location) end
---@param NotifyName FName
function ABP_BeamSword_C:OnAnimNotifyBegin(NotifyName) end
---@param EntryPoint int32
function ABP_BeamSword_C:ExecuteUbergraph_BP_BeamSword(EntryPoint) end


