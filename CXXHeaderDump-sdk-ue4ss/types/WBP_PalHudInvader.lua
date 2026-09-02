---@meta

---@class UWBP_PalHudInvader_C : UPalUserWidgetWorldHUD
---@field UberGraphFrame FPointerToUberGraphFrame
---@field MI_Icon UImage
---@field CacheGroupId FGuid
local UWBP_PalHudInvader_C = {}

function UWBP_PalHudInvader_C:OnSetup() end
---@param DestroyedActor AActor
function UWBP_PalHudInvader_C:ParentDestroyEvent(DestroyedActor) end
---@param DeadInfo FPalDeadInfo
function UWBP_PalHudInvader_C:ParentDeadEvent(DeadInfo) end
---@param Parameter FPalIncidentBroadcastParameter
function UWBP_PalHudInvader_C:OnInvadeEnd(Parameter) end
---@param EntryPoint int32
function UWBP_PalHudInvader_C:ExecuteUbergraph_WBP_PalHudInvader(EntryPoint) end


