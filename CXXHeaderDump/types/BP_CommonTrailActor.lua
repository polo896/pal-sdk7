---@meta

---@class ABP_CommonTrailActor_C : AActor
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field DefaultSceneRoot USceneComponent
---@field IsFadeOut boolean
---@field Timer double
---@field CurveAsset UCurveFloat
---@field FadeOutSecond double
local ABP_CommonTrailActor_C = {}

---@param EffectAsset UNiagaraSystem
function ABP_CommonTrailActor_C:SetEffect(EffectAsset) end
---@param DeltaSeconds float
function ABP_CommonTrailActor_C:ReceiveTick(DeltaSeconds) end
---@param FadeOutTime double
---@param FadeOutCurve UCurveFloat
function ABP_CommonTrailActor_C:DeleteEffect(FadeOutTime, FadeOutCurve) end
---@param EntryPoint int32
function ABP_CommonTrailActor_C:ExecuteUbergraph_BP_CommonTrailActor(EntryPoint) end


