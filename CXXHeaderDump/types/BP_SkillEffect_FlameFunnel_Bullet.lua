---@meta

---@class ABP_SkillEffect_FlameFunnel_Bullet_C : ABP_Skill_ThunderFunnel_Bullet_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field InitHomingStrength double
---@field HomingAttenuation double
---@field HomingStregth double
---@field EnemySearchDistance float
---@field Speed double
---@field TempRandomTarget APalCharacter
local ABP_SkillEffect_FlameFunnel_Bullet_C = {}

---@param Target APalCharacter
function ABP_SkillEffect_FlameFunnel_Bullet_C:GetRandomTarget(Target) end
---@return FVector
function ABP_SkillEffect_FlameFunnel_Bullet_C:GetCurrentTargetLocation() end
function ABP_SkillEffect_FlameFunnel_Bullet_C:ReceiveBeginPlay() end
---@param DeltaSeconds float
function ABP_SkillEffect_FlameFunnel_Bullet_C:ReceiveTick(DeltaSeconds) end
---@param DeltaSecond double
function ABP_SkillEffect_FlameFunnel_Bullet_C:FadeOutEffect(DeltaSecond) end
---@param EntryPoint int32
function ABP_SkillEffect_FlameFunnel_Bullet_C:ExecuteUbergraph_BP_SkillEffect_FlameFunnel_Bullet(EntryPoint) end


