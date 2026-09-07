---@meta

---@class ABP_BuildObject_Wood_Stair_C : APalBuildObjectBasicBase
---@field BP_InteractableBox UBP_InteractableBox_C
---@field SM_Stair_Wood UStaticMeshComponent
---@field CheckOverlapCollision UBoxComponent
---@field Root USceneComponent
local ABP_BuildObject_Wood_Stair_C = {}

---@param OutComponents TArray<UStaticMeshComponent>
function ABP_BuildObject_Wood_Stair_C:GetStaticMeshComponents(OutComponents) end
---@param OutStaticMeshInfo TArray<FPalStaticMeshImposterStaticMeshInfo>
function ABP_BuildObject_Wood_Stair_C:GetStaticMeshInfos(OutStaticMeshInfo) end


