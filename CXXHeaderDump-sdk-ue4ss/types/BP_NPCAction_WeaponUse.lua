---@meta

---@class UBP_NPCAction_WeaponUse_C : UPalActionBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ActionTimerHandle FTimerHandle
---@field ShootTime double
---@field RangePoint FVector
local UBP_NPCAction_WeaponUse_C = {}

---@param WeaponType EPalWeaponType
function UBP_NPCAction_WeaponUse_C:GetWeaponType(WeaponType) end
---@return FVector
function UBP_NPCAction_WeaponUse_C:SuggestRangePoint() end
---@param Range double
---@param AttackTime double
function UBP_NPCAction_WeaponUse_C:GetWeaponStats(Range, AttackTime) end
function UBP_NPCAction_WeaponUse_C:SetEndAction() end
---@return boolean
function UBP_NPCAction_WeaponUse_C:IsEndAction() end
function UBP_NPCAction_WeaponUse_C:UpdateAimTargetLocation() end
---@param NotifyName FName
function UBP_NPCAction_WeaponUse_C:OnNotifyEnd_D0CF4BFE40B7E1C1F72C09B09DB0F46B(NotifyName) end
---@param NotifyName FName
function UBP_NPCAction_WeaponUse_C:OnNotifyBegin_D0CF4BFE40B7E1C1F72C09B09DB0F46B(NotifyName) end
---@param NotifyName FName
function UBP_NPCAction_WeaponUse_C:OnInterrupted_D0CF4BFE40B7E1C1F72C09B09DB0F46B(NotifyName) end
---@param NotifyName FName
function UBP_NPCAction_WeaponUse_C:OnBlendOut_D0CF4BFE40B7E1C1F72C09B09DB0F46B(NotifyName) end
---@param NotifyName FName
function UBP_NPCAction_WeaponUse_C:OnCompleted_D0CF4BFE40B7E1C1F72C09B09DB0F46B(NotifyName) end
function UBP_NPCAction_WeaponUse_C:OnBeginAction() end
function UBP_NPCAction_WeaponUse_C:StartShoot() end
function UBP_NPCAction_WeaponUse_C:OnEndAction() end
---@param DeltaTime float
function UBP_NPCAction_WeaponUse_C:TickAction(DeltaTime) end
function UBP_NPCAction_WeaponUse_C:RequestEndAction() end
function UBP_NPCAction_WeaponUse_C:MoveToRange() end
function UBP_NPCAction_WeaponUse_C:ReadyAim() end
---@param action UPalActionBase
function UBP_NPCAction_WeaponUse_C:OnTargetDeath(action) end
---@param EntryPoint int32
function UBP_NPCAction_WeaponUse_C:ExecuteUbergraph_BP_NPCAction_WeaponUse(EntryPoint) end


