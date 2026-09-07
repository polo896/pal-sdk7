---@meta

---@class UWBP_RaidBossAreaStatusWorldHUD_C : UPalUIMapObjectStatusIndicatorBase
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_Altar_Info UWBP_Altar_Info_C
---@field Cached_UIModel UPalUIMapObjectRaidBossAreaStatusModel
local UWBP_RaidBossAreaStatusWorldHUD_C = {}

function UWBP_RaidBossAreaStatusWorldHUD_C:ReflectCurrentRemaingTime() end
---@param InPhase EPalRaidBossAreaPhase
function UWBP_RaidBossAreaStatusWorldHUD_C:ReflectCurrentPhase(InPhase) end
---@param UIModel UPalUIMapObjectRaidBossAreaStatusModel
function UWBP_RaidBossAreaStatusWorldHUD_C:OnUpdatePhase(UIModel) end
---@param UIModel UPalUIMapObjectRaidBossAreaStatusModel
function UWBP_RaidBossAreaStatusWorldHUD_C:OnUpdateRaidBossStaticItemId(UIModel) end
---@return UPalUIMapObjectRaidBossAreaStatusModel
function UWBP_RaidBossAreaStatusWorldHUD_C:GetUIModel() end
function UWBP_RaidBossAreaStatusWorldHUD_C:Setup() end
function UWBP_RaidBossAreaStatusWorldHUD_C:OnSetup() end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_RaidBossAreaStatusWorldHUD_C:Tick(MyGeometry, InDeltaTime) end
---@param EntryPoint int32
function UWBP_RaidBossAreaStatusWorldHUD_C:ExecuteUbergraph_WBP_RaidBossAreaStatusWorldHUD(EntryPoint) end


