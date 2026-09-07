---@meta

---@class ABP_BuildObject_Wood_Wall_V2_C : APalBuildObjectBasicBase
---@field BP_BuildObjectSimulateArrowComponent UBP_BuildObjectSimulateArrowComponent_C
---@field BP_InteractableBox UBP_InteractableBox_C
---@field AffectNavigationBox UBoxComponent
---@field BuildWorkableBounds UBoxComponent
---@field SM_Wall_Wood UStaticMeshComponent
---@field Root USceneComponent
---@field CheckOverlapCollision UBoxComponent
local ABP_BuildObject_Wood_Wall_V2_C = {}

---@param OutComponents TArray<UStaticMeshComponent>
function ABP_BuildObject_Wood_Wall_V2_C:GetStaticMeshComponents(OutComponents) end
---@param OutStaticMeshInfo TArray<FPalStaticMeshImposterStaticMeshInfo>
function ABP_BuildObject_Wood_Wall_V2_C:GetStaticMeshInfos(OutStaticMeshInfo) end


