---@meta

---@class UBP_AIActionRevivePlayer_C : UPalAIActionBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Trainer APalCharacter
---@field flagName FName
---@field Owner APalCharacter
---@field PartnerSkillParam UPalPartnerSkillParameterComponent
---@field ActionList TArray<TSubclassOf<UPalActionBase>>
---@field ActionIndex int32
---@field CurrentAction UPalActionBase
---@field ReviveCompleted boolean
local UBP_AIActionRevivePlayer_C = {}

---@return boolean
function UBP_AIActionRevivePlayer_C:IsGoal() end
function UBP_AIActionRevivePlayer_C:EndCoop() end
---@param action UPalActionBase
---@param NotifyName FName
function UBP_AIActionRevivePlayer_C:OnActionNotify(action, NotifyName) end
function UBP_AIActionRevivePlayer_C:OnEndAction() end
---@param IsMuteki boolean
function UBP_AIActionRevivePlayer_C:SetMuteki(IsMuteki) end
---@param IsNear boolean
function UBP_AIActionRevivePlayer_C:IsNearLocation(IsNear) end
function UBP_AIActionRevivePlayer_C:PlayNextAction() end
---@param ControlledPawn APawn
function UBP_AIActionRevivePlayer_C:SetupAction(ControlledPawn) end
---@param ControlledPawn APawn
function UBP_AIActionRevivePlayer_C:ActionStart(ControlledPawn) end
---@param ControlledPawn APawn
---@param WithResult EPawnActionResult::Type
function UBP_AIActionRevivePlayer_C:ActionFinished(ControlledPawn, WithResult) end
---@param EntryPoint int32
function UBP_AIActionRevivePlayer_C:ExecuteUbergraph_BP_AIActionRevivePlayer(EntryPoint) end


