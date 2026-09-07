---@meta

---@class UWBP_GPSPalCompareWindow_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_IngameMenu_PalCompare UWBP_IngameMenu_PalCompare_C
local UWBP_GPSPalCompareWindow_C = {}

---@return UWidget
function UWBP_GPSPalCompareWindow_C:BP_GetDesiredFocusTarget() end
function UWBP_GPSPalCompareWindow_C:OnSetup() end
function UWBP_GPSPalCompareWindow_C:BndEvt__WBP_GPSPalCompareWindow_WBP_IngameMenu_PalCompare_K2Node_ComponentBoundEvent_0_OnClickedConfirm__DelegateSignature() end
function UWBP_GPSPalCompareWindow_C:BndEvt__WBP_GPSPalCompareWindow_WBP_IngameMenu_PalCompare_K2Node_ComponentBoundEvent_1_OnClickedCancel__DelegateSignature() end
---@param EntryPoint int32
function UWBP_GPSPalCompareWindow_C:ExecuteUbergraph_WBP_GPSPalCompareWindow(EntryPoint) end


