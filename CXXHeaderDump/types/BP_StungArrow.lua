---@meta

---@class ABP_StungArrow_C : AActor
---@field UberGraphFrame FPointerToUberGraphFrame
---@field SkeletalMesh USkeletalMeshComponent
---@field DefaultSceneRoot USceneComponent
---@field AttachMesh USkeletalMeshComponent
local ABP_StungArrow_C = {}

---@param AttachMeshComponent USkeletalMeshComponent
ABP_StungArrow_C['Set Attach Mesh'] = function(self, AttachMeshComponent) end
---@param DeltaSeconds float
function ABP_StungArrow_C:ReceiveTick(DeltaSeconds) end
---@param EntryPoint int32
function ABP_StungArrow_C:ExecuteUbergraph_BP_StungArrow(EntryPoint) end


