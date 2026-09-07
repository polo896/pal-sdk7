---@meta

---@class ABP_SkillEffect_Unique_WarpBeam_Beam_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Capsule UCapsuleComponent
---@field Niagara UNiagaraComponent
local ABP_SkillEffect_Unique_WarpBeam_Beam_C = {}

function ABP_SkillEffect_Unique_WarpBeam_Beam_C:ReceiveBeginPlay() end
function ABP_SkillEffect_Unique_WarpBeam_Beam_C:EndCollision() end
---@param Duration double
---@param Size double
function ABP_SkillEffect_Unique_WarpBeam_Beam_C:SetBeamDurationAndSize(Duration, Size) end
---@param DeltaSecond double
function ABP_SkillEffect_Unique_WarpBeam_Beam_C:FadeOutEffect(DeltaSecond) end
---@param EntryPoint int32
function ABP_SkillEffect_Unique_WarpBeam_Beam_C:ExecuteUbergraph_BP_SkillEffect_Unique_WarpBeam_Beam(EntryPoint) end


