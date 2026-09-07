---@meta

---@class ABP_SkillEffect_ThunderRain_Cloud_C : ABP_SkillEffectBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field ThunderCount int32
---@field ThunderInterval float
---@field MaxThunderCount int32
---@field MaxThunderDistance double
---@field ThunderTimer FTimerHandle
---@field ['Out Point Array'] TArray<FVector2D>
---@field ['Target Location'] FVector
local ABP_SkillEffect_ThunderRain_Cloud_C = {}

---@param Vector2D FVector2D
function ABP_SkillEffect_ThunderRain_Cloud_C:Vector2DByQuadrantSwitcher(Vector2D) end
function ABP_SkillEffect_ThunderRain_Cloud_C:ReceiveBeginPlay() end
function ABP_SkillEffect_ThunderRain_Cloud_C:CreateThunder() end
---@param TargetLocation FVector
function ABP_SkillEffect_ThunderRain_Cloud_C:SetThunderLocations(TargetLocation) end
---@param EntryPoint int32
function ABP_SkillEffect_ThunderRain_Cloud_C:ExecuteUbergraph_BP_SkillEffect_ThunderRain_Cloud(EntryPoint) end


