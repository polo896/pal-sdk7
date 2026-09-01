---@meta

---@class ABP_EnemyCampObject_Wood_Ladder_C : APalBuildObjectBasicBase
---@field EnemyCampObjectSpawnMapObject UPalEnemyCampObjectSpawnMapObjectComponent
---@field BP_InteractableBox UBP_InteractableBox_C
---@field AffectNavigationBox UBoxComponent
---@field BuildWorkableBounds UBoxComponent
---@field SM_Wall_Wood UStaticMeshComponent
---@field Root USceneComponent
---@field CheckOverlapCollision UBoxComponent
local ABP_EnemyCampObject_Wood_Ladder_C = {}

---@return float
function ABP_EnemyCampObject_Wood_Ladder_C:GetClimbMoveSpeedRate() end
---@return float
function ABP_EnemyCampObject_Wood_Ladder_C:GetConsumeStaminaSpeedRate() end
---@param OutComponents TArray<UStaticMeshComponent>
function ABP_EnemyCampObject_Wood_Ladder_C:GetStaticMeshComponents(OutComponents) end
---@param OutStaticMeshInfo TArray<FPalStaticMeshImposterStaticMeshInfo>
function ABP_EnemyCampObject_Wood_Ladder_C:GetStaticMeshInfos(OutStaticMeshInfo) end


