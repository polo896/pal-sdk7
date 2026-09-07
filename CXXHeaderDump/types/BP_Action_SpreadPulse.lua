---@meta

---@class UBP_Action_SpreadPulse_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field bulletNum int32
---@field Angle int32
---@field BulletEffects TArray<APalSkillEffectBase>
---@field TargetEffect APalSkillEffectBase
local UBP_Action_SpreadPulse_C = {}

---@param Index int32
---@param Rotation FRotator
function UBP_Action_SpreadPulse_C:CalcBulletRotation(Index, Rotation) end
function UBP_Action_SpreadPulse_C:OnBeginAction() end
---@param DeltaTime float
function UBP_Action_SpreadPulse_C:TickAction(DeltaTime) end
---@param Effect APalSkillEffectBase
function UBP_Action_SpreadPulse_C:OnSpawnEffect(Effect) end
---@param Effects TArray<APalSkillEffectBase>
function UBP_Action_SpreadPulse_C:ShootBullet(Effects) end
---@param EntryPoint int32
function UBP_Action_SpreadPulse_C:ExecuteUbergraph_BP_Action_SpreadPulse(EntryPoint) end


