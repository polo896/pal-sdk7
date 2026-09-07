---@meta

---@class ABP_GeroBeamAttackCollision_C : AActor
---@field UberGraphFrame FPointerToUberGraphFrame
---@field NiagaraBeam UNiagaraComponent
---@field StaticMesh UStaticMeshComponent
---@field Capsule UCapsuleComponent
---@field DefaultSceneRoot USceneComponent
local ABP_GeroBeamAttackCollision_C = {}

---@param Active boolean
function ABP_GeroBeamAttackCollision_C:ActivateCollision(Active) end
---@param Length double
function ABP_GeroBeamAttackCollision_C:SetLength(Length) end
---@param Capsule UCapsuleComponent
function ABP_GeroBeamAttackCollision_C:GetCollision(Capsule) end
function ABP_GeroBeamAttackCollision_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_GeroBeamAttackCollision_C:ExecuteUbergraph_BP_GeroBeamAttackCollision(EntryPoint) end


