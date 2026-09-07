---@meta

---@class ABP_SkillEffect_ThunderStorm_Marker_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Niagara UNiagaraComponent
---@field StormDelay float
local ABP_SkillEffect_ThunderStorm_Marker_C = {}

function ABP_SkillEffect_ThunderStorm_Marker_C:ReceiveBeginPlay() end
function ABP_SkillEffect_ThunderStorm_Marker_C:CreateStorm() end
---@param DeltaSecond double
function ABP_SkillEffect_ThunderStorm_Marker_C:FadeOutEffect(DeltaSecond) end
---@param EntryPoint int32
function ABP_SkillEffect_ThunderStorm_Marker_C:ExecuteUbergraph_BP_SkillEffect_ThunderStorm_Marker(EntryPoint) end


