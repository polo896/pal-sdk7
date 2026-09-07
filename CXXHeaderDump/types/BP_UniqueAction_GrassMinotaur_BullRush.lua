---@meta

---@class UBP_UniqueAction_GrassMinotaur_BullRush_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field TackleModule UBP_UniqueSkillModule_GrassMinotaur_Tackle_C
---@field EyeEffect UNiagaraComponent
local UBP_UniqueAction_GrassMinotaur_BullRush_C = {}

---@param Class TSubclassOf<ABP_UniqueSkillEffect_GrassMinotaur_BullRush_Loop_C>
function UBP_UniqueAction_GrassMinotaur_BullRush_C:GetLoopClass(Class) end
function UBP_UniqueAction_GrassMinotaur_BullRush_C:OnBeginAction() end
function UBP_UniqueAction_GrassMinotaur_BullRush_C:OnEndAction() end
---@param DeltaTime float
function UBP_UniqueAction_GrassMinotaur_BullRush_C:TickAction(DeltaTime) end
function UBP_UniqueAction_GrassMinotaur_BullRush_C:OnCompletedEndMontage() end
---@param EntryPoint int32
function UBP_UniqueAction_GrassMinotaur_BullRush_C:ExecuteUbergraph_BP_UniqueAction_GrassMinotaur_BullRush(EntryPoint) end


