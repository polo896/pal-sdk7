---@meta

---@class UBP_Action_Unique_DarkMechaDragon_FunnelLaser_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field DelaySetFunnel double
---@field montageList TArray<FReserveMontage>
---@field ReadyAnimationTime double
---@field ProcessAnimationTime double
---@field AfterAnimationTime double
---@field LocationOffsets TArray<FVector>
---@field HomingLocationYRanges TArray<FVector2D>
---@field TimerHandles TArray<FTimerHandle>
---@field CurveVectors TArray<UCurveVector>
---@field EnableRotate boolean
---@field Lasers TArray<ABP_SkillEffect_Unique_DarkMechaDragon_FunnelLaser_Laser_C>
---@field IsRaidBoss boolean
local UBP_Action_Unique_DarkMechaDragon_FunnelLaser_C = {}

function UBP_Action_Unique_DarkMechaDragon_FunnelLaser_C:StopMontage() end
---@param Montages TArray<FReserveMontage>
function UBP_Action_Unique_DarkMechaDragon_FunnelLaser_C:GetAfterMontages(Montages) end
---@param Montages TArray<FReserveMontage>
function UBP_Action_Unique_DarkMechaDragon_FunnelLaser_C:GetProcessMontages(Montages) end
---@param Montages TArray<FReserveMontage>
function UBP_Action_Unique_DarkMechaDragon_FunnelLaser_C:GetReadyMontages(Montages) end
function UBP_Action_Unique_DarkMechaDragon_FunnelLaser_C:OnBeginAction() end
---@param DeltaTime float
function UBP_Action_Unique_DarkMechaDragon_FunnelLaser_C:TickAction(DeltaTime) end
function UBP_Action_Unique_DarkMechaDragon_FunnelLaser_C:OnEndAction() end
function UBP_Action_Unique_DarkMechaDragon_FunnelLaser_C:SpawnFunnel() end
function UBP_Action_Unique_DarkMechaDragon_FunnelLaser_C:CallSetFunnel() end
function UBP_Action_Unique_DarkMechaDragon_FunnelLaser_C:CallProcess() end
function UBP_Action_Unique_DarkMechaDragon_FunnelLaser_C:CallAfter() end
function UBP_Action_Unique_DarkMechaDragon_FunnelLaser_C:CallEnd() end
---@param EntryPoint int32
function UBP_Action_Unique_DarkMechaDragon_FunnelLaser_C:ExecuteUbergraph_BP_Action_Unique_DarkMechaDragon_FunnelLaser(EntryPoint) end


