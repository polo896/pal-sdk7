---@meta

---@class UBP_Action_Unique_DarkMechaDragon_WarpComet_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WarpEffectClass UNiagaraSystem
---@field StartingMoveFromStart double
---@field StartingMoveSpeed double
---@field StartingMoveRotateSpeed double
---@field StartingMoveDuration double
---@field TimerHandles TArray<FTimerHandle>
---@field StartingMontages TArray<FReserveMontage>
---@field CometMontages TArray<FReserveMontage>
---@field TackleMontages TArray<FReserveMontage>
---@field EndMontage TArray<FReserveMontage>
---@field ScaleCache double
---@field EnableStartMove boolean
---@field WarpEffectClass2 UNiagaraSystem
---@field WarpDistance FVector
---@field WarpDelayTimeFromStart double
---@field CometLoopAnimationDuration double
---@field TackleSpeed double
---@field TackleLoopAnimationDurataion double
---@field EnableComet boolean
---@field CheckGroundHeight double
---@field NumComet int32
---@field CometInterval double
---@field StartingMoveTimer double
---@field CometTimer double
---@field CometSpawnLocationOffsets TArray<FVector>
---@field TackleTimer double
---@field CometCounter int32
---@field CometPitchRange FVector2D
---@field CometYawRange FVector2D
---@field WarpEffectLocationOffset double
---@field TackleDelayTime double
---@field StartingMoveSpeedRateCurve UCurveFloat
---@field TackleSpeedRateCurve UCurveFloat
---@field WarpDistanceXYBetweenTarget double
---@field WarpHideTime double
---@field WarpCornerSlerpDistance double
---@field IsHiding boolean
---@field IsWarping boolean
---@field WarpOrigin FVector
---@field WarpDestination FVector
---@field WarpHideTimer double
---@field WarpingSkillEffect ABP_SkillEffectBase_C
---@field WarpSlerpStartLocation FVector
---@field IsSlerping boolean
---@field SlerpTimer double
---@field SlerpTime double
---@field SlerpCenter FVector
---@field WarpCometState EAction_DarkMechaDragonWarpCometType::Type
---@field StartingMoveDistance double
---@field StartingMoveOrigin FVector
---@field TackleTrailSkillEffect ABP_SkillEffect_Unique_DarkMechaDragon_WarpComet_TackleTrail_C
---@field LastLocation FVector
local UBP_Action_Unique_DarkMechaDragon_WarpComet_C = {}

---@param Destination FVector
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:CalcWarpDestination(Destination) end
---@param IsHide boolean
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:SetHideInGame(IsHide) end
---@param OffsetLocation FVector
---@param IsRight boolean
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:SpawnComet(OffsetLocation, IsRight) end
---@param Result FVector
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:GetTackleDirection(Result) end
---@param IsGround boolean
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:IsCloseToGround(IsGround) end
---@param Result boolean
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:IsEndState(Result) end
---@param Result boolean
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:IsTackleState(Result) end
---@param Result boolean
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:IsCometState(Result) end
---@param Result boolean
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:IsStartState(Result) end
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:StopMontage() end
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:OnBeginAction() end
---@param Montage UAnimMontage
---@param bInterrupted boolean
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:OnMontageEnded(Montage, bInterrupted) end
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:OnEndAction() end
---@param Montage UAnimMontage
---@param NotifyName FName
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:OnMontageNotifyBegin(Montage, NotifyName) end
---@param Montage UAnimMontage
---@param NotifyName FName
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:OnMontageNotifyEnd(Montage, NotifyName) end
---@param DeltaTime float
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:TickAction(DeltaTime) end
---@param Montage UAnimMontage
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:OnMontageStarted(Montage) end
---@param OverlappedActor AActor
---@param OtherActor AActor
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:OnActorBeginOverlap(OverlappedActor, OtherActor) end
---@param SelfActor AActor
---@param OtherActor AActor
---@param NormalImpulse FVector
---@param Hit FHitResult
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:OnActorHit(SelfActor, OtherActor, NormalImpulse, Hit) end
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:StartWarp() end
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:StartMove() end
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:EndTackle() end
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:StartWarpInternal() end
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:CustomEvent() end
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:EndComet() end
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:DisableCometAttack() end
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:DisableMove() end
---@param EntryPoint int32
function UBP_Action_Unique_DarkMechaDragon_WarpComet_C:ExecuteUbergraph_BP_Action_Unique_DarkMechaDragon_WarpComet(EntryPoint) end


