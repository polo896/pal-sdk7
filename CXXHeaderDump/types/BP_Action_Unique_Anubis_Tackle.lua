---@meta

---@class UBP_Action_Unique_Anubis_Tackle_C : UPalActionWazaBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field IsMoveMode boolean
---@field MaxSpeed double
---@field PrevDirection FVector
---@field RotaterPerSec double
---@field StopRrange double
---@field State EAction_Anubis_Tackle::Type
---@field StopRate double
---@field LoopingEffect UNiagaraComponent
---@field SpawnedEffects TArray<TSoftObjectPtr<UNiagaraComponent>>
---@field OmenEffect UNiagaraComponent
---@field OmenEffectSide UNiagaraComponent
---@field OmenScaleY double
---@field OmenScaleZ double
---@field OmenSideScaleY double
---@field OmenSideScaleZ double
---@field MoveSpeed double
---@field ToTargetVector FVector
---@field CurrentVector FVector
---@field CurrentPredictTargetRate double
---@field PredictTargetRate double
---@field TimerHandle FTimerHandle
---@field TackleTimer double
---@field MaxTackleDuration double
---@field StopRateFactor double
---@field BreakingFrictionFactorCache double
local UBP_Action_Unique_Anubis_Tackle_C = {}

function UBP_Action_Unique_Anubis_Tackle_C:StopAllMontage() end
function UBP_Action_Unique_Anubis_Tackle_C:SetHiddenAllNiagara() end
---@param DeltaTime double
function UBP_Action_Unique_Anubis_Tackle_C:TackleMovement(DeltaTime) end
---@param ScaleY double
---@param ScaleZ double
---@param Transform FTransform
function UBP_Action_Unique_Anubis_Tackle_C:GetDesiredTransformOfOmenEffect(ScaleY, ScaleZ, Transform) end
---@param DeltaTime double
function UBP_Action_Unique_Anubis_Tackle_C:ChargeAndRotate(DeltaTime) end
---@param DeltaTime double
function UBP_Action_Unique_Anubis_Tackle_C:StopMovement(DeltaTime) end
function UBP_Action_Unique_Anubis_Tackle_C:PlayEndMontage() end
---@param DeltaTime double
---@param IsEnd boolean
function UBP_Action_Unique_Anubis_Tackle_C:CheckEndTackle(DeltaTime, IsEnd) end
---@param DeltaTime double
function UBP_Action_Unique_Anubis_Tackle_C:TackleMotament(DeltaTime) end
function UBP_Action_Unique_Anubis_Tackle_C:OnBeginAction() end
---@param Montage UAnimMontage
---@param NotifyName FName
UBP_Action_Unique_Anubis_Tackle_C['OnMontageNotifyBeginDelegate_イベント_0'] = function(self, Montage, NotifyName) end
---@param DeltaTime float
function UBP_Action_Unique_Anubis_Tackle_C:TickAction(DeltaTime) end
function UBP_Action_Unique_Anubis_Tackle_C:OnEndAction() end
---@param EntryPoint int32
function UBP_Action_Unique_Anubis_Tackle_C:ExecuteUbergraph_BP_Action_Unique_Anubis_Tackle(EntryPoint) end


