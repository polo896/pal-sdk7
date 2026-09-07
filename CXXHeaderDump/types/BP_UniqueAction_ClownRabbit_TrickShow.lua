---@meta

---@class UBP_UniqueAction_ClownRabbit_TrickShow_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ['Montage List'] TArray<FReserveMontage>
---@field WarpDelay float
---@field CurrentTimer FTimerHandle
---@field AttackTime float
---@field OriginalLocation FVector
---@field WarpTargetDistance double
---@field Returned boolean
---@field WarpEffect UNiagaraSystem
---@field SpawnLocations TArray<FVector>
---@field TrueIndex FVector
---@field ['Out Index'] int32
---@field EnableRotate boolean
---@field Fakes TArray<ABP_UniqueSkillEffect_ClownRabbit_TrickShow_Fake_C>
---@field AttackInterval float
---@field AttackTimer FTimerHandle
---@field OriginalTickOption EVisibilityBasedAnimTickOption
local UBP_UniqueAction_ClownRabbit_TrickShow_C = {}

function UBP_UniqueAction_ClownRabbit_TrickShow_C:SpawnBullet() end
function UBP_UniqueAction_ClownRabbit_TrickShow_C:ActAttack() end
---@param DeltaTime float
function UBP_UniqueAction_ClownRabbit_TrickShow_C:TickAction(DeltaTime) end
function UBP_UniqueAction_ClownRabbit_TrickShow_C:PatternCheck() end
function UBP_UniqueAction_ClownRabbit_TrickShow_C:ActEndWarp() end
---@param Hide boolean
function UBP_UniqueAction_ClownRabbit_TrickShow_C:SwitchHidden(Hide) end
---@param NotifyName FName
function UBP_UniqueAction_ClownRabbit_TrickShow_C:OnNotifyEnd_3D7B0BF047339992BC321DA822C7E04B(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_ClownRabbit_TrickShow_C:OnNotifyBegin_3D7B0BF047339992BC321DA822C7E04B(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_ClownRabbit_TrickShow_C:OnInterrupted_3D7B0BF047339992BC321DA822C7E04B(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_ClownRabbit_TrickShow_C:OnBlendOut_3D7B0BF047339992BC321DA822C7E04B(NotifyName) end
---@param NotifyName FName
function UBP_UniqueAction_ClownRabbit_TrickShow_C:OnCompleted_3D7B0BF047339992BC321DA822C7E04B(NotifyName) end
function UBP_UniqueAction_ClownRabbit_TrickShow_C:OnBeginAction() end
function UBP_UniqueAction_ClownRabbit_TrickShow_C:OnEndAction() end
---@param Montage UAnimMontage
---@param NotifyName FName
function UBP_UniqueAction_ClownRabbit_TrickShow_C:OnNotifyBegin(Montage, NotifyName) end
---@param Montage UAnimMontage
---@param bInterrupted boolean
function UBP_UniqueAction_ClownRabbit_TrickShow_C:OnMontageEnded(Montage, bInterrupted) end
function UBP_UniqueAction_ClownRabbit_TrickShow_C:WarpOut() end
function UBP_UniqueAction_ClownRabbit_TrickShow_C:AttackEnd() end
---@param EntryPoint int32
function UBP_UniqueAction_ClownRabbit_TrickShow_C:ExecuteUbergraph_BP_UniqueAction_ClownRabbit_TrickShow(EntryPoint) end


