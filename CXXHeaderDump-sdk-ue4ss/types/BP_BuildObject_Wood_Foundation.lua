---@meta

---@class ABP_BuildObject_Wood_Foundation_C : APalBuildObjectBasicBase
---@field BP_InteractableBox UBP_InteractableBox_C
---@field BuildWorkableBounds UBoxComponent
---@field SM_Floor_Wood UStaticMeshComponent
---@field CheckOverlapCollision UBoxComponent
---@field Root USceneComponent
local ABP_BuildObject_Wood_Foundation_C = {}

---@param OutComponents TArray<UStaticMeshComponent>
function ABP_BuildObject_Wood_Foundation_C:GetStaticMeshComponents(OutComponents) end
---@param OutStaticMeshInfo TArray<FPalStaticMeshImposterStaticMeshInfo>
function ABP_BuildObject_Wood_Foundation_C:GetStaticMeshInfos(OutStaticMeshInfo) end


