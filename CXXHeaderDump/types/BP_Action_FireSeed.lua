---@meta

---@class UBP_Action_FireSeed_C : UBP_ActionGeneralAttackFarBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Rand FRandomStream
local UBP_Action_FireSeed_C = {}

---@param Effect APalSkillEffectBase
function UBP_Action_FireSeed_C:OnSpawnEffect(Effect) end
function UBP_Action_FireSeed_C:OnBeginAction() end
---@param DeltaTime float
function UBP_Action_FireSeed_C:TickAction(DeltaTime) end
---@param EntryPoint int32
function UBP_Action_FireSeed_C:ExecuteUbergraph_BP_Action_FireSeed(EntryPoint) end


