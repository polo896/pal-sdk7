---@meta

---@class ABP_Skill_ThunderFunnel_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field SpawnOffset double
---@field Target AActor
---@field NumFunnel int32
---@field FunnelLocationOffset FVector
---@field MaxMoveDuration double
---@field Funnels TArray<ABP_Skill_ThunderFunnel_Funnel_C>
local ABP_Skill_ThunderFunnel_C = {}

---@param Value double
function ABP_Skill_ThunderFunnel_C:UpdateMaxDuration(Value) end
---@param SpawnTransform FTransform
---@param Owner AActor
---@param Index int32
---@param SkillEffect ABP_SkillEffectBase_C
ABP_Skill_ThunderFunnel_C['Create Skill Effect'] = function(self, SpawnTransform, Owner, Index, SkillEffect) end
---@param SpawTransform FTransform
---@param Owner AActor
---@param Index int32
---@param SkillEffect ABP_SkillEffectBase_C
function ABP_Skill_ThunderFunnel_C:SpawnSkillEffect(SpawTransform, Owner, Index, SkillEffect) end
function ABP_Skill_ThunderFunnel_C:ReceiveBeginPlay() end
function ABP_Skill_ThunderFunnel_C:SetIsReady() end
---@param EntryPoint int32
function ABP_Skill_ThunderFunnel_C:ExecuteUbergraph_BP_Skill_ThunderFunnel(EntryPoint) end


