---@meta

---@class ABP_TreasureBoxVisual_OilrigGoal_C : ABP_TreasureBoxVisual_Base_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field PointLight UPointLightComponent
local ABP_TreasureBoxVisual_OilrigGoal_C = {}

function ABP_TreasureBoxVisual_OilrigGoal_C:ReceiveBeginPlay() end
function ABP_TreasureBoxVisual_OilrigGoal_C:OnFinishOpenAnimation() end
function ABP_TreasureBoxVisual_OilrigGoal_C:StartOpenAnimation() end
---@param EntryPoint int32
function ABP_TreasureBoxVisual_OilrigGoal_C:ExecuteUbergraph_BP_TreasureBoxVisual_OilrigGoal(EntryPoint) end


