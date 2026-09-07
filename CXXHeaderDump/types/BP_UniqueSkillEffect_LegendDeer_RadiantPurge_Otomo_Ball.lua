---@meta

---@class ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Ball_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field DownSpeed double
---@field Casting boolean
---@field ['Target Location'] FVector
---@field CastTime double
---@field CurrentTime double
---@field CurrentYaw double
---@field LengthX double
---@field LengthZ double
---@field Curve_RandomBall UCurveVector
---@field YawSpeed double
---@field Reverse boolean
---@field CameraShakeTimer FTimerHandle
local ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Ball_C = {}

function ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Ball_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Ball_C:ReceiveTick(DeltaSeconds) end
---@param TargetLocation_ FVector
function ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Ball_C:SetParam(TargetLocation_) end
function ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Ball_C:ActCast() end
---@param DeltaSecond double
function ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Ball_C:FadeOutEffect(DeltaSecond) end
function ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Ball_C:ChangeYaw() end
function ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Ball_C:CameraShake() end
---@param EndPlayReason EEndPlayReason::Type
function ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Ball_C:ReceiveEndPlay(EndPlayReason) end
---@param EntryPoint int32
function ABP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Ball_C:ExecuteUbergraph_BP_UniqueSkillEffect_LegendDeer_RadiantPurge_Otomo_Ball(EntryPoint) end


