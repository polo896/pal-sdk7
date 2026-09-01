---@meta

---@class UWBP_Ingame_InteractMultiplayModifier_C : UPalUIBuildMultiplayModifierHUD
---@field UberGraphFrame FPointerToUberGraphFrame
---@field UserNameTextBlock UTextBlock
local UWBP_Ingame_InteractMultiplayModifier_C = {}

function UWBP_Ingame_InteractMultiplayModifier_C:OnSetup() end
function UWBP_Ingame_InteractMultiplayModifier_C:OnUpdateLastModifiedUserName() end
---@param EntryPoint int32
function UWBP_Ingame_InteractMultiplayModifier_C:ExecuteUbergraph_WBP_Ingame_InteractMultiplayModifier(EntryPoint) end


