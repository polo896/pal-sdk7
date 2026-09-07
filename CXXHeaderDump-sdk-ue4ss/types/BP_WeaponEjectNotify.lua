---@meta

---@class UBP_WeaponEjectNotify_C : UAnimNotify
---@field EjectCasing TSubclassOf<AActor>
local UBP_WeaponEjectNotify_C = {}

---@param MeshComp USkeletalMeshComponent
---@param Animation UAnimSequenceBase
---@param EventReference FAnimNotifyEventReference
---@return boolean
function UBP_WeaponEjectNotify_C:Received_Notify(MeshComp, Animation, EventReference) end


