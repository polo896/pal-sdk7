---@meta

---@class UWBP_ExpeditionStatusWorldHUD_C : UPalUIMapObjectStatusIndicatorBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_PalWork_Expedition UWBP_PalWork_Expedition_C
---@field UIModel UPalUIMapObjectCharacterTeamMissionModel
---@field ConcreteModel UPalMapObjectConcreteModelBase
---@field LocationCheckTimerHandle FTimerHandle
---@field bAlreadySetup boolean
local UWBP_ExpeditionStatusWorldHUD_C = {}

function UWBP_ExpeditionStatusWorldHUD_C:OnTimer_LocationCheck() end
---@param LastState EPalMapObjectCharacterTeamMissionState
---@param CurrentState EPalMapObjectCharacterTeamMissionState
function UWBP_ExpeditionStatusWorldHUD_C:OnChangedMissionState(LastState, CurrentState) end
function UWBP_ExpeditionStatusWorldHUD_C:Setup() end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_ExpeditionStatusWorldHUD_C:Tick(MyGeometry, InDeltaTime) end
function UWBP_ExpeditionStatusWorldHUD_C:OnSetup() end
function UWBP_ExpeditionStatusWorldHUD_C:Destruct() end
function UWBP_ExpeditionStatusWorldHUD_C:Construct() end
---@param EntryPoint int32
function UWBP_ExpeditionStatusWorldHUD_C:ExecuteUbergraph_WBP_ExpeditionStatusWorldHUD(EntryPoint) end


