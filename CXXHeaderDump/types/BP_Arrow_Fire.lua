---@meta

---@class ABP_Arrow_Fire_C : ABP_Arrow_C
---@field UberGraphFrame FPointerToUberGraphFrame
local ABP_Arrow_Fire_C = {}

---@param Value int32
function ABP_Arrow_Fire_C:GetEffectValue(Value) end
---@param Effect EPalAdditionalEffectType
function ABP_Arrow_Fire_C:GetEffectType(Effect) end
---@param NewParam EPalElementType
function ABP_Arrow_Fire_C:GetBulletElementType(NewParam) end
function ABP_Arrow_Fire_C:ReceiveBeginPlay() end
---@param EntryPoint int32
function ABP_Arrow_Fire_C:ExecuteUbergraph_BP_Arrow_Fire(EntryPoint) end


