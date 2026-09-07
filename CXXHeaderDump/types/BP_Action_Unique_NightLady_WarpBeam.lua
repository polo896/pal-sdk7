---@meta

---@class UBP_Action_Unique_NightLady_WarpBeam_C : UBP_ActionUniqueAttackBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WarpTimer FTimerHandle
---@field WarpDestinationDistance float
---@field BeamTimer FTimerHandle
---@field WarpDestinationDistance_NoneChara float
---@field BeamDuration float
---@field ['Montage List'] TArray<FReserveMontage>
---@field BeamActing boolean
---@field Beams TArray<ABP_SkillEffect_Unique_WarpBeam_Beam_C>
---@field CurrentBeamTime double
---@field HommingStrength double
---@field StartHomming boolean
---@field MaintainHorizontal boolean
---@field HalfWarpDegree double
---@field AngleCurve UCurveFloat
---@field OriginalTickOption EVisibilityBasedAnimTickOption
---@field MaxWarpCheck int32
---@field CurrentWaveEffect ABP_SkillEffect_Unique_WarpBeam_Wave_C
---@field OriginalGravity float
---@field ['Ignore Floor'] boolean
local UBP_Action_Unique_NightLady_WarpBeam_C = {}

---@param DeltaTime double
function UBP_Action_Unique_NightLady_WarpBeam_C:AjustCharacterRotation(DeltaTime) end
---@param DeltaTime double
function UBP_Action_Unique_NightLady_WarpBeam_C:Adjustbeam(DeltaTime) end
function UBP_Action_Unique_NightLady_WarpBeam_C:CreateBeam() end
---@param NotifyName FName
function UBP_Action_Unique_NightLady_WarpBeam_C:OnNotifyEnd_FEB6788843F94F59D0CCD4B662C87AF4(NotifyName) end
---@param NotifyName FName
function UBP_Action_Unique_NightLady_WarpBeam_C:OnNotifyBegin_FEB6788843F94F59D0CCD4B662C87AF4(NotifyName) end
---@param NotifyName FName
function UBP_Action_Unique_NightLady_WarpBeam_C:OnInterrupted_FEB6788843F94F59D0CCD4B662C87AF4(NotifyName) end
---@param NotifyName FName
function UBP_Action_Unique_NightLady_WarpBeam_C:OnBlendOut_FEB6788843F94F59D0CCD4B662C87AF4(NotifyName) end
---@param NotifyName FName
function UBP_Action_Unique_NightLady_WarpBeam_C:OnCompleted_FEB6788843F94F59D0CCD4B662C87AF4(NotifyName) end
function UBP_Action_Unique_NightLady_WarpBeam_C:OnBeginAction() end
---@param Montage UAnimMontage
---@param bInterrupted boolean
function UBP_Action_Unique_NightLady_WarpBeam_C:OnMontageEnded(Montage, bInterrupted) end
function UBP_Action_Unique_NightLady_WarpBeam_C:Warp() end
function UBP_Action_Unique_NightLady_WarpBeam_C:OnEndAction() end
function UBP_Action_Unique_NightLady_WarpBeam_C:PrepareBeam() end
function UBP_Action_Unique_NightLady_WarpBeam_C:EndBeam() end
---@param DeltaTime float
function UBP_Action_Unique_NightLady_WarpBeam_C:TickAction(DeltaTime) end
---@param EntryPoint int32
function UBP_Action_Unique_NightLady_WarpBeam_C:ExecuteUbergraph_BP_Action_Unique_NightLady_WarpBeam(EntryPoint) end


