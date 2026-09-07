---@meta

---@class ABP_Action_Emote_KickCollision_C : AActor
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Sphere USphereComponent
---@field Hit FHitResult
---@field NewLocalVar USkeletalMeshComponent
local ABP_Action_Emote_KickCollision_C = {}

function ABP_Action_Emote_KickCollision_C:ReceiveBeginPlay() end
---@param HitComponent UPrimitiveComponent
---@param OtherActor AActor
---@param OtherComp UPrimitiveComponent
---@param NormalImpulse FVector
---@param Hit FHitResult
function ABP_Action_Emote_KickCollision_C:BndEvt__BP_Action_Emote_KickCollision_Sphere_K2Node_ComponentBoundEvent_1_ComponentHitSignature__DelegateSignature(HitComponent, OtherActor, OtherComp, NormalImpulse, Hit) end
---@param EntryPoint int32
function ABP_Action_Emote_KickCollision_C:ExecuteUbergraph_BP_Action_Emote_KickCollision(EntryPoint) end


