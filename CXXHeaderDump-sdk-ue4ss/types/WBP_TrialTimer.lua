---@meta

---@class UWBP_TrialTimer_C : UPalUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field BP_PalTextBlock_C_68 UBP_PalTextBlock_C
local UWBP_TrialTimer_C = {}

---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_TrialTimer_C:Tick(MyGeometry, InDeltaTime) end
---@param EntryPoint int32
function UWBP_TrialTimer_C:ExecuteUbergraph_WBP_TrialTimer(EntryPoint) end


