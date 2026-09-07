---@meta

---@class UWBP_WebBrowser_News_C : UPalUserWidgetOverlayUI
---@field UberGraphFrame FPointerToUberGraphFrame
---@field CanvasPanel UCanvasPanel
---@field CanvasPanel_72 UCanvasPanel
---@field Overlay_0 UOverlay
---@field WBP_CommonButton UWBP_CommonButton_C
---@field WBP_Menu_btn UWBP_Menu_btn_C
---@field RightAnalogStickValue double
---@field PadInputMaxScrollSpeed double
---@field WebBrowserWidget UWebBrowser
local UWBP_WebBrowser_News_C = {}

---@param MyGeometry FGeometry
---@param InAnalogInputEvent FAnalogInputEvent
---@return FEventReply
function UWBP_WebBrowser_News_C:OnAnalogValueChanged(MyGeometry, InAnalogInputEvent) end
---@param URL FString
---@param Frame FString
function UWBP_WebBrowser_News_C:OnBeforePopup_Event(URL, Frame) end
---@return UWidget
function UWBP_WebBrowser_News_C:BP_GetDesiredFocusTarget() end
function UWBP_WebBrowser_News_C:Construct() end
---@param MyGeometry FGeometry
---@param InDeltaTime float
function UWBP_WebBrowser_News_C:Tick(MyGeometry, InDeltaTime) end
function UWBP_WebBrowser_News_C:BndEvt__WBP_WebBrowserTest_WBP_Menu_btn_K2Node_ComponentBoundEvent_0_OnButtonClicked__DelegateSignature() end
function UWBP_WebBrowser_News_C:BndEvt__WBP_WebBrowser_News_WBP_CommonButton_K2Node_ComponentBoundEvent_1_OnClicked__DelegateSignature() end
function UWBP_WebBrowser_News_C:Destruct() end
---@param EntryPoint int32
function UWBP_WebBrowser_News_C:ExecuteUbergraph_WBP_WebBrowser_News(EntryPoint) end


