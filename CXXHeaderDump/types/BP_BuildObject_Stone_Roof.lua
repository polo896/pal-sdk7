---@meta

---@class ABP_BuildObject_Stone_Roof_C : APalBuildObjectBasicBase
---@field BP_InteractableBox UBP_InteractableBox_C
---@field SM_Roof_Stone UStaticMeshComponent
---@field CheckOverlapCollision UBoxComponent
---@field Root USceneComponent
local ABP_BuildObject_Stone_Roof_C = {}

---@param OutComponents TArray<UStaticMeshComponent>
function ABP_BuildObject_Stone_Roof_C:GetStaticMeshComponents(OutComponents) end
---@param OutStaticMeshInfo TArray<FPalStaticMeshImposterStaticMeshInfo>
function ABP_BuildObject_Stone_Roof_C:GetStaticMeshInfos(OutStaticMeshInfo) end


