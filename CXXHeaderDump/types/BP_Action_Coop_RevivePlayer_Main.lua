---@meta

---@class UBP_Action_Coop_RevivePlayer_Main_C : UPalActionBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ['Anim Montage'] UAnimMontage
---@field ElapsedTime double
---@field ReviveTime double
---@field TargetPlayer AActor
---@field ReviveLocationOffset FVector
---@field flagName FName
---@field CameraOffset FShooterSpringCameraParameter
local UBP_Action_Coop_RevivePlayer_Main_C = {}

function UBP_Action_Coop_RevivePlayer_Main_C:EndCamera() end
function UBP_Action_Coop_RevivePlayer_Main_C:StartCamera() end
function UBP_Action_Coop_RevivePlayer_Main_C:ResetLocation() end
function UBP_Action_Coop_RevivePlayer_Main_C:UpdateTransform() end
---@param NewParam FRotator
function UBP_Action_Coop_RevivePlayer_Main_C:CalcReviveRotation(NewParam) end
---@return FVector
function UBP_Action_Coop_RevivePlayer_Main_C:CalcReviveLocation() end
function UBP_Action_Coop_RevivePlayer_Main_C:OnBeginAction() end
---@param DeltaTime float
function UBP_Action_Coop_RevivePlayer_Main_C:TickAction(DeltaTime) end
function UBP_Action_Coop_RevivePlayer_Main_C:OnEndAction() end
---@param EntryPoint int32
function UBP_Action_Coop_RevivePlayer_Main_C:ExecuteUbergraph_BP_Action_Coop_RevivePlayer_Main(EntryPoint) end


