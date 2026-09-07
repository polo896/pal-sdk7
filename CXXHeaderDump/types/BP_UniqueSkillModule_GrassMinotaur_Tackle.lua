---@meta

---@class UBP_UniqueSkillModule_GrassMinotaur_Tackle_C : UPalSkillModule_HorseTackle
---@field UberGraphFrame FPointerToUberGraphFrame
---@field TurnAnimMontage UAnimMontage
---@field CurrentEffect ABP_UniqueSkillEffect_GrassMinotaur_BullRush_Loop_C
---@field LoopClass TSubclassOf<AActor>
---@field OverrideYaw boolean
local UBP_UniqueSkillModule_GrassMinotaur_Tackle_C = {}

---@param DeltaTime double
---@param Rotation FRotator
function UBP_UniqueSkillModule_GrassMinotaur_Tackle_C:GetRotation(DeltaTime, Rotation) end
---@return boolean
function UBP_UniqueSkillModule_GrassMinotaur_Tackle_C:IsTackleMontagePlaying() end
---@param DeltaTime float
function UBP_UniqueSkillModule_GrassMinotaur_Tackle_C:UpdateYaw(DeltaTime) end
---@param NewState EPalTackleState
function UBP_UniqueSkillModule_GrassMinotaur_Tackle_C:OnTackleStateChanged(NewState) end
function UBP_UniqueSkillModule_GrassMinotaur_Tackle_C:OnEndModule() end
---@param Montage UAnimMontage
---@param NotifyName FName
function UBP_UniqueSkillModule_GrassMinotaur_Tackle_C:OnMontageNotifyEvent(Montage, NotifyName) end
---@param EntryPoint int32
function UBP_UniqueSkillModule_GrassMinotaur_Tackle_C:ExecuteUbergraph_BP_UniqueSkillModule_GrassMinotaur_Tackle(EntryPoint) end


