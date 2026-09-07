---@meta

---@class UBP_AIAction_UseWaza_C : UBP_AIAction_AttackToReticleTarget_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field AIController ABP_MonsterAIController_Otomo_C
local UBP_AIAction_UseWaza_C = {}

---@param Result boolean
function UBP_AIAction_UseWaza_C:CanFindTarget(Result) end
---@param WazaID EPalWazaID
function UBP_AIAction_UseWaza_C:GetWazaID(WazaID) end
---@param ControlledPawn APawn
function UBP_AIAction_UseWaza_C:SetupAction(ControlledPawn) end
---@return FText
function UBP_AIAction_UseWaza_C:GetSkillName() end
---@param Result boolean
function UBP_AIAction_UseWaza_C:IsAvailableWaza(Result) end
---@param TargetActor AActor
function UBP_AIAction_UseWaza_C:ExecAction(TargetActor) end
---@param ControlledPawn APawn
function UBP_AIAction_UseWaza_C:ActionStart(ControlledPawn) end
---@param TargetActor AActor
function UBP_AIAction_UseWaza_C:OnTargetFound(TargetActor) end
---@param EntryPoint int32
function UBP_AIAction_UseWaza_C:ExecuteUbergraph_BP_AIAction_UseWaza(EntryPoint) end


