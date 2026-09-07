---@meta

---@class UBP_Action_Coop_RevivePlayer_Discovery_C : UBP_Action_Coop_RevivePlayer_LookAtBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagra UNiagaraComponent
local UBP_Action_Coop_RevivePlayer_Discovery_C = {}

---@param PSystem UNiagaraComponent
function UBP_Action_Coop_RevivePlayer_Discovery_C:OnFinishedFX(PSystem) end
function UBP_Action_Coop_RevivePlayer_Discovery_C:OnBeginAction() end
---@param DeltaTime float
function UBP_Action_Coop_RevivePlayer_Discovery_C:TickAction(DeltaTime) end
function UBP_Action_Coop_RevivePlayer_Discovery_C:OnEndAction() end
---@param EntryPoint int32
function UBP_Action_Coop_RevivePlayer_Discovery_C:ExecuteUbergraph_BP_Action_Coop_RevivePlayer_Discovery(EntryPoint) end


