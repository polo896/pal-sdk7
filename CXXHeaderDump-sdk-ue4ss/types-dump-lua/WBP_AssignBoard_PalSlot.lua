---@meta

---@class UWBP_AssignBoard_PalSlot_C : UWBP_PalCharacterSlotBase_C
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Image_Check UImage
---@field Image_FocusedFrame UImage
---@field Image_PalDying UImage
---@field Image_PalWorkShadow UImage
---@field Overlay_FixedAssign UOverlay
---@field Overlay_GenderIcon UOverlay
---@field Overlay_PalWork UOverlay
---@field WBP_IconPalWork UWBP_IconPalWork_C
---@field WBP_PalCommonCharacterIcon UWBP_PalCommonCharacterIcon_C
---@field WBP_PalGenderIcon UWBP_PalGenderIcon_C
---@field ReferemceWorkId FGuid
local UWBP_AssignBoard_PalSlot_C = {}

function UWBP_AssignBoard_PalSlot_C:OnSetIconEmpty_Binded() end
---@param Suitability EPalWorkSuitability
UWBP_AssignBoard_PalSlot_C['Set Suitability'] = function(self, Suitability) end
---@param WorkId FGuid
function UWBP_AssignBoard_PalSlot_C:SetReferenceWorkId(WorkId) end
---@param WorkId FGuid
---@param IsFixedAssign boolean
function UWBP_AssignBoard_PalSlot_C:OnUpdateWorkId_Binded(WorkId, IsFixedAssign) end
---@param NewVisibility ESlateVisibility
function UWBP_AssignBoard_PalSlot_C:SetVisibilityFixedAssignFrame(NewVisibility) end
---@param NewVisibility ESlateVisibility
function UWBP_AssignBoard_PalSlot_C:SetVisibilityGenderIcon(NewVisibility) end
function UWBP_AssignBoard_PalSlot_C:OnSetValidSlot_Binded() end
function UWBP_AssignBoard_PalSlot_C:OnSetEmpty_Binded() end
---@param nowHP int64
---@param nowMaxHP int64
function UWBP_AssignBoard_PalSlot_C:OnUpdateHP_Binded(nowHP, nowMaxHP) end
---@param NewVisibility ESlateVisibility
function UWBP_AssignBoard_PalSlot_C:SetVisibilityCheck(NewVisibility) end
---@param NewVisibility ESlateVisibility
UWBP_AssignBoard_PalSlot_C['Set Visibility Focus Frame'] = function(self, NewVisibility) end
---@param IconWidget UWBP_PalCharacterIconBase_C
function UWBP_AssignBoard_PalSlot_C:RegisterCharacterIconWidget(IconWidget) end
function UWBP_AssignBoard_PalSlot_C:OnInitialized() end
function UWBP_AssignBoard_PalSlot_C:Destruct() end
---@param EntryPoint int32
function UWBP_AssignBoard_PalSlot_C:ExecuteUbergraph_WBP_AssignBoard_PalSlot(EntryPoint) end


