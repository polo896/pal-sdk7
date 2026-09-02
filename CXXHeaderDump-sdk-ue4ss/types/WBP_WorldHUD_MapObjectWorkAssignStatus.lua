---@meta

---@class UWBP_WorldHUD_MapObjectWorkAssignStatus_C : UPalUIMapObjectStatusIndicatorBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_PalWork_AccessPoint UWBP_PalWork_AccessPoint_C
---@field UIModel UPalWorkSlotHUDInfoUIModel
local UWBP_WorldHUD_MapObjectWorkAssignStatus_C = {}

function UWBP_WorldHUD_MapObjectWorkAssignStatus_C:SetupUI() end
function UWBP_WorldHUD_MapObjectWorkAssignStatus_C:ReadyUIModel() end
function UWBP_WorldHUD_MapObjectWorkAssignStatus_C:OnSetup() end
---@param EntryPoint int32
function UWBP_WorldHUD_MapObjectWorkAssignStatus_C:ExecuteUbergraph_WBP_WorldHUD_MapObjectWorkAssignStatus(EntryPoint) end


