---@meta

---@class UWBP_Arena_PalSelect_PalSlot_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Select UWidgetAnimation
---@field Anm_Default UWidgetAnimation
---@field WBP_PalCommonCharacterIcon UWBP_PalCommonCharacterIcon_C
---@field ['Character Id'] FName
local UWBP_Arena_PalSelect_PalSlot_C = {}

---@param CharacterParameter UPalIndividualCharacterParameter
function UWBP_Arena_PalSelect_PalSlot_C:SetPalIcon(CharacterParameter) end
---@param IsSetting boolean
function UWBP_Arena_PalSelect_PalSlot_C:SetNowSetting(IsSetting) end
---@param EntryPoint int32
function UWBP_Arena_PalSelect_PalSlot_C:ExecuteUbergraph_WBP_Arena_PalSelect_PalSlot(EntryPoint) end


