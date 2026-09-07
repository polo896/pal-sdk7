---@meta

---@class UWBP_Arena_PalSelect_Ready_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_Select UWidgetAnimation
---@field Anm_Ready UWidgetAnimation
---@field BP_PalTextBlock_PalCount UBP_PalTextBlock_C
local UWBP_Arena_PalSelect_Ready_C = {}

---@param Current int32
---@param Max int32
function UWBP_Arena_PalSelect_Ready_C:SetPalCount(Current, Max) end
function UWBP_Arena_PalSelect_Ready_C:Ready() end
---@param EntryPoint int32
function UWBP_Arena_PalSelect_Ready_C:ExecuteUbergraph_WBP_Arena_PalSelect_Ready(EntryPoint) end


