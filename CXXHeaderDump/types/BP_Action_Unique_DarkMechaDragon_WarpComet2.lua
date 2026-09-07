---@meta

---@class UBP_Action_Unique_DarkMechaDragon_WarpComet2_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ['Montage List'] TArray<FReserveMontage>
---@field ActionState ENum_WarpComet_State::Type
---@field WarpDuration double
---@field CometDuration double
---@field CurrentActionTimer FTimerHandle
---@field CrashDuration double
---@field BlinkDelay float
---@field BlinkTimer FTimerHandle
---@field FirstBlink boolean
---@field Moveable boolean
---@field TrailEffect ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_WarpTrail_C
---@field CenterDistanceCurve UCurveFloat
---@field MoveTimer double
---@field CenterLocation FVector
---@field HeightMultiplier double
---@field AngleMultiplier double
---@field EnableTrailRotate boolean
---@field EnableActorRotate boolean
---@field TargetGroundLocation FVector
---@field DescendSpeed double
---@field TackleTrailSkillEffect ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail_C
---@field CometTimer FTimerHandle
---@field WingSockets TArray<FName>
---@field CometCount int32
---@field OriginalGravity float
---@field OriginalAirControl float
---@field OriginalAcc double
---@field OriginalSpeed float
---@field IsRideMode boolean
---@field sign UNiagaraComponent
---@field OriginalTickOption EVisibilityBasedAnimTickOption
---@field CometLauchDuration float
---@field ForceEndTimer FTimerHandle
---@field PreWarpLocation FVector
---@field ['Has Floor'] boolean
---@field LoupeAddedPlayers TArray<APalPlayerCharacter>
---@field HeightLimit double
---@field CacheRider APalCharacter
local UBP_Action_Unique_DarkMechaDragon_WarpComet2_C = {}

---@param Enable boolean
function UBP_Action_Unique_DarkMechaDragon_WarpComet2_C:ActCameraOffset(Enable) end
---@param Start FVector
---@param Height double
UBP_Action_Unique_DarkMechaDragon_WarpComet2_C['Get Height Limit'] = function(self, Start, Height) end
---@param Montage UAnimMontage
---@param NotifyName FName
function UBP_Action_Unique_DarkMechaDragon_WarpComet2_C:OnMontageNotify(Montage, NotifyName) end
---@param Visible boolean
---@param Moveable boolean
UBP_Action_Unique_DarkMechaDragon_WarpComet2_C['Switch Rider State'] = function(self, Visible, Moveable) end
function UBP_Action_Unique_DarkMechaDragon_WarpComet2_C:SpawnComet() end
---@param Visible boolean
UBP_Action_Unique_DarkMechaDragon_WarpComet2_C['Switch Character Group Visibility'] = function(self, Visible) end
---@param DeltaTime float
function UBP_Action_Unique_DarkMechaDragon_WarpComet2_C:TickAction(DeltaTime) end
UBP_Action_Unique_DarkMechaDragon_WarpComet2_C['On Montage List Ended'] = function(self, ) end
---@param Montage_List TArray<FReserveMontage>
function UBP_Action_Unique_DarkMechaDragon_WarpComet2_C:GetNextMontageList(Montage_List) end
function UBP_Action_Unique_DarkMechaDragon_WarpComet2_C:OnBeginAction() end
function UBP_Action_Unique_DarkMechaDragon_WarpComet2_C:OnEndAction() end
---@param Montage UAnimMontage
---@param bInterrupted boolean
function UBP_Action_Unique_DarkMechaDragon_WarpComet2_C:OnMontageEnded(Montage, bInterrupted) end
function UBP_Action_Unique_DarkMechaDragon_WarpComet2_C:Blink() end
---@param RideActor AActor
function UBP_Action_Unique_DarkMechaDragon_WarpComet2_C:ResetPlayerState(RideActor) end
function UBP_Action_Unique_DarkMechaDragon_WarpComet2_C:LuanchEnd() end
function UBP_Action_Unique_DarkMechaDragon_WarpComet2_C:ForceEnd() end
---@param EntryPoint int32
function UBP_Action_Unique_DarkMechaDragon_WarpComet2_C:ExecuteUbergraph_BP_Action_Unique_DarkMechaDragon_WarpComet2(EntryPoint) end


