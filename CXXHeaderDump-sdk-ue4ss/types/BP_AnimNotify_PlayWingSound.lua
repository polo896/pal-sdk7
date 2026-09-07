---@meta

---@class UBP_AnimNotify_PlayWingSound_C : UBP_AnimNotify_PlaySound_C
---@field ['Switch Group'] FString
local UBP_AnimNotify_PlayWingSound_C = {}

---@param Pal APalMonsterCharacter
---@param PalSize FString
function UBP_AnimNotify_PlayWingSound_C:MakeSwitchStatePalSize(Pal, PalSize) end
---@param MeshComp USkeletalMeshComponent
---@param Animation UAnimSequenceBase
---@param EventReference FAnimNotifyEventReference
---@return boolean
function UBP_AnimNotify_PlayWingSound_C:Received_Notify(MeshComp, Animation, EventReference) end


