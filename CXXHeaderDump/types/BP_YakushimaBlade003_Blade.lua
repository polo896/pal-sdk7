---@meta

---@class ABP_YakushimaBlade003_Blade_C : ABP_AttackBulletBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field Capsule UCapsuleComponent
---@field Arrow3 UArrowComponent
---@field Arrow2 UArrowComponent
---@field Arrow1 UArrowComponent
---@field SkeletalMesh USkeletalMeshComponent
---@field RotScene USceneComponent
---@field BladeScene USceneComponent
---@field Arrow UArrowComponent
---@field CurrentTarget APalCharacter
---@field OwnerCharacter APalCharacter
---@field Index int32
---@field QuatSpring FQuaternionSpringState
---@field ['Spring State'] FVectorSpringState
---@field ['Max Num'] int32
---@field OwnerWeapon ABP_YakushimaBlade003_C
---@field DefaultBladeForwardDistance double
---@field DefaultBladeRightDistance double
---@field DefaultBladeUpDistance double
---@field DefaultBladeAngle double
---@field FindEnemyAIMRange double
---@field FindEnemyAroundRange double
---@field BladeMaxDistance double
---@field ThrustActionName FString
---@field CurrentActionName FString
---@field bThrustUp boolean
---@field CurrentActionTime double
---@field ActionDelayTime double
---@field bExecutingAction boolean
---@field SlashActionName FString
---@field ThrustUpTotalTime double
---@field ThrustUpDistance double
---@field ThrustInitialLocation FVector
---@field ThrustFinalLocation FVector
---@field ThrustOverrunDistance double
---@field ThrustTotalTime double
---@field OffsetTime double
---@field CurrentTime double
---@field SlashInitialRotation FRotator
---@field SlashInitialLocation FVector
---@field bSlashWarmUp boolean
---@field SlashDir FVector
---@field bSlashForward boolean
---@field SlashTotalTime double
---@field SlashLeaveDistance double
---@field SlashAttackDistance double
---@field FloatingSpeed double
---@field FloatingAmplitude double
---@field FindEnemyFrontDegree double
---@field bStartFadeOutEffect boolean
---@field FadeOutTimer double
---@field EndEffectTotalTime double
---@field FadeNiagara UNiagaraSystem
local ABP_YakushimaBlade003_Blade_C = {}

---@return boolean
function ABP_YakushimaBlade003_Blade_C:CanExecuteAction() end
function ABP_YakushimaBlade003_Blade_C:CheckOwnerLive() end
---@param NewParam FVector
function ABP_YakushimaBlade003_Blade_C:GetCurrentTargetLocation(NewParam) end
---@param HitComp UPrimitiveComponent
---@param OtherCharacter AActor
---@param OtherComp UPrimitiveComponent
---@param Hit FHitResult
---@return boolean
function ABP_YakushimaBlade003_Blade_C:IsDestroy(HitComp, OtherCharacter, OtherComp, Hit) end
---@param NewLocation FVector
---@param NewRotation FRotator
function ABP_YakushimaBlade003_Blade_C:SetBladeLocationAndRotation(NewLocation, NewRotation) end
---@param NewLocation FVector
function ABP_YakushimaBlade003_Blade_C:SetBladeLocation(NewLocation) end
---@param Rotation FRotator
function ABP_YakushimaBlade003_Blade_C:GetBladeRotation(Rotation) end
---@param Location FVector
function ABP_YakushimaBlade003_Blade_C:GetBladeLocation(Location) end
function ABP_YakushimaBlade003_Blade_C:ResetActionTime() end
---@param Location FVector
---@param Rotator FRotator
function ABP_YakushimaBlade003_Blade_C:GetTargetLocationAndRotation(Location, Rotator) end
---@param Location FVector
---@param Rotator FRotator
function ABP_YakushimaBlade003_Blade_C:GetDefaultPosition(Location, Rotator) end
---@param DeltaTime double
function ABP_YakushimaBlade003_Blade_C:UpdateThrust(DeltaTime) end
function ABP_YakushimaBlade003_Blade_C:InitializeThrust() end
---@param DeltaTime double
function ABP_YakushimaBlade003_Blade_C:UpdateSlash(DeltaTime) end
function ABP_YakushimaBlade003_Blade_C:InitializeSlash() end
---@param OwnerWeapon ABP_YakushimaBlade003_C
---@param OwnerCharacter APalCharacter
---@param Index int32
---@param MaxNum int32
function ABP_YakushimaBlade003_Blade_C:Initialize(OwnerWeapon, OwnerCharacter, Index, MaxNum) end
---@param DeltaSeconds float
function ABP_YakushimaBlade003_Blade_C:ReceiveTick(DeltaSeconds) end
---@param DeltaTime double
function ABP_YakushimaBlade003_Blade_C:UpdateBladeLocationAndRotation(DeltaTime) end
function ABP_YakushimaBlade003_Blade_C:UpdateTarget() end
function ABP_YakushimaBlade003_Blade_C:CancelCurrentAction() end
---@param Selection FString
function ABP_YakushimaBlade003_Blade_C:ExecuteNextAction(Selection) end
---@param DeltaTime double
function ABP_YakushimaBlade003_Blade_C:UpdateAction(DeltaTime) end
function ABP_YakushimaBlade003_Blade_C:EndCurrentAction() end
function ABP_YakushimaBlade003_Blade_C:ReceiveBeginPlay() end
---@param HitComp UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param Hit FHitResult
function ABP_YakushimaBlade003_Blade_C:OnHitToActor(HitComp, OtherActor, OtherComp, Hit) end
function ABP_YakushimaBlade003_Blade_C:FadeOutEffect() end
function ABP_YakushimaBlade003_Blade_C:StartFadeOut() end
---@param EntryPoint int32
function ABP_YakushimaBlade003_Blade_C:ExecuteUbergraph_BP_YakushimaBlade003_Blade(EntryPoint) end


