---@meta

---@class ABP_SkillEffect_HolyBlast_Center_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ImpactCollision UCapsuleComponent
---@field Niagara UNiagaraComponent
---@field BlastDelay double
---@field BlastTimer FTimerHandle
---@field LineSpawnDelay float
---@field [' LineTimer'] FTimerHandle
---@field CanCancel boolean
---@field LineCount int32
---@field CreatedLines TArray<ABP_SkillEffect_HolyBlast_Line_C>
---@field LineOffset double
---@field Manager ABP_SkillEffect_HolyBlast_LineCollisionManager_C
local ABP_SkillEffect_HolyBlast_Center_C = {}

function ABP_SkillEffect_HolyBlast_Center_C:DestroyAll() end
function ABP_SkillEffect_HolyBlast_Center_C:DeactivateHitCollision() end
function ABP_SkillEffect_HolyBlast_Center_C:CreateLine() end
function ABP_SkillEffect_HolyBlast_Center_C:bLast() end
function ABP_SkillEffect_HolyBlast_Center_C:ReceiveBeginPlay() end
function ABP_SkillEffect_HolyBlast_Center_C:CancelSkill() end
---@param EntryPoint int32
function ABP_SkillEffect_HolyBlast_Center_C:ExecuteUbergraph_BP_SkillEffect_HolyBlast_Center(EntryPoint) end


