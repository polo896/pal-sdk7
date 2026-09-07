---@meta

---@class ABP_SkillEffect_HolyBlast_LineCollisionManager_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
local ABP_SkillEffect_HolyBlast_LineCollisionManager_C = {}

function ABP_SkillEffect_HolyBlast_LineCollisionManager_C:ReceiveBeginPlay() end
function ABP_SkillEffect_HolyBlast_LineCollisionManager_C:ActExplode() end
function ABP_SkillEffect_HolyBlast_LineCollisionManager_C:DeactivateCollision() end
---@param Component UPrimitiveComponent
function ABP_SkillEffect_HolyBlast_LineCollisionManager_C:BindCollision(Component) end
---@param EntryPoint int32
function ABP_SkillEffect_HolyBlast_LineCollisionManager_C:ExecuteUbergraph_BP_SkillEffect_HolyBlast_LineCollisionManager(EntryPoint) end


