---@meta

---@class UWBP_Title_TermsWindow_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field WBP_CommonButton UWBP_CommonButton_C
---@field WBP_CommonButton_Terms UWBP_CommonButton_1_C
---@field WBP_PalCommonWindow UWBP_PalCommonWindow_C
local UWBP_Title_TermsWindow_C = {}

---@return UWidget
function UWBP_Title_TermsWindow_C:BP_GetDesiredFocusTarget() end
function UWBP_Title_TermsWindow_C:OnSetup() end
function UWBP_Title_TermsWindow_C:BndEvt__WBP_Title_TermsWindow_WBP_CommonButton_K2Node_ComponentBoundEvent_0_OnClicked__DelegateSignature() end
function UWBP_Title_TermsWindow_C:Construct() end
---@param IsDesignTime boolean
function UWBP_Title_TermsWindow_C:PreConstruct(IsDesignTime) end
function UWBP_Title_TermsWindow_C:BndEvt__WBP_Title_TermsWindow_WBP_CommonButton_Terms_K2Node_ComponentBoundEvent_1_OnClicked__DelegateSignature() end
function UWBP_Title_TermsWindow_C:OnInitialized() end
---@param EntryPoint int32
function UWBP_Title_TermsWindow_C:ExecuteUbergraph_WBP_Title_TermsWindow(EntryPoint) end


