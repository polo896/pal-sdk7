---@meta

---@class UWBP_Arena_SoloEntry_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field Anm_In UWidgetAnimation
---@field WBP_Arena_SoloEntryButton UWBP_Arena_SoloEntryButton_C
---@field WBP_Arena_SoloEntryButton_1 UWBP_Arena_SoloEntryButton_C
---@field WBP_Arena_SoloEntryButton_2 UWBP_Arena_SoloEntryButton_C
---@field WBP_Arena_SoloEntryButton_3 UWBP_Arena_SoloEntryButton_C
---@field WBP_Arena_SoloEntryButton_4 UWBP_Arena_SoloEntryButton_C
---@field WBP_Arena_SoloEntryButton_5 UWBP_Arena_SoloEntryButton_C
---@field WBP_Arena_SoloEntryButton_6 UWBP_Arena_SoloEntryButton_C
---@field EntryButtons TArray<UWBP_Arena_SoloEntryButton_C>
---@field CurrentSelectRank EPalArenaRank
---@field LastHoveredEntry UWBP_Arena_SoloEntryButton_C
local UWBP_Arena_SoloEntry_C = {}

---@param Button UWBP_Arena_SoloEntryButton_C
function UWBP_Arena_SoloEntry_C:OnEntryHovered(Button) end
---@param Button UWBP_Arena_SoloEntryButton_C
function UWBP_Arena_SoloEntry_C:OnEntryUnhovered(Button) end
function UWBP_Arena_SoloEntry_C:Setup() end
---@return UWidget
function UWBP_Arena_SoloEntry_C:BP_GetDesiredFocusTarget() end
function UWBP_Arena_SoloEntry_C:Finished_6E03AF144B8AC540362D31A1A74FC2B5() end
function UWBP_Arena_SoloEntry_C:Finished_A8F632BC4656B439BE29FC9AA565281B() end
function UWBP_Arena_SoloEntry_C:OnInitialized() end
function UWBP_Arena_SoloEntry_C:Construct() end
function UWBP_Arena_SoloEntry_C:OnSetup() end
---@param ArenaRank EPalArenaRank
function UWBP_Arena_SoloEntry_C:OnSelectSoloEntry(ArenaRank) end
function UWBP_Arena_SoloEntry_C:CancelAction() end
---@param IsYes boolean
function UWBP_Arena_SoloEntry_C:OnConfirmSolo(IsYes) end
---@param EntryPoint int32
function UWBP_Arena_SoloEntry_C:ExecuteUbergraph_WBP_Arena_SoloEntry(EntryPoint) end


