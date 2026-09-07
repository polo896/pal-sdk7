---@meta

---@class UBP_Action_Unique_NightLady_NightmareFlame_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ['Montage List'] TArray<FReserveMontage>
---@field LaunchFlameTimer FTimerHandle
---@field FlameCount int32
---@field EnemySearchDistance float
---@field FlameLaunchInterval float
---@field MaxFlameCount int32
local UBP_Action_Unique_NightLady_NightmareFlame_C = {}

---@param Actor AActor
---@param LocationZ double
function UBP_Action_Unique_NightLady_NightmareFlame_C:GetActorRootLocationZ(Actor, LocationZ) end
---@param Montage UAnimMontage
---@param NotifyName FName
function UBP_Action_Unique_NightLady_NightmareFlame_C:OnMontageNotify(Montage, NotifyName) end
function UBP_Action_Unique_NightLady_NightmareFlame_C:CreateHommingFlame() end
function UBP_Action_Unique_NightLady_NightmareFlame_C:OnBeginAction() end
---@param Montage UAnimMontage
---@param bInterrupted boolean
function UBP_Action_Unique_NightLady_NightmareFlame_C:OnMontageEnd(Montage, bInterrupted) end
function UBP_Action_Unique_NightLady_NightmareFlame_C:OnEndAction() end
---@param EntryPoint int32
function UBP_Action_Unique_NightLady_NightmareFlame_C:ExecuteUbergraph_BP_Action_Unique_NightLady_NightmareFlame(EntryPoint) end


