---@meta

---@class ABP_Arrow_Poision_C : ABP_Arrow_C
---@field UberGraphFrame FPointerToUberGraphFrame
local ABP_Arrow_Poision_C = {}

---@param Value int32
function ABP_Arrow_Poision_C:GetEffectValue(Value) end
---@param Effect EPalAdditionalEffectType
function ABP_Arrow_Poision_C:GetEffectType(Effect) end
function ABP_Arrow_Poision_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_Arrow_Poision_C:ExecuteUbergraph_BP_Arrow_Poision(EntryPoint) end


