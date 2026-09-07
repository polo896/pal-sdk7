---@meta

---@class UBP_CannonDamageReactionComponent_C : UPalCannonDamageReactionComponent
---@field UberGraphFrame FPointerToUberGraphFrame
local UBP_CannonDamageReactionComponent_C = {}

function UBP_CannonDamageReactionComponent_C:PrintOnRepHP_BP() end
function UBP_CannonDamageReactionComponent_C:PrintCreateHPHUD_BP() end
---@param EntryPoint int32
function UBP_CannonDamageReactionComponent_C:ExecuteUbergraph_BP_CannonDamageReactionComponent(EntryPoint) end


