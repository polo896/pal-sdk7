---@meta

---@class UWBP_AssignBoard_PalSlot_Assigned_C : UUserWidget
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_AssignBoard_PalSlot UWBP_AssignBoard_PalSlot_C
local UWBP_AssignBoard_PalSlot_Assigned_C = {}

---@param Suitability EPalWorkSuitability
function UWBP_AssignBoard_PalSlot_Assigned_C:SetSuitability(Suitability) end
function UWBP_AssignBoard_PalSlot_Assigned_C:SetEmpty() end
---@param Parameter UPalIndividualCharacterParameter
function UWBP_AssignBoard_PalSlot_Assigned_C:SetIndividualParameter(Parameter) end
function UWBP_AssignBoard_PalSlot_Assigned_C:Construct() end
---@param EntryPoint int32
function UWBP_AssignBoard_PalSlot_Assigned_C:ExecuteUbergraph_WBP_AssignBoard_PalSlot_Assigned(EntryPoint) end


