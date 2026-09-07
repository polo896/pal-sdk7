---@meta

---@class UBP_Action_Unique_WhiteShieldDragon_ShieldTackle_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field TimerHandles TArray<FTimerHandle>
---@field TackleModule UBP_UniqueSkillModule_Tackle_C
---@field PassThroughAngleThreshold double
---@field EndAttackDistance double
---@field ShieldLocationOffset FVector
---@field ShiledScaleForBoss double
---@field CameraShakeTimer FTimerHandle
---@field MinTackleDuration double
---@field TackleDuration double
local UBP_Action_Unique_WhiteShieldDragon_ShieldTackle_C = {}

---@param Montage UAnimMontage
---@param NotifyName FName
UBP_Action_Unique_WhiteShieldDragon_ShieldTackle_C['On Montage Notify'] = function(self, Montage, NotifyName) end
---@param CanAttackObject boolean
function UBP_Action_Unique_WhiteShieldDragon_ShieldTackle_C:CheckObjectAttack(CanAttackObject) end
function UBP_Action_Unique_WhiteShieldDragon_ShieldTackle_C:OnEndAction() end
function UBP_Action_Unique_WhiteShieldDragon_ShieldTackle_C:OnModuleCompletedEndMontage() end
---@param DeltaTime float
function UBP_Action_Unique_WhiteShieldDragon_ShieldTackle_C:TickAction(DeltaTime) end
function UBP_Action_Unique_WhiteShieldDragon_ShieldTackle_C:OnBeginAction() end
function UBP_Action_Unique_WhiteShieldDragon_ShieldTackle_C:PlayCameraShake() end
---@param EntryPoint int32
function UBP_Action_Unique_WhiteShieldDragon_ShieldTackle_C:ExecuteUbergraph_BP_Action_Unique_WhiteShieldDragon_ShieldTackle(EntryPoint) end


