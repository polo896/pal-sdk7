---@meta

---@class UBP_UniqueAction_PoseidonOrca_TorrentLaser_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ['Montage List'] TArray<FReserveMontage>
---@field BeamStartOffset FVector
---@field BeamEndOffset FVector
---@field CurrentLaser ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Beam_C
---@field LaserMaxLength double
---@field EnableRotate boolean
---@field Timer float
---@field LerpCurve UCurveFloat
---@field ['Original Anim Tick Option'] EVisibilityBasedAnimTickOption
---@field Marks TArray<ABP_UniqueSkillEffect_PoseidonOrca_TorrentLaser_Mark_C>
---@field BurstDelay float
---@field MarkCreateTimer FTimerHandle
---@field LastHittedGround boolean
---@field CurrentValidMarkLocation FVector
---@field LastValidMarkLocation FVector
---@field IsHorizontal boolean
---@field BurstIntervalDistance double
local UBP_UniqueAction_PoseidonOrca_TorrentLaser_C = {}

---@param InTime float
function UBP_UniqueAction_PoseidonOrca_TorrentLaser_C:TraceBeam(InTime) end
function UBP_UniqueAction_PoseidonOrca_TorrentLaser_C:CreateMark() end
function UBP_UniqueAction_PoseidonOrca_TorrentLaser_C:DelayBurst() end
---@param Actor AActor
---@param LocalOffset FVector
---@param Offset FVector
function UBP_UniqueAction_PoseidonOrca_TorrentLaser_C:TransformLocalOffset(Actor, LocalOffset, Offset) end
---@param Start FVector
---@param End FVector
---@param Location FVector
---@param Hitted boolean
---@param IsWater boolean
function UBP_UniqueAction_PoseidonOrca_TorrentLaser_C:GetGroundOrWaterPlaneTrace(Start, End, Location, Hitted, IsWater) end
---@param DeltaTime float
function UBP_UniqueAction_PoseidonOrca_TorrentLaser_C:TickAction(DeltaTime) end
---@param Montage UAnimMontage
---@param NotifyName FName
function UBP_UniqueAction_PoseidonOrca_TorrentLaser_C:OnMontageNotifyEnd(Montage, NotifyName) end
---@param Montage UAnimMontage
---@param NotifyName FName
function UBP_UniqueAction_PoseidonOrca_TorrentLaser_C:OnMontageNotifyBegin(Montage, NotifyName) end
function UBP_UniqueAction_PoseidonOrca_TorrentLaser_C:OnBeginAction() end
function UBP_UniqueAction_PoseidonOrca_TorrentLaser_C:OnEndAction() end
---@param Montage UAnimMontage
---@param bInterrupted boolean
function UBP_UniqueAction_PoseidonOrca_TorrentLaser_C:OnMontageEnded(Montage, bInterrupted) end
---@param EntryPoint int32
function UBP_UniqueAction_PoseidonOrca_TorrentLaser_C:ExecuteUbergraph_BP_UniqueAction_PoseidonOrca_TorrentLaser(EntryPoint) end


