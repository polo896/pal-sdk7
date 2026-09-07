---@meta

---@class ABP_SkillEffect_HolyBlast_Line_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Box UBoxComponent
---@field LineOmenEffect UNiagaraComponent
---@field LineRange double
---@field ExplodeCount int32
local ABP_SkillEffect_HolyBlast_Line_C = {}

function ABP_SkillEffect_HolyBlast_Line_C:ReceiveBeginPlay() end
function ABP_SkillEffect_HolyBlast_Line_C:ActExplode() end
function ABP_SkillEffect_HolyBlast_Line_C:DeactivateCollision() end
---@param EntryPoint int32
function ABP_SkillEffect_HolyBlast_Line_C:ExecuteUbergraph_BP_SkillEffect_HolyBlast_Line(EntryPoint) end


